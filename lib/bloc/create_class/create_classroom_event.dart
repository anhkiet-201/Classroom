part of 'create_classroom_bloc.dart';

abstract class CreateClassroomEvent extends Equatable {
  const CreateClassroomEvent();
}

class CreateClassroomRequest extends CreateClassroomEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
