class PlacePrediction {
  String secondaryText;
  String mainText;
  String placeId;

  PlacePrediction(
      {required this.secondaryText,
      required this.mainText,
      required this.placeId});

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
        secondaryText: json["structured_formatting"]["secondary_text"],
        mainText: json["structured_formatting"]["main_text"],
        placeId: json["place_id"]);
  }
}
