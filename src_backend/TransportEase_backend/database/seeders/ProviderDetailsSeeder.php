<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class ProviderDetailsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $firstRegularDriver = DB::table('drivers')->find(1);

        DB::table('provider_details')->insert([

            'driver_id' => $firstRegularDriver->id,
            'license_plate' => 'SK1234AA',
            'car_color' => 'Бела',
            'car_model' => 'Toyota Corolla'
        ]);

    }
}
