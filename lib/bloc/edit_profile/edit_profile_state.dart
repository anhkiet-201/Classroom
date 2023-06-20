part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();
}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileFetched extends EditProfileState{

  final User user;

  EditProfileFetched(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [user];

}

class EditProfileLoading extends EditProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class EditProfileSuccess extends EditProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class EditProfileFailure extends EditProfileState{

  final String error;

  EditProfileFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
