import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/services/ClassroomServices.dart';
import 'package:equatable/equatable.dart';

part 'create_classroom_event.dart';
part 'create_classroom_state.dart';

class CreateClassroomBloc extends Bloc<CreateClassroomEvent, CreateClassroomState> {

  ClassroomServices classroomServices = ClassroomServices.Instants;

  CreateClassroomBloc() : super(CreateClassroomInitial()) {
    on<CreateClassroomRequest>((event, emit) => _createClass(event));
  }

  _createClass(CreateClassroomRequest event){
    emit(CreateClassroomLoading());
    classroomServices.createClassroom(classroom: event.classroom, onSuccess: (){
      emit(CreateClassroomSuccessful());
    }, onFailure: (error){
      emit(CreateClassroomFailure(error));
    });
  }

}
