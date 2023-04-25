part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequest extends SignUpEvent{

  final User user;

  const SignUpRequest({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];

}