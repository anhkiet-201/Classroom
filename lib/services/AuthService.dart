

import 'package:class_room_chin/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireAuth;
import '../constants/FirebaseConstants.dart';
import '../utils/Utils.dart';

class AuthService{

  signUpWithEmailAndPassword({required User user, required Function onSuccess, required Function(String) onFailure}){
    if (user.userName==null || user.userName!.isEmpty) {
      onFailure("Username can't be empty!");
      return;
    }

    if (user.email.trim().isEmpty) {
      onFailure("Email can't be empty!");
      return;
    }

    if (user.password.trim().isEmpty) {
      onFailure("Password can't be empty!");
      return;
    }

    if (!isValidEmail(user.email.trim())) {
      onFailure("Invalid email!");
      return;
    }

    if (user.password.length < 8) {
      onFailure(
          "Password length is not enough. \nPassword must be at least 8 characters.!");
      return;
    }

    AUTH
        .createUserWithEmailAndPassword(
            email: user.email.trim(), password: user.password.trim())
        .then((value) {
      if (value.user != null) {
        value.user?.updateDisplayName(user.userName).then((value1) {
          DATABASE.ref('USER').child(value.user!.uid).child('Birthday').set(user.birthday)
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

  signInWithEmailAndPassword({required User user, required Function onSuccess, required Function(String) onFailure}){

    if (user.email.trim().isEmpty) {
      onFailure("Email can't be empty!");
      return;
    }

    if (user.password.trim().isEmpty) {
      onFailure("Password can't be empty!");
      return;
    }

    if (!isValidEmail(user.email.trim())) {
      onFailure("Invalid email!");
      return;
    }

    AUTH.signInWithEmailAndPassword(email: user.email.trim(), password: user.password.trim())
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