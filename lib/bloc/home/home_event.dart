part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeFetchRequest extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class HomeRefresh extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
