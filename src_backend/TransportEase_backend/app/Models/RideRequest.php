<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Clickbar\Magellan\Database\Eloquent\HasPostgisColumns;

class RideRequest extends Model
{
    use HasFactory;
    use HasPostgisColumns;


    protected $fillable = [
        'car_details',
        'car_plates',
        'destination_location',
        'destination_address',
        'destination_place',
        'driver_id',
        'driver_location',
        'driver_name',
        'driver_phone',
        'fare',
        'payment_method',
        'pickup_location',
        'pickup_address',
        'pickup_place',
        'rider_name',
        'rider_phone',
        'status'
    ];

    protected array $postgisColumns = [
        'destination_location' => [
            'type' => 'geography',
            'srid' => 4326,
        ],
        'driver_location' => [
            'type' => 'geography',
            'srid' => 4326,
        ],
        'pickup_location' => [
            'type' => 'geography',
            'srid' => 4326,
        ],
    ];
}



