<?php

use App\Http\Controllers\AdminController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('landing');
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});

Route::middleware('checkAdminPermissions')->group(function () {
   Route::get('/admin', [AdminController::class, 'panel_action']
//       function () {
//       return view('admin.admin-panel', ['activeLink' => 'dashboard']);
//   }
   )->name('admin');
   Route::delete('/admin/providers/{id}', [AdminController::class, 'delete_provider'])->name('admin.delete_provider');
   Route::delete('/admin/ride-requests/{id}', [AdminController::class, 'delete_ride_request'])->name('admin.delete_ride_request');
});
