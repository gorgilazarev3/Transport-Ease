<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Driver;
use App\Models\ProviderDetails;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;


class DriverController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        return Driver::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //

        $registerUserData = $request->validate([
            'name'=>'required|string',
            'email'=>'required|string|email|unique:users',
            'password'=>'required|min:8',
            'phone_number'=>'required',
            'role'=>'required'
        ]);
        $user = User::create([
            'name' => $registerUserData['name'],
            'email' => $registerUserData['email'],
            'phone_number' => $registerUserData['phone_number'],
            'role' => $registerUserData['role'],
            'password' => Hash::make($registerUserData['password']),
        ]);
        $driver = Driver::create([
            'user_id' => $user->id,
            'earnings' => 0,
            'ratings' => 0
        ]);
        $providerType = $registerUserData['role'];
        $providerData = [];
        $postInputs = $request->post();
        if($providerType == 'taxi_driver') {
            $providerData = [
                'license_plate' => $postInputs['license_plate'],
                'taxi_car_seats' => $postInputs['taxi_car_seats'],
                'taxi_company_name' => $postInputs['taxi_company_name']
            ];
        }
        else if($providerType == 'transporting_driver' && $postInputs['provider_type'] == 'carrier_provider') {
            $providerData = [
                'carrier_capacity' => $postInputs['carrier_capacity'],
                'provider_type' => $postInputs['provider_type']
            ];
        }
        else if($providerType == 'transporting_driver' && $postInputs['provider_type'] == 'passengers_provider') {
            $providerData = [
                'provider_seats' => $postInputs['provider_seats'],
                'provider_type' => $postInputs['provider_type'],
                'routes_type' => $postInputs['routes_type']
            ];
        }
        else if($providerType == 'regular_driver') {
            $providerData = [
                'license_plate' => $postInputs['license_plate'],
                'car_color' => $postInputs['car_color'],
                'car_model' => $postInputs['car_model']
            ];
        }
        $providerData['driver_id'] = $driver->id;
        $provider_details = ProviderDetails::create($providerData);
        return response()->json([
            'created_user' => $user,
            'created_driver' => $driver,
            'created_provider_details' => $provider_details
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        //
        return Driver::query()->find($id);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Driver $driver)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Driver $driver)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id)
    {
        //
        $driver = Driver::query()->find($id);
        Driver::destroy($id);
        return $driver;
    }
}
