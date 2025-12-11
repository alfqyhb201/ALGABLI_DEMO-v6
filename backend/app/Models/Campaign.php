<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Campaign extends Model
{
    use HasFactory, SoftDeletes, HasUuids;

    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'code',
        'title',
        'campaign_type',
        'objective',
        'status',
        'start_date',
        'end_date',
        'budget',
        'owner_id',
        'result_summary',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'budget' => 'decimal:2',
        'result_summary' => 'array',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (empty($model->code)) {
                $model->code = 'CMP-' . strtoupper(Str::random(8));
            }
        });
    }

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }
}
