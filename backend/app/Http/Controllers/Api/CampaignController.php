<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Campaign;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CampaignController extends Controller
{
    /**
     * Display a listing of campaigns.
     */
    public function index(Request $request)
    {
        $query = Campaign::with('owner');

        // Filter by status
        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        // Filter by campaign type
        if ($request->has('campaign_type')) {
            $query->where('campaign_type', $request->campaign_type);
        }

        // Filter by date range
        if ($request->has('start_date')) {
            $query->where('start_date', '>=', $request->start_date);
        }
        if ($request->has('end_date')) {
            $query->where('end_date', '<=', $request->end_date);
        }

        // Search by title
        if ($request->has('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }

        $campaigns = $query->orderBy('created_at', 'desc')->paginate(20);

        return response()->json($campaigns);
    }

    /**
     * Store a newly created campaign.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'campaign_type' => 'required|string',
            'objective' => 'nullable|string',
            'status' => 'nullable|in:draft,active,paused,completed,cancelled',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'budget' => 'nullable|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $campaign = Campaign::create([
            'title' => $request->title,
            'campaign_type' => $request->campaign_type,
            'objective' => $request->objective,
            'status' => $request->status ?? 'draft',
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'budget' => $request->budget ?? 0,
            'owner_id' => auth()->id(),
        ]);

        return response()->json([
            'message' => 'Campaign created successfully',
            'data' => $campaign->load('owner')
        ], 201);
    }

    /**
     * Display the specified campaign.
     */
    public function show($id)
    {
        $campaign = Campaign::with(['owner'])->find($id);

        if (!$campaign) {
            return response()->json([
                'message' => 'Campaign not found'
            ], 404);
        }

        // Get campaign tasks count
        $tasksCount = \App\Models\Task::where('campaign_id', $id)->count();
        $completedTasksCount = \App\Models\Task::where('campaign_id', $id)
            ->where('status', 'completed')
            ->count();

        $campaign->tasks_count = $tasksCount;
        $campaign->completed_tasks_count = $completedTasksCount;
        $campaign->progress = $tasksCount > 0
            ? round(($completedTasksCount / $tasksCount) * 100, 2)
            : 0;

        return response()->json($campaign);
    }

    /**
     * Update the specified campaign.
     */
    public function update(Request $request, $id)
    {
        $campaign = Campaign::find($id);

        if (!$campaign) {
            return response()->json([
                'message' => 'Campaign not found'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'title' => 'sometimes|required|string|max:255',
            'campaign_type' => 'sometimes|required|string',
            'objective' => 'nullable|string',
            'status' => 'nullable|in:draft,active,paused,completed,cancelled',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'budget' => 'nullable|numeric|min:0',
            'result_summary' => 'nullable|array',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $campaign->update($request->only([
            'title',
            'campaign_type',
            'objective',
            'status',
            'start_date',
            'end_date',
            'budget',
            'result_summary',
        ]));

        return response()->json([
            'message' => 'Campaign updated successfully',
            'data' => $campaign->load('owner')
        ]);
    }

    /**
     * Remove the specified campaign.
     */
    public function destroy($id)
    {
        $campaign = Campaign::find($id);

        if (!$campaign) {
            return response()->json([
                'message' => 'Campaign not found'
            ], 404);
        }

        $campaign->delete();

        return response()->json([
            'message' => 'Campaign deleted successfully'
        ]);
    }

    /**
     * Get campaign statistics.
     */
    public function statistics($id)
    {
        $campaign = Campaign::find($id);

        if (!$campaign) {
            return response()->json([
                'message' => 'Campaign not found'
            ], 404);
        }

        $tasks = \App\Models\Task::where('campaign_id', $id)->get();

        $stats = [
            'total_tasks' => $tasks->count(),
            'completed_tasks' => $tasks->where('status', 'completed')->count(),
            'in_progress_tasks' => $tasks->where('status', 'in_progress')->count(),
            'pending_tasks' => $tasks->where('status', 'pending')->count(),
            'high_priority_tasks' => $tasks->where('priority', 'high')->count(),
            'budget' => $campaign->budget,
            'progress_percentage' => $tasks->count() > 0
                ? round(($tasks->where('status', 'completed')->count() / $tasks->count()) * 100, 2)
                : 0,
        ];

        return response()->json($stats);
    }
}
