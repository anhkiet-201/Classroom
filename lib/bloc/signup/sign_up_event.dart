part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequest extends SignUpEvent{
  final String username;
  final String email;
  final String password;

  const SignUpRequest({required this.email, required this.password, required this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [username, email, password];

}