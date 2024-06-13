<?php

use App\Http\Controllers\Api\DriverController;
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
Route::post('drivers',[DriverController::class,'store']);
Route::delete('drivers/{id}',[DriverController::class,'destroy']);
