<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
//    public function index()
//    {
//        //
//
//    }
//
//    /**
//     * Show the form for creating a new resource.
//     */
//    public function create()
//    {
//        //
//    }
//
//    /**
//     * Store a newly created resource in storage.
//     */
//    public function store(Request $request)
//    {
//        //
//    }
//
//    /**
//     * Display the specified resource.
//     */
//    public function show(User $user)
//    {
//        //
//    }
//
//    /**
//     * Show the form for editing the specified resource.
//     */
//    public function edit(User $user)
//    {
//        //
//    }
//
//    /**
//     * Update the specified resource in storage.
//     */
//    public function update(Request $request, User $user)
//    {
//        //
//    }
//
//    /**
//     * Remove the specified resource from storage.
//     */
//    public function destroy(User $user)
//    {
//        //
//    }

    public function register(Request $request){
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
    return response()->json([
        'created_user' => $user,
    ]);
    }

    public function login(Request $request){
    $loginUserData = $request->validate([
        'email'=>'required|string|email',
        'password'=>'required|min:8'
    ]);
    $user = User::where('email',$loginUserData['email'])->first();
    if(!$user || !Hash::check($loginUserData['password'],$user->password)){
        return response()->json([
            'message' => 'Invalid Credentials'
        ],401);
    }
    $token = $user->createToken($user->name.'-AuthToken')->plainTextToken;
    return response()->json([
        'access_token' => $token,
        'id' => $user->id,
        'email' => $user->email,
        'name' => $user->name,
        'phone_number' => $user->phone_number,
        'role' => $user->role,
    ]);
    }

    public function logout(){
    auth()->user()->tokens()->delete();

    return response()->json([
        "message"=>"Successfully logged out"
    ]);
    }

    public function getLoggedInUser(){
        return auth()->user();
    }
}
