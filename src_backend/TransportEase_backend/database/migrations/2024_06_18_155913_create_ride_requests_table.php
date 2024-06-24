<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('ride_requests', function (Blueprint $table) {
            $table->increments('id');
            $table->string('car_details')->nullable();
            $table->string('car_plates')->nullable();
            $table->point('destination_location')->nullable();
            $table->string('destination_address')->nullable();
            $table->string('destination_place')->nullable();
            $table->string('driver_id')->nullable();
            $table->point('driver_location')->nullable();
            $table->string('driver_name')->nullable();
            $table->string('driver_phone')->nullable();
            $table->integer('fare')->nullable();
            $table->string('payment_method')->nullable();
            $table->point('pickup_location')->nullable();
            $table->string('pickup_address')->nullable();
            $table->string('pickup_place')->nullable();
            $table->string('ride_type')->nullable();
            $table->string('rider_name')->nullable();
            $table->string('rider_phone')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ride_requests');
    }
};
