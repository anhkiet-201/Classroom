
import 'package:class_room_chin/extension/Optional.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:firebase_core/firebase_core.dart';

import '../constants/FirebaseConstants.dart';

class ClassroomServices {

  static ClassroomServices Instants = ClassroomServices();

  createClassroom({required Classroom classroom, required Function onSuccess, required Function(String) onFailure}){
    if(classroom.className.isEmpty){
      onFailure('Class name is required!');
      return;
    }
    DATABASE.ref('CLASSROOM').child(classroom.classID).set(classroom.toFirebaseObject())
        .then((value){
      DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('OWNER_CLASS').child(classroom.classID).set(classroom.className)
          .then((value){
        onSuccess();
      });
    }).onError<FirebaseException>((error, stackTrace){
      onFailure(error.message ?? 'Error');
    });
  }

  getClassList({required Function(List<Classroom>) onSuccess, required Function(String) onFailure}) async {
    try{
      final listOwnClass = await DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('OWNER_CLASS').get();
      List<String> classIDs = [];
      for (var element in listOwnClass.children) {
        classIDs.add(element.key ?? '');
      }
      final listJoinClass = await DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('JOIN_CLASS').get();
      for (var element in listJoinClass.children) {
        classIDs.add(element.key ?? '');
      }
      final snapShot = await DATABASE.ref('CLASSROOM').get();
      List<Classroom> classrooms = [];
      for (var element in snapShot.children) {
        final map = element.value as Map<Object?, Object?>;
        Classroom classroom = Classroom.fromMap(map);
        if(classIDs.contains(classroom.classID)){
          classrooms.insert(0, classroom);
        }
      }
      classrooms.sort((c1, c2) => c2.time.compareTo(c1.time));
      onSuccess(classrooms);
    }on FirebaseException catch(e){
      onFailure(e.message ?? 'Error');
    }
  }

  getClassById({required String id, required Function(Classroom) onSuccess, required Function(String) onFailure}) async {
    try{
      await DATABASE.ref('CLASSROOM').child(id).get()
      .then((value) {
        if(value.value == null) {
          onFailure('Classroom does not exist!');
          return;
        }
        final classroom = value.value as Map<Object?, Object?>;
        onSuccess(Classroom.fromMap(classroom));
      });
    }on FirebaseException catch(e){
      onFailure(e.message ?? 'Error');
    }
  }

  joinClass({required Classroom classroom, required Function() onSuccess, required Function(String) onFailure}) {
    try{
      DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('OWNER_CLASS').child(classroom.classID).get()
      .then((value) {
        if(!value.value.guard) {
          onFailure('You own this class!');
          return;
        } else {
          DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('JOIN_CLASS').child(classroom.classID).get()
              .then((value) {
            if(!value.value.guard) {
              onFailure('You have already joined!');
              return;
            } else {
              DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('JOIN_CLASS').child(classroom.classID)
                  .set(classroom.className)
                  .then((value) {
                onSuccess();
              });
            }
          });
        }
      });
    }on FirebaseException catch(e){
      onFailure(e.message ?? 'Error');
    }
  }
}