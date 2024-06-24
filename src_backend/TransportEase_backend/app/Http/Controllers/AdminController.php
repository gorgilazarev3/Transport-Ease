<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Api\UserController;
use App\Models\User;
use App\Services\DriverService;
use App\Services\ProviderDetailsService;
use App\Services\RideRequestsService;
use App\Services\UserService;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    //
    protected UserService $userService;
    protected DriverService $driverService;
    protected ProviderDetailsService $providerDetailsService;
    protected RideRequestsService $rideRequestsService;

    public function __construct(UserService $userService, DriverService $driverService, ProviderDetailsService $providerDetailsService, RideRequestsService $rideRequestsService)
    {
        $this->userService = $userService;
        $this->driverService = $driverService;
        $this->providerDetailsService = $providerDetailsService;
        $this->rideRequestsService = $rideRequestsService;
    }

    public function panel_action(Request $request) {
        if($request->get('panelAction') == 'allUsers') {
            return $this->all_users($request);
        }
        else if($request->get('panelAction') == 'allProviders') {
            return $this->all_drivers($request);
        }
        else if($request->get('panelAction') == 'providersByType') {
            return $this->drivers_by_type($request);
        }
        else if($request->get('panelAction') == 'providerDetails') {
            return $this->provider_details($request);
        }
        else if($request->get('panelAction') == 'allRideRequests') {
            return $this->all_ride_requests($request);
        }
        $activeLink = $request->get('activeLink', 'dashboard');
        return view('admin.admin-panel', ['activeLink' => $activeLink, 'users' => $this->userService->getAllUsersByDate(), 'usersList' => $this->userService->getAllUsers(), 'providersList' => $this->driverService->getAllDriversWithUserInfo(), 'rideRequests' => $this->rideRequestsService->getAllRideRequests(), 'rideRequestsByDate' => $this->rideRequestsService->getAllRideRequestsByDate(), 'providersByType' => $this->driverService->getAllDriversWithUserInfoGroupedByType()]);
    }

    public function all_users(Request $request) {
        return view('admin.admin-panel', ['activeLink' => 'users', 'panelAction' => 'allUsers', 'userList' => $this->userService->getAllUsersWithPagination()]);
    }

    public function all_drivers(Request $request) {
        return view('admin.admin-panel', ['activeLink' => 'providers', 'panelAction' => 'providersByType', 'providersList' => $this->driverService->getAllDriversWithUserInfoWithPagination()]);
    }

    public function drivers_by_type(Request $request) {
        $providerType = $request->get('providerType');
        return view('admin.admin-panel', ['activeLink' => 'providers', 'panelAction' => 'allProviders', 'providersList' => $this->driverService->getAllDriversWithUserInfoWithPaginationByProviderType($providerType)]);
    }

    public function all_ride_requests(Request $request) {
        return view('admin.admin-panel', ['activeLink' => 'rideRequests', 'panelAction' => 'allRideRequests', 'rideRequestsList' => $this->rideRequestsService->getAllRideRequestsWithPagination()]);
    }

    public function provider_details(Request $request) {
        $id = $request->get('driverId');
        return view('admin.admin-panel', ['activeLink' => 'providers', 'panelAction' => 'providerDetails', 'provider' => $this->providerDetailsService->getProviderDetailsForDriverAlongWithAllInfo($id), 'rideRequests' => $this->rideRequestsService->getRideRequestsForDriverWithPagination($id)]);
    }

    public function delete_provider(Request $request, int $id) {
        $this->driverService->deleteDriverById($id);
        return redirect()->to('/admin?activeLink=providers&panelAction=allProviders');
    }

    public function delete_ride_request(Request $request, int $id) {
        $this->rideRequestsService->deleteRideRequestById($id);
        return redirect()->to('/admin?activeLink=rideRequests&panelAction=allRideRequests');
    }
}
