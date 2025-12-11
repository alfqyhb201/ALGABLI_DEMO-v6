<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Client;
use Illuminate\Http\Request;

class ClientController extends Controller
{
    public function index()
    {
        // $user = auth()->user();

        // If user is admin (you might want to check role here), return all
        // For now, let's assume if they have a specific permission or role they see all
        // But based on request "clients associated with the employee", we filter:

        return Client::all();
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'nullable', // Can be string or array
            'email' => 'nullable|email',
            'category' => 'nullable|string',
            'province' => 'nullable|string',
            'district' => 'nullable|string',
            'address' => 'nullable|string',
            'gps_location' => 'nullable|string',
            'importance' => 'nullable|string',
            'is_agent' => 'boolean',
            'loyalty_level' => 'nullable|string',
            'notes' => 'nullable|string',
            'parent_id' => 'nullable|exists:clients,id',
            'type' => 'nullable|string',
            'status' => 'nullable|string',
            'classification_id' => 'nullable|integer',
            'images' => 'nullable', // Can be array or string
            'profile_image' => 'nullable|string',
        ]);

        // Handle phone if it comes as array from Flutter
        if (isset($validated['phone']) && is_array($validated['phone'])) {
            $validated['phone'] = json_encode($validated['phone']);
        }

        $validated['created_by'] = $request->user()->id;
        $client = Client::create($validated);

        return response()->json($client, 201);
    }

    public function show(Client $client)
    {
        return $client->load(['employees', 'parent', 'children']);
    }

    public function update(Request $request, Client $client)
    {
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'phone' => 'nullable',
            'email' => 'nullable|email',
            'category' => 'nullable|string',
            'province' => 'nullable|string',
            'district' => 'nullable|string',
            'address' => 'nullable|string',
            'gps_location' => 'nullable|string',
            'importance' => 'nullable|string',
            'is_agent' => 'boolean',
            'loyalty_level' => 'nullable|string',
            'notes' => 'nullable|string',
            'parent_id' => 'nullable|exists:clients,id',
            'type' => 'nullable|string',
            'status' => 'nullable|string',
            'classification_id' => 'nullable|integer',
            'images' => 'sometimes|nullable',
            'profile_image' => 'sometimes|nullable|string',
        ]);

        if (isset($validated['phone']) && is_array($validated['phone'])) {
            $validated['phone'] = json_encode($validated['phone']);
        }

        $client->update($validated);

        return response()->json($client);
    }

    public function destroy(Client $client)
    {
        $client->delete();

        return response()->json(null, 204);
    }
}
