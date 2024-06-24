<?php
namespace App\Services;

use App\Models\Driver;
use App\Models\ProviderDetails;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use PhpParser\Node\Expr\Cast\Double;

class DriverService {
    protected $providerDetailsService;
    protected $userService;

    public function __construct(ProviderDetailsService $providerDetailsService, UserService $userService)
    {
        $this->providerDetailsService = $providerDetailsService;
        $this->userService = $userService;

    }

    public function getAllDrivers() {
        return Driver::all();
    }

    public function getAllDriversWithUserInfo() {
        return Driver::query()->select('*', \DB::raw("drivers.id as driver_id"))->join('users','users.id','=','drivers.user_id')->get('*');
    }

    public function getAllDriversWithUserInfoWithPagination() {
        $drivers =  Driver::query()->select('*', \DB::raw("drivers.id as driver_id"))->join('users','users.id','=','drivers.user_id')->paginate(8);
        $drivers->withPath('admin?activeLink=providers&panelAction=allProviders');
        return $drivers;
    }

    public function getDriverByIdWithAllInfo(int $id) {
        return Driver::query()->select('*', \DB::raw("drivers.id as driver_id"))->where('drivers.id','=',$id)->join('users','drivers.user_id','=', 'users.id')->join('provider_details', 'drivers.id', '=', 'provider_details.driver_id')->get('*')->first();
    }

    public function getDriverByUserIdWithAllInfo(string $id) {
        return Driver::query()->select('*', \DB::raw("drivers.id as driver_id"))->where('drivers.user_id','=',$id)->join('users','drivers.user_id','=', 'users.id')->join('provider_details', 'drivers.id', '=', 'provider_details.driver_id')->get('*')->first();
    }

    public function getDriverByUserId(string $userId) {
        return Driver::query()->where('user_id', '=', $userId)->first();
    }

    public function getDriverById(string $id) {
        return Driver::query()->find($id);
    }

    public function updateDriverRideById(string $id, string $newRide) {
        $driver = Driver::query()->find($id);
        if($newRide == "toNull")
            $driver->update(['newRide' => null]);
        else
            $driver->update(['newRide' => $newRide]);
        return $driver;
    }

    public function updateDriverToken(string $id, string $token) {
        $driver = Driver::query()->find($id);
        if($token == "toNull")
            $driver->update(['token' => null]);
        else
            $driver->update(['token' => $token]);
        return $driver;
    }

    public function deleteDriverById(int $id) {
        $driver = Driver::query()->find($id);
        $this->providerDetailsService->deleteProviderByDriverId($driver->id);;
        Driver::destroy($id);
        $this->userService->deleteUserById($driver->user_id);
        return $driver;
    }

    public function updateDriverEarnings(string $id, int $fareAmount) {
        $driver = Driver::query()->find($id);
        $driver->update(['earnings' => (intval($driver->earnings) + $fareAmount)]);
        return $driver;
    }

    public function updateDriverRating(string $id, $newRating) {
        $driver = Driver::query()->find($id);
        $driver->update(['ratings' => $newRating]);
        return $driver;
    }

    public function getAllDriversWithUserInfoWithPaginationByProviderType(string $provider_type) {
        $drivers =  Driver::query()->select('*', \DB::raw("drivers.id as driver_id"))->join('users','users.id','=','drivers.user_id')->where('role', '=', $provider_type)->paginate(8);
        $drivers->withPath('admin?activeLink=providers&panelAction=allProviders&providerType=' . $provider_type);
        return $drivers;
    }

    public function getAllDriversWithUserInfoGroupedByType() {
        return User::query()->select('role', DB::raw('count(*) as count'))
            ->whereNotIn('role',['regular_user','admin'])
            ->groupBy('role')
            ->get();
        // return User::query()->whereNotIn('role',['regular_user','admin'])->groupBy('role')->get();
    }
}
