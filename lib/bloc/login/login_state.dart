part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoginSuccess extends LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoginFailure extends LoginState{
  final String error;
  const LoginFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];


}