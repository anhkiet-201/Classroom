part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SignUpSuccess extends SignUpState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SignUpFailure extends SignUpState{
  final String error;
  const SignUpFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];


}
