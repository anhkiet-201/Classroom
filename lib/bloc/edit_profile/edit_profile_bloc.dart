import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:class_room_chin/services/Userservice.dart';
import 'package:equatable/equatable.dart';
import 'package:class_room_chin/models/UserRepostory.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileFetch>((event, emit) => _fetchData());

    on<EditProfileUpdate>((event, emit) => _updateData(event));
  }

  _fetchData(){
    emit(EditProfileLoading());
    fetchUserData(onSuccess: (user) {
      emit(EditProfileFetched(user));
    }, onFailure: (error) {
      emit(EditProfileFailure(error));
    });
  }

  _updateData(EditProfileUpdate event){
    emit(EditProfileLoading());
    updateUserData(onSuccess: () {
      emit(EditProfileSuccess());
    }, onFailure: (error) {
      emit(EditProfileFailure(error));
    }, user: event.user,);
  }

}
