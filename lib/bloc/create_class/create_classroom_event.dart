part of 'create_classroom_bloc.dart';

abstract class CreateClassroomEvent extends Equatable {
  const CreateClassroomEvent();
}

class CreateClassroomRequest extends CreateClassroomEvent{
  final Classroom classroom;
  const CreateClassroomRequest(this.classroom);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
