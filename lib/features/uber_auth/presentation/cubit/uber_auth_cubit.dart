import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'uber_auth_state.dart';

class UberAuthCubit extends Cubit<UberAuthState> {
  UberAuthCubit() : super(UberAuthInitial());
}
