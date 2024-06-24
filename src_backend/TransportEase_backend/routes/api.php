<?php

use App\Http\Controllers\Api\DriverController;
use App\Http\Controllers\Api\ProviderDetailsController;
use App\Http\Controllers\Api\RideRequestController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register',[UserController::class,'register']);
Route::post('login',[UserController::class,'login']);
Route::post('logout',[UserController::class,'logout'])
    ->middleware('auth:sanctum');

Route::get('drivers',[DriverController::class,'index']);
Route::get('drivers/{id}',[DriverController::class,'show']);
Route::get('drivers/full/{id}',[DriverController::class,'fullInfo']);
Route::get('drivers/full/user/{id}',[DriverController::class,'fullInfoUserId']);

Route::get('drivers/user/{userId}',[DriverController::class,'getDriverByUserId']);
Route::post('drivers',[DriverController::class,'store']);
Route::put('drivers/updateRide/{id}',[DriverController::class,'updateNewRide']);
Route::post('drivers/updateToken/{id}',[DriverController::class,'updateToken']);
Route::post('drivers/updateEarnings/{id}',[DriverController::class,'updateEarnings']);
Route::post('drivers/updateRating/{id}',[DriverController::class,'updateRating']);
Route::delete('drivers/{id}',[DriverController::class,'destroy']);

Route::get('providers/driver/{driverId}',[ProviderDetailsController::class,'getProviderDetailsForDriver']);

Route::post('ride-requests',[RideRequestController::class,'store']);
Route::get('ride-requests/{id}',[RideRequestController::class,'show']);
Route::get('ride-requests/driver/{id}',[RideRequestController::class,'getRideRequestsForDriver']);
Route::delete('ride-requests/{id}',[RideRequestController::class,'destroy']);
Route::post('ride-requests/updateStatus/{id}',[RideRequestController::class,'changeRideRequestStatus']);
Route::post('ride-requests/updateFare/{id}',[RideRequestController::class,'changeRideRequestFare']);
Route::post('ride-requests/updateDetails/{id}',[RideRequestController::class,'updateRideRequestDetails']);

Route::get('proxy',[RideRequestController::class,'getRequestAsProxy']);
Route::get('getPlacesApi',[RideRequestController::class,'getPlacesApi']);
Route::get('getPlaceDetailsApi',[RideRequestController::class,'getPlaceDetailsApi']);
Route::get('getDirectionDetailsApi',[RideRequestController::class,'getDirectionDetailsApi']);
