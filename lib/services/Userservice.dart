

import 'dart:io';

import 'package:class_room_chin/models/UserRepostory.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants/FirebaseConstants.dart';

fetchUserData({ required Function(Userrepostory user) onSuccess, required Function(String) onFailure}){

  DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('Birthday').get()
      .then((snapShot){
        if(snapShot.value != null){
          final birthday = snapShot.value as String;
          onSuccess(Userrepostory(email: AUTH.currentUser!.email!, userName:AUTH.currentUser!.displayName!, img: AUTH.currentUser!.photoURL ?? '', birthday: birthday));
        }else{
          onFailure('Error during fetching data!');
        }
  }).onError((error, stackTrace){
    onFailure('$error');
  });
}

updateUserData({required Userrepostory user,  File? file ,required Function onSuccess, required Function(String) onFailure}) async {

  if(user.userName.isEmpty){
    onFailure("Username can't be empty!");
    return;
  }

  if(file == null){
    DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('Birthday').set(user.birthday)
        .then((onValue){
      AUTH.currentUser!.updateDisplayName(user.userName).
      then((value){
        onSuccess();
      });
    }).onError((error, stackTrace){
      onFailure('$error');
    });
    return;
  }

  try {

    final snapShot = await STORAGE.ref('USER').child('avatar/').putFile(file!).whenComplete((){});
    snapShot.ref.getDownloadURL()
        .then((url){
      DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('Birthday').set(user.birthday)
          .then((onValue){
        AUTH.currentUser!.updateDisplayName(user.userName).
        then((value){
          AUTH.currentUser!.updatePhotoURL(url)
              .then((value){
            onSuccess();
          });
        });
      }).onError((error, stackTrace){
        onFailure('$error');
      });
    });
  }on FirebaseException catch (e, s) {
    onFailure(e.message ?? 'Error');
  }

}