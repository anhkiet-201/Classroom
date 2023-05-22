import 'package:bloc/bloc.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/services/ClassroomServices.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  ClassroomServices classroomServices = ClassroomServices.Instants;

  HomeBloc() : super(HomeInitial()) {
    on<HomeFetchRequest>((event, emit) => _classroomFetch());
    on<HomeRefresh>((event, emit) => _classroomRefesh());
  }

  _classroomFetch(){
    emit(HomeFetchLoading());
    classroomServices.getClassList(onSuccess: (result){
      emit(HomeFetchSuccessful(result));
    }, onFailure: (error){
      emit(HomeFetchFailure(error));
    });
  }

  _classroomRefesh(){
    emit(HomeRefreshLoading());
    classroomServices.getClassList(onSuccess: (result){
      emit(HomeRefreshSuccessful(result));
    }, onFailure: (error){
      emit(HomeRefreshFailure(error));
    });
  }

}
