<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ClientController;
use App\Http\Controllers\Api\CampaignController;
use App\Http\Controllers\Api\EvaluationController;
use App\Http\Controllers\Api\FieldReportController;
use App\Http\Controllers\Api\SyncController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Public Routes
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/change-password', [AuthController::class, 'changePassword']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Clients
    Route::apiResource('clients', ClientController::class);
    Route::apiResource('client_employees', \App\Http\Controllers\Api\ClientEmployeeController::class);


    // Campaigns
    Route::apiResource('campaigns', CampaignController::class);
    Route::get('campaigns/{id}/statistics', [CampaignController::class, 'statistics']);

    // Evaluations
    Route::apiResource('evaluations', EvaluationController::class);
    Route::get('evaluation-templates', [EvaluationController::class, 'templates']);
    Route::get('evaluations/{type}/{id}', [EvaluationController::class, 'forEntity']);

    // Field Reports
    Route::apiResource('field-reports', FieldReportController::class);
    Route::delete('field-reports/{id}/photos', [FieldReportController::class, 'deletePhoto']);

    // Sync
    Route::post('sync/push', [SyncController::class, 'push']);
    Route::get('sync/pull', [SyncController::class, 'pull']);
    Route::post('sync/resolve-conflict', [SyncController::class, 'resolveConflict']);

    // Upload
    Route::post('upload', [\App\Http\Controllers\Api\UploadController::class, 'upload']);
});
