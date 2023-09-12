class DirectionDetails {
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  String encodedPoints;

  DirectionDetails(
      {required this.distanceText,
      required this.durationText,
      required this.distanceValue,
      required this.durationValue,
      required this.encodedPoints});

  factory DirectionDetails.fromJson(Map<String, dynamic> json) {
    return DirectionDetails(
        encodedPoints: json['routes'][0]['overview_polyline']["points"],
        distanceText: json['routes'][0]["legs"][0]["distance"]["text"],
        distanceValue: json['routes'][0]["legs"][0]["distance"]["value"],
        durationText: json['routes'][0]["legs"][0]["duration"]["text"],
        durationValue: json['routes'][0]["legs"][0]["duration"]["value"]);
  }
}
