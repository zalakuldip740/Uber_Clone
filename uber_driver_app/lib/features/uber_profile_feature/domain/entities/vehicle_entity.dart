class VehicleEntity {
  final String? color;
  final String? comapany;
  final String? model;
  final String? number_plate;

  VehicleEntity({this.comapany, this.color, this.model, this.number_plate});

  @override
  List<Object?> get props => [comapany, color, model, number_plate];
}
