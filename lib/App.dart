import 'package:class_room_chin/bloc/login/login_bloc.dart';
import 'package:class_room_chin/screen/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginBloc())
        ], 
        child: LoginScreen()
    );
  }
}
