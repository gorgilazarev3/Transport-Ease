<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UsersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        //
        User::create([
            'id' => Str::uuid(),
            'name' => 'Seeded User1',
            'email' => "user1@user.com",
            'phone_number' => '071123456',
            'password' => Hash::make("Test123!"),
        ]);

        User::create([
            'id' => Str::uuid(),
            'name' => 'Admin User',
            'email' => "admin@user.com",
            'phone_number' => '+38972123456',
            'password' => Hash::make("Test123!"),
            'role' => "admin"
        ]);
    }
}
