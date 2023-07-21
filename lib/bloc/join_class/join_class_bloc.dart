import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:class_room_chin/constants/FirebaseConstants.dart';
import 'package:class_room_chin/extension/Optional.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/services/ClassroomServices.dart';
import 'package:meta/meta.dart';

part 'join_class_event.dart';
part 'join_class_state.dart';

class JoinClassBloc extends Bloc<JoinClassEvent, JoinClassState> {
  JoinClassBloc() : super(JoinClassState.init);
  Classroom? classroom;
  String error = '';

  showClassInfo(String classID) {
    if(!classroom.guard) {
      fetchClass(classID);
      return;
    }
    if(classroom!.classID == classID) {
      emit(JoinClassState.success);
      return;
    }
    fetchClass(classID);
  }

  fetchClass(String classID) {
    emit(JoinClassState.loading);
    ClassroomServices.Instants.getClassById(
        id: classID,
        onSuccess: (classroom) {
          this.classroom = classroom;
          emit(JoinClassState.success);
        },
        onFailure: (error) {
          this.error = error;
          emit(JoinClassState.failure);
        }
    );
  }

  joinClass(Classroom classroom) {
    emit(JoinClassState.loading);
    ClassroomServices.Instants.joinClass(
        classroom: classroom,
        onSuccess: () {emit(JoinClassState.joinSuccess);},
        onFailure: (error) {
          this.error = error;
          emit(JoinClassState.joinError);
        }
    );
  }
}
