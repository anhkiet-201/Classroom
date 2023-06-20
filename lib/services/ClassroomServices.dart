
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
      final listClassIDSnapShot = await DATABASE.ref('USER').child(AUTH.currentUser!.uid).child('OWNER_CLASS').get();
      List<String> classIDs = [];
      for (var element in listClassIDSnapShot.children) {
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
}