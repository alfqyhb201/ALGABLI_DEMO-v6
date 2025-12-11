<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index()
    {
        return Task::all();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'required|string',
            'priority' => 'required|string',
            'start_at' => 'nullable|date',
            'due_at' => 'nullable|date',
            'assignee_id' => 'nullable|exists:users,id',
            'campaign_id' => 'nullable|exists:campaigns,id',
            'client_id' => 'nullable|exists:clients,id',
            'location' => 'nullable|string',
            'attachments' => 'nullable|array',
            'parent_task_id' => 'nullable|exists:tasks,id',
            'progress_percentage' => 'nullable|integer|min:0|max:100',
            'uuid' => 'nullable|string',
            'sync_status' => 'nullable|string',
            'created_by' => 'nullable|exists:users,id',
        ]);

        $task = Task::create($validated);

        return response()->json($task, 201);
    }

    public function show(Task $task)
    {
        return $task;
    }

    public function update(Request $request, Task $task)
    {
        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'sometimes|required|string',
            'priority' => 'sometimes|required|string',
            'start_at' => 'nullable|date',
            'due_at' => 'nullable|date',
            'assignee_id' => 'nullable|exists:users,id',
            'campaign_id' => 'nullable|exists:campaigns,id',
            'client_id' => 'nullable|exists:clients,id',
            'location' => 'nullable|string',
            'attachments' => 'nullable|array',
            'parent_task_id' => 'nullable|exists:tasks,id',
            'progress_percentage' => 'nullable|integer|min:0|max:100',
            'uuid' => 'nullable|string',
            'sync_status' => 'nullable|string',
            'created_by' => 'nullable|exists:users,id',
        ]);

        $task->update($validated);

        return response()->json($task);
    }

    public function destroy(Task $task)
    {
        $task->delete();

        return response()->json(null, 204);
    }
}
