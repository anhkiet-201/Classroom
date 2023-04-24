import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/Utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequest>((event, emit) => _handleSignUp(event));
  }

  _handleSignUp(SignUpRequest event){

    if(event.username.trim().isEmpty){
      emit(SignUpFailure("Username can't be empty!"));
      return;
    }

    if(event.email.trim().isEmpty){
      emit(SignUpFailure("Email can't be empty!"));
      return;
    }

    if(event.password.trim().isEmpty){
      emit(SignUpFailure("Password can't be empty!"));
      return;
    }

    if(!isValidEmail(event.email.trim())){
      emit(SignUpFailure("Invalid email!"));
      return;
    }

    if(event.password.length < 8){
      emit(SignUpFailure("Password length is not enough. \nPassword must be at least 8 characters.!"));
      return;
    }
    emit(SignUpLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.email.trim(), password: event.password.trim())
    .then((value){
      if(value.user != null){
        value.user?.updateDisplayName(event.username).then((value) {
          emit(SignUpSuccess());
        });
      }else{
        emit(SignUpFailure('error'));
      }
    }).onError<FirebaseAuthException>((error, stackTrace){
      emit(SignUpFailure(error.message ?? 'Error'));
    });
  }

}
