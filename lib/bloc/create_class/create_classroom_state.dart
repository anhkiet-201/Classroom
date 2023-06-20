part of 'create_classroom_bloc.dart';

abstract class CreateClassroomState extends Equatable {
  const CreateClassroomState();
}

class CreateClassroomInitial extends CreateClassroomState {
  @override
  List<Object> get props => [];
}

class CreateClassroomLoading extends CreateClassroomState {
  @override
  List<Object> get props => [];
}

class CreateClassroomSuccessful extends CreateClassroomState {
  @override
  List<Object> get props => [];
}

class CreateClassroomFailure extends CreateClassroomState {
  final String error;
  const CreateClassroomFailure(this.error);
  @override
  List<Object> get props => [error];
}


