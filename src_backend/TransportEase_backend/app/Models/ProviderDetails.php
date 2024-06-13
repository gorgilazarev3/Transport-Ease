<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProviderDetails extends Model
{
    use HasFactory;

    protected $fillable = [
        'driver_id',
        'license_plate',
        'car_model',
        'car_color',
        'taxi_company_name',
        'provider_type',
        'routes_type',
        'taxi_car_seats',
        'provider_seats',
        'carrier_capacity',

    ];
}
