part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
}

class LoginRequest extends LoginEvent{

  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];

}