<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Driver;
use App\Models\ProviderDetails;
use App\Models\User;
use App\Services\DriverService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;


class DriverController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    protected DriverService $driverService;

    public function __construct(DriverService $driverService)
    {
        $this->driverService = $driverService;
    }

    public function index()
    {
        //
        return $this->driverService->getAllDrivers();
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
        return $this->driverService->getDriverById($id);
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
        return $this->driverService->deleteDriverById($id);
    }

    public function getDriverByUserId(String $userId)
    {
        //
        return $this->driverService->getDriverByUserId($userId);
    }

    public function updateNewRide(int $id, Request $request)
    {
        //
        $newRide = $request->all(['newRide'])['newRide'];
        Log::info($newRide);
        error_log($newRide);

        return $this->driverService->updateDriverRideById($id, $newRide);
    }

    public function updateToken(int $id, Request $request)
    {
        //
        $token = $request->all(['token'])['token'];
        Log::info($token);
        error_log($token);

        return $this->driverService->updateDriverToken($id, $token);
    }

    public function updateEarnings(int $id, Request $request)
    {
        //
        $fare = $request->post('fareAmount');
        return $this->driverService->updateDriverEarnings($id, $fare);
    }

    public function updateRating(int $id, Request $request)
    {
        //
        $newRating = $request->post('newRating');
        $newRating = doubleval($newRating);
        return $this->driverService->updateDriverRating($id, $newRating);
    }

    public function fullInfo(int $id)
    {
        //
        return $this->driverService->getDriverByIdWithAllInfo($id);
    }

    public function fullInfoUserId(string $id)
    {
        //
        return $this->driverService->getDriverByUserIdWithAllInfo($id);
    }
}
