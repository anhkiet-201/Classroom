import 'package:class_room_chin/bloc/create_class/create_classroom_bloc.dart';
import 'package:class_room_chin/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:class_room_chin/bloc/home/home_bloc.dart';
import 'package:class_room_chin/bloc/login/login_bloc.dart';
import 'package:class_room_chin/bloc/signup/sign_up_bloc.dart';
import 'package:class_room_chin/screen/home/HomeScreen.dart';
import 'package:class_room_chin/screen/login/LoginScreen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  final _defaultLightColorScheme = const ColorScheme.light();
  final _defaultDarkColorScheme = const ColorScheme.dark();

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LoginBloc()),
            BlocProvider(create: (_) => SignUpBloc(),),
            BlocProvider(create: (_) => HomeBloc()),
            BlocProvider(create: (_) => EditProfileBloc()),
            BlocProvider(create: (_) => CreateClassroomBloc())
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: lightColorScheme ?? _defaultLightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            home: FirebaseAuth.instance.currentUser == null ? LoginScreen() :  const HomeScreen(),
          )
      );
    });
  }
}
