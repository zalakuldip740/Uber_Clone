
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Stream<Type>? call(Params params);
  Future<void>? call2(Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class Params extends Equatable {
  final Type type;

  Params({required this.type});

  @override
  List<Object> get props => [type];
}
