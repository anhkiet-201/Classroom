import 'package:bloc/bloc.dart';
import 'package:class_room_chin/models/User.dart';
import 'package:class_room_chin/services/AuthService.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>((event, emit) => _handleLoginEvent(event));
  }

  final AuthService authService = AuthService();

  _handleLoginEvent(LoginRequest event) async {
    emit(LoginLoading());
    authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
        onSuccess: () => emit(LoginSuccess()),
        onFailure: (error) => emit(LoginFailure(error)));
  }
}
