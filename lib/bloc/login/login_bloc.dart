import 'package:bloc/bloc.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>((event, emit) => _handleLoginEvent(event));
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

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
      emit(LoginFailure("Invalid email!"));
      return;
    }

    if(event.password.length < 8){
      emit(LoginFailure("Password length is not enough. \nPassword must be at least 8 characters.!"));
      return;
    }
    emit(LoginLoading());

    auth.signInWithEmailAndPassword(email: event.email.trim(), password: event.password.trim())
        .then((value) {
          if(value.user == null){
            emit(LoginFailure("error"));
          }else{
            emit(LoginSuccess());
          }
    } ).onError<FirebaseAuthException>((error, stackTrace){
      emit(LoginFailure(error.message ?? "error"));
    });

  }

}
