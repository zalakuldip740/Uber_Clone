class VehicleModel {
  final String color;
  final String company;
  final String model;
  final String? numberPlate;

  VehicleModel(
      {required this.color,
      required this.company,
      required this.model,
      this.numberPlate});

  Map<String, dynamic> toDocument() {
    return {
      "color": color,
      "company": company,
      "model": model,
      "number_plate": numberPlate,
    };
  }

  factory VehicleModel.fromMap(Map<String, dynamic>? data) {
    return VehicleModel(
        color: data!['color'],
        company: data['company'],
        model: data['model'],
        numberPlate: data['number_plate']);
  }
}
