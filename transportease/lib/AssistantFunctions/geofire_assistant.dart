import '../Models/nearby_driver.dart';

class GeofireAssistant {
  static List<NearbyAvailableDriver> nearbyAvailableDrivers = [];

  static void removeDriverFromList(String key) {
    int index =
        nearbyAvailableDrivers.indexWhere((element) => element.key == key);
    nearbyAvailableDrivers.removeAt(index);
  }

  static void updateSpecificDriverNearbyLocation(
      NearbyAvailableDriver nearbyDriver) {
    int index = nearbyAvailableDrivers
        .indexWhere((element) => element.key == nearbyDriver.key);
    nearbyAvailableDrivers[index].longitude = nearbyDriver.longitude;
    nearbyAvailableDrivers[index].latitude = nearbyDriver.latitude;
  }
}
