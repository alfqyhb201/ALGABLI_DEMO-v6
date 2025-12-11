<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Client extends Model
{
    use HasFactory, \Spatie\Permission\Traits\HasRoles;

    protected $fillable = [
        'name',
        'phone',
        'email',
        'category',
        'agent_id',
        'branch_id',
        'address',
        'gps_location',
        'images',
        'profile_image',
        'importance',
        'province',
        'district',
        'notes',
        'is_agent',
        'last_visit',
        'loyalty_level',
        'created_by',
        'parent_id',
        'type',
        'status',
        'classification_id',
    ];

    protected $casts = [
        'is_agent' => 'boolean',
        // 'phone' => 'array', // Handled by accessor
        'images' => 'array',
        'last_visit' => 'datetime',
        'gps_location' => 'array',
    ];

    protected function phone(): \Illuminate\Database\Eloquent\Casts\Attribute
    {
        return \Illuminate\Database\Eloquent\Casts\Attribute::make(
            get: function ($value) {
                if (empty($value)) {
                    return [];
                }

                // Try to decode JSON
                $decoded = json_decode($value, true);

                // If it's a valid JSON array, return it
                if (json_last_error() === JSON_ERROR_NONE && is_array($decoded)) {
                    // Ensure it's a flat array of strings
                    return array_map(function ($item) {
                        return is_array($item) ? ($item['number'] ?? '') : $item;
                    }, $decoded);
                }

                // Otherwise, treat it as a legacy single phone number and wrap it
                return [$value];
            },
            set: fn($value) => json_encode($value),
        );
    }

    // Relationships
    public function createdBy(): \Illuminate\Database\Eloquent\Relations\BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    protected static function booted(): void
    {
        static::creating(function (Client $client) {
            if (Auth::check()) {
                $client->created_by = Auth::id();
            }
        });
    }

    public function agent()
    {
        return $this->belongsTo(Agent::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
    public function evaluations(): \Illuminate\Database\Eloquent\Relations\MorphMany
    {
        return $this->morphMany(Evaluation::class, 'evaluable');
    }

    public function parent()
    {
        return $this->belongsTo(Client::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Client::class, 'parent_id');
    }

    public function employees()
    {
        return $this->hasMany(ClientEmployee::class);
    }
}
