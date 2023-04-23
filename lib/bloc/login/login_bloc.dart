import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>((event, emit) => _handleLoginEvent(event));
  }

  final email = "igg.anhkiet1@gmail.com";
  final password = "12345678";
  _handleLoginEvent(LoginRequest event) async {

    if(event.email.trim().isEmpty){
      emit(LoginFailure("Email can't be empty!"));
      return;
    }

    if(event.password.trim().isEmpty){
      emit(LoginFailure("Password can't be empty!"));
      return;
    }

    if(!isValidEmail(event.email.trim())){
      emit(LoginFailure("Email invalidate!"));
      return;
    }

    if(event.password.length < 8){
      emit(LoginFailure("The length of password not enought!"));
      return;
    }


    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    if(event.email != email){
      emit(LoginFailure("Email not match!"));
      return;
    }
    if(event.password.trim() != password){
      print(event.password != password);
      emit(LoginFailure("Password not match!"));
      return;
    }
    emit(LoginSuccess());

  }

}
