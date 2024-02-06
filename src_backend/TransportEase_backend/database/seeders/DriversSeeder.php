<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use function Laravel\Prompts\table;

class DriversSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        DB::table('users')->insert([
            'id' => Str::uuid(),
        'name' => 'Regular Driver',
        'email' => 'regulardriver@user.com',
        'password' => Hash::make('Test123!'),
        'phone_number' => '+38972866739',
        'role' => 'regular_driver'
    ]);

        $newlyAddedDriverUser = DB::table('users')->where('name','Regular Driver')->first();
        DB::table('drivers')->insert([
            'user_id' => $newlyAddedDriverUser->id,

        ]);

    }
}
