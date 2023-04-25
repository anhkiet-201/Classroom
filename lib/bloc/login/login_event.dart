part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
}

class LoginRequest extends LoginEvent{

  final User user;

  LoginRequest(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [user];

}