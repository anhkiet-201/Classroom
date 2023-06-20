part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequest extends SignUpEvent{

  final String email;
  final String password;
  final String username;
  final String birthday;

  const SignUpRequest({required this.email, required this.password, required this.birthday, required this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, username, birthday];

}