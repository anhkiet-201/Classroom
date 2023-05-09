
import 'package:class_room_chin/models/Classroom.dart';
import 'package:firebase_core/firebase_core.dart';

import '../constants/FirebaseConstants.dart';

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
    final listClassIDSnapShot = await DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('OWNER_CLASS').get();
    List<String> classIDs = [];
    listClassIDSnapShot.children.forEach((element) {
      classIDs.add(element.key ?? '');
    });
    final snapShot = await DATABASE.ref('CLASSROOM').get();
    List<Classroom> classrooms = [];
    snapShot.children.forEach((element) {
      final map = element.value as Map<Object?, Object?>;
      Classroom classroom = Classroom.fromMap(map);
      if(classIDs.contains(classroom.classID)){
        classrooms.insert(0, classroom);
      }
    });
    onSuccess(classrooms);
  }on FirebaseException catch(e){
    onFailure(e.message ?? 'Error');
  }
}