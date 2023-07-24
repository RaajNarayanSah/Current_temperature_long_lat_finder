class LocationModel {
  final String district;
  final String state;
  final String pincode;

  LocationModel({
    required this.district,
    required this.state,
    required this.pincode,
  });

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
        district: json["District"],
        state: json["State"],
        pincode: json["Pincode"],
      );

  Map<String, dynamic> toMap() => {
        "District": district,
        "State": state,
        "Pincode": pincode,
      };
}
