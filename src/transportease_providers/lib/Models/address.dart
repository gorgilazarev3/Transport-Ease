class Address {
  String placeFormattedAddress;
  String placeName;
  String placeId;
  double latitude;
  double longitude;

  Address(
      {required this.placeFormattedAddress,
      required this.placeName,
      required this.placeId,
      required this.latitude,
      required this.longitude});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        placeFormattedAddress: json['results'][0]['formatted_address'],
        placeName: json['plus_code']['compound_code'],
        placeId: json['results'][0]['place_id'],
        latitude: json['results'][0]['geometry']['location']['lat'],
        longitude: json['results'][0]['geometry']['location']['lng']);
  }

  @override
  String toString() {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.writeln("Formatted Address: " + placeFormattedAddress);
    stringBuffer.writeln("PlaceID: " + placeId);
    stringBuffer.writeln("PlaceName: " + placeName);
    stringBuffer.writeln("Latitude: " + latitude.toString());
    stringBuffer.writeln("Longitude: " + longitude.toString());
    return stringBuffer.toString();
  }
}
