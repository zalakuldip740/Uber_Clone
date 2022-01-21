import 'package:equatable/equatable.dart';

class UberMapPredictionEntity extends Equatable {
  String? secondaryText;
  String? mainText;
  String? placeId;

  UberMapPredictionEntity(
      {required this.secondaryText,
      required this.mainText,
      required this.placeId});

  @override
  // TODO: implement props
  List<Object?> get props => [secondaryText, mainText, placeId];
}
