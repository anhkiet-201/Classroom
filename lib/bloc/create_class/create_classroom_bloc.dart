import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_classroom_event.dart';
part 'create_classroom_state.dart';

class CreateClassroomBloc extends Bloc<CreateClassroomEvent, CreateClassroomState> {
  CreateClassroomBloc() : super(CreateClassroomInitial()) {
    on<CreateClassroomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
