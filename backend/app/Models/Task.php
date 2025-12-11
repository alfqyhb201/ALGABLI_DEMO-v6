<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Task extends Model
{
    use HasFactory, SoftDeletes, HasUuids;

    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'title',
        'description',
        'status',
        'priority',
        'start_at',
        'due_at',
        'assignee_id',
        'campaign_id',
        'client_id',
        'location',
        'attachments',
        'parent_task_id',
        'progress_percentage',
        'uuid',
        'sync_status',
        'created_by',
    ];

    protected $casts = [
        'start_at' => 'datetime',
        'due_at' => 'datetime',
        'attachments' => 'array',
        'progress_percentage' => 'integer',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (empty($model->uuid)) {
                $model->uuid = (string) Str::uuid();
            }
        });
    }

    public function assignees()
    {
        return $this->belongsToMany(User::class, 'task_user');
    }

    public function campaign()
    {
        return $this->belongsTo(Campaign::class);
    }

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function parentTask()
    {
        return $this->belongsTo(Task::class, 'parent_task_id');
    }

    public function subTasks()
    {
        return $this->hasMany(Task::class, 'parent_task_id');
    }
    public function evaluations(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(Evaluation::class, 'evaluable');
    }
}
