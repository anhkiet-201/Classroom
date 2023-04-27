part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditProfileFetch extends EditProfileEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EditProfileUpdate extends EditProfileEvent{

  final Userrepostory user;
  final File? file;

  EditProfileUpdate(this.user, this.file);

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
