part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeFetchLoading extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class HomeRefreshLoading extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class HomeFetchSuccessful extends HomeState{
  final List<Classroom> classrooms;
  const HomeFetchSuccessful(this.classrooms);
  @override
  // TODO: implement props
  List<Object?> get props => [classrooms];
}

class HomeFetchFailure extends HomeState{
  final String error;

  const HomeFetchFailure(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}

class HomeRefreshSuccessful extends HomeState{
  final List<Classroom> classrooms;
  const HomeRefreshSuccessful(this.classrooms);
  @override
  // TODO: implement props
  List<Object?> get props => [classrooms];
}

class HomeRefreshFailure extends HomeState{
  final String error;

  const HomeRefreshFailure(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}