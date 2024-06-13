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
        Schema::create('provider_details', function (Blueprint $table) {
            $table->increments('id');
            $table->foreignId('driver_id')->references('id')->on('drivers');
            $table->string('license_plate')->nullable();
            $table->string('car_color')->nullable();
            $table->string('car_model')->nullable();
            $table->string('taxi_company_name')->nullable();
            $table->string('provider_type')->nullable();
            $table->string('routes_type')->nullable();
            $table->integer('taxi_car_seats')->nullable();
            $table->integer('provider_seats')->nullable();
            $table->integer('carrier_capacity')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('provider_details');
    }
};
