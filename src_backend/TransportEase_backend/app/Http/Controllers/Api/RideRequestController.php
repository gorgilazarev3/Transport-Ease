<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\RideRequest;
use App\Services\RideRequestsService;
use Clickbar\Magellan\Data\Geometries\Point;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class RideRequestController extends Controller
{

    protected RideRequestsService $rideRequestService;

    public function __construct(RideRequestsService $rideRequestService)
    {
        $this->rideRequestService = $rideRequestService;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $postInputs = $request->post();
        return RideRequest::create([
            'driver_id' => 'waiting',
            'payment_method' => $postInputs['payment_method'],
            'ride_type' => $postInputs['ride_type'],
            'rider_name' => $postInputs['rider_name'],
            'rider_phone' => $postInputs['rider_phone'],
            'destination_location' => Point::makeGeodetic(floatval($postInputs['destination_location_longitude']), floatval($postInputs['destination_location_latitude'])),
            'destination_address' => $postInputs['destination_address'],
            'destination_place' => $postInputs['destination_place'],
            'pickup_location' => Point::makeGeodetic(floatval($postInputs['pickup_location_longitude']), floatval($postInputs['pickup_location_latitude'])),
            'pickup_address' => $postInputs['pickup_address'],
            'pickup_place' => $postInputs['pickup_place']
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        //
        return $this->rideRequestService->getRideRequestById($id);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(RideRequest $rideRequest)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, RideRequest $rideRequest)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $id)
    {
        //
        return $this->rideRequestService->deleteRideRequestById($id);
    }

    public function getPlacesApi(Request $request) {
        // $apiKey = config('custom_env_variables.browser_maps_key');
	$apiKey = "AIzaSyDJDtIjXxPSPDfRwnKSO2gGvS3s7gdLAfs";
        $place = $request->get('place');
        $response = Http::get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&key=$apiKey&sessionToken=1234567890&components=country:mk");
        return $response->json();
    }

    public function getRequestAsProxy(Request $request) {
        $url = $request->get('url');
        $response = Http::get($url);
        return $response->json();
    }

    public function getPlaceDetailsApi(Request $request) {
        // $apiKey = config('custom_env_variables.browser_maps_key');
	$apiKey = "AIzaSyDJDtIjXxPSPDfRwnKSO2gGvS3s7gdLAfs";
        $place = $request->get('place_id');
        $response = Http::get("https://maps.googleapis.com/maps/api/place/details/json?place_id=$place&key=$apiKey");
        return $response->json();
    }

    public function getDirectionDetailsApi(Request $request) {
        // $apiKey = config('custom_env_variables.browser_maps_key');
	$apiKey = "AIzaSyDJDtIjXxPSPDfRwnKSO2gGvS3s7gdLAfs";
        $origin = $request->get('origin');
        $destination= $request->get('destination');
        $response = Http::get("https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey");
        return $response->json();
    }

    public function changeRideRequestStatus(int $id, Request $request)
    {
        //
        $status = $request->post('status');
        return $this->rideRequestService->changeRideRequestStatus($id, $status);
    }

    public function changeRideRequestFare(int $id, Request $request)
    {
        //
        $fare = $request->post('fare');
        return $this->rideRequestService->changeRideRequestFare($id, $fare);
    }

    public function updateRideRequestDetails(int $id, Request $request)
    {
        //
        $rr = RideRequest::query()->find($id);
        $input = $request->post();
        $rr->update([
            'driver_name' => $input['driver_name'],
            'driver_phone' => $input['driver_phone'],
            'driver_id' => $input['driver_id'],
            'car_details' => $input['car_details'],
            'car_plates' => $input['car_plates'],
            'driver_location' => Point::makeGeodetic($input['driver_location_longitude'], $input['driver_location_latitude']),
        ]);
        return $rr;
    }

    public function getRideRequestsForDriver(int $id, Request $request)
    {
        return $this->rideRequestService->getRideRequestsForDriver($id);
    }
}
