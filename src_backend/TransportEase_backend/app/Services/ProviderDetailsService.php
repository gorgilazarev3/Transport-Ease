<?php
namespace App\Services;


use App\Models\ProviderDetails;

class ProviderDetailsService {
    public function getProviderDetailsForDriver(int $driverId)
    {
        //
        return ProviderDetails::query()->where('driver_id','=',$driverId)->first();
    }

    public function getProviderDetailsForDriverAlongWithAllInfo(int $driverId)
    {
        //
        return ProviderDetails::query()->join('drivers','provider_details.driver_id','=','drivers.id')->join('users', 'drivers.user_id','=','users.id')->where('driver_id','=',$driverId)->first();
    }

    public function deleteProviderByDriverId(int $driverId) {
        $provider_details = ProviderDetails::query()->where('driver_id',$driverId)->first();
        ProviderDetails::destroy($provider_details->id);
    }
}
