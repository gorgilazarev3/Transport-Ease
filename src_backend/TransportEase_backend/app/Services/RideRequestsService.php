<?php
namespace App\Services;
use App\Models\RideRequest;
use Clickbar\Magellan\Data\Geometries\Point;
use PhpParser\Node\Expr\Cast\Double;

class RideRequestsService {
    public function getAllRideRequests() {
        return RideRequest::all();
    }

    public function getAllRideRequestsWithPagination() {
        $rrs = RideRequest::paginate(6);
        $rrs->withPath('admin?activeLink=rideRequests&panelAction=allRideRequests');
        return $rrs;
    }

    public function deleteRideRequestById(string $id) {
        $deletedRideRequest = RideRequest::query()->find($id);
        RideRequest::destroy($id);
        return $deletedRideRequest;
    }

    public function getRideRequestById(string $id) {
        return RideRequest::query()->find($id);
    }

    public function changeRideRequestStatus(string $id, string $status) {
        $rr = RideRequest::query()->find($id);
        $rr->update(['status' => $status]);
        return $rr;
    }

    public function changeRideRequestFare(string $id, int $fare) {
        $rr = RideRequest::query()->find($id);
        $rr->update(['fare' => $fare]);
        return $rr;
    }

    public function updateRideRequestDriverLocation(string $id, $driver_location) {
        $rr = RideRequest::query()->find($id);
        $rr->update(['driver_location' => Point::makeGeodetic($driver_location['longitude'], $driver_location['latitude'])]);
        return $rr;
    }

    public function getRideRequestsForDriver(string $driver_id) {
        $rrs = RideRequest::query()->where('driver_id','=',$driver_id)->get('*');
        return $rrs;
    }

    public function getRideRequestsForDriverWithPagination(string $driver_id) {
        $rrs = RideRequest::query()->where('driver_id','=',$driver_id)->paginate(2);
        $rrs->withPath('admin?activeLink=providers&panelAction=providerDetails&driverId=8');
        return $rrs;
    }

    public function getAllRideRequestsByDate() {
        $data = RideRequest::selectRaw("to_char(created_at, 'YYYY-Mon-DD') as date, count(*) as aggregate")
            ->whereDate('created_at', '>=', now()->subDays(30))
            ->groupBy('date')
            ->get();
        return $data;
    }

//    public function updateRideRequestDetails(string $id, Request $request) {
//        $rr = RideRequest::query()->find($id);
//        $input = $request->post();
//        $driver_location = $input['driver_location'];
//        $rr->update([
//            'driver_name' => $input['driver_name'],
//            'driver_phone' => $input['driver_phone'],
//            'driver_id' => $input['driver_id'],
//            'car_details' => $input['car_details'],
//            'car_plates' => $input['car_plates'],
//            'driver_location' => Point::makeGeodetic($driver_location['longitude'], $driver_location['latitude']),
//            ]);
//        return $rr;
//    }

}
