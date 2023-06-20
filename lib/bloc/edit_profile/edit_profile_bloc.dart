import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:class_room_chin/models/User.dart';
import 'package:class_room_chin/services/Userservice.dart';
import 'package:equatable/equatable.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {

  UserServices userservices = UserServices.Instants;

  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileFetch>((event, emit) => _fetchData());

    on<EditProfileUpdate>((event, emit) => _updateData(event));
  }

  _fetchData(){
    emit(EditProfileLoading());
    userservices.fetchUserData(onSuccess: (user) {
      emit(EditProfileFetched(user));
    }, onFailure: (error) {
      emit(EditProfileFailure(error));
    });
  }

  _updateData(EditProfileUpdate event){
    emit(EditProfileLoading());
    userservices.updateUserData(
      file: event.file,
      onSuccess: () {
      emit(EditProfileSuccess());
    }, onFailure: (error) {
      emit(EditProfileFailure(error));
    }, user: event.user,);
  }

}
