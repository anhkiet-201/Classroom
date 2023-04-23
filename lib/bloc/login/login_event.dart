part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
}

class LoginRequest extends LoginEvent{

  LoginRequest(this.email,this.password);

  final String email;
  final String password;

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];

}