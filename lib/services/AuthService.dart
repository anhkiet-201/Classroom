

import 'package:class_room_chin/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireAuth;
import '../constants/FirebaseConstants.dart';
import '../utils/Utils.dart';

class AuthService{

  static AuthService Instants = AuthService();

  signUpWithEmailAndPassword({required String email, required String password, required String userName, required String birthday, required Function onSuccess, required Function(String) onFailure}){
    if (userName.isEmpty) {
      onFailure("Username can't be empty!");
      return;
    }

    if (email.trim().isEmpty) {
      onFailure("Email can't be empty!");
      return;
    }

    if (password.trim().isEmpty) {
      onFailure("Password can't be empty!");
      return;
    }

    if (!isValidEmail(email.trim())) {
      onFailure("Invalid email!");
      return;
    }

    if (password.length < 8) {
      onFailure(
          "Password length is not enough. \nPassword must be at least 8 characters.!");
      return;
    }
    AUTH
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      if (value.user != null) {
        value.user?.updateDisplayName(userName).then((value1) {
          DATABASE.ref('USER').child(value.user!.uid).child('Birthday').set(birthday)
              .then((value){
                onSuccess();
          });
        });
      } else {
        onFailure('Error');
      }
    }).onError<FireAuth.FirebaseAuthException>((error, stackTrace) {
      onFailure(error.message ?? "error");
    });

  }

  signInWithEmailAndPassword({required String email, required String password, required Function onSuccess, required Function(String) onFailure}){

    if (email.trim().isEmpty) {
      onFailure("Email can't be empty!");
      return;
    }

    if (password.trim().isEmpty) {
      onFailure("Password can't be empty!");
      return;
    }

    if (!isValidEmail(email.trim())) {
      onFailure("Invalid email!");
      return;
    }

    AUTH.signInWithEmailAndPassword(email: email.trim(), password: password.trim())
        .then((value) {
      if(value.user == null){
        onFailure("Error");
      }else{
        onSuccess();
      }
    } ).onError<FireAuth.FirebaseAuthException>((error, stackTrace){
      onFailure(error.message ?? "Error");
    });

  }

}