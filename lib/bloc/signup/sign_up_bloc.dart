import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:class_room_chin/services/AuthService.dart';
import 'package:equatable/equatable.dart';
import 'package:class_room_chin/models/User.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/Utils.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequest>((event, emit) => _handleSignUp(event));
  }

  final AuthService authService = AuthService();

  _handleSignUp(SignUpRequest event) {
    emit(SignUpLoading());
    authService.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
        userName: event.password,
        birthday: event.birthday,
        onSuccess: () {
          emit(SignUpSuccess());
        },
        onFailure: (error) {
          emit(SignUpFailure(error));
        }
    );

    // FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(
    //         email: event.email.trim(), password: event.password.trim())
    //     .then((value) {
    //   if (value.user != null) {
    //     value.user?.updateDisplayName(event.username).then((v) {
    //       emit(SignUpSuccess());
    //     });
    //   } else {
    //     emit(const SignUpFailure('error'));
    //   }
    // }).onError<FirebaseAuthException>((error, stackTrace) {
    //   emit(SignUpFailure(error.message ?? 'Error'));
    // });
  }
}
