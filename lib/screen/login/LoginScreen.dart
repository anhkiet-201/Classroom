
import 'package:class_room_chin/bloc/login/login_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/components/animation/ChangeWidgetAnimation.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/models/User.dart';
import 'package:class_room_chin/screen/home/HomeScreen.dart';
import 'package:class_room_chin/screen/signup/SignUpScreen.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/EmailField.dart';
import '../../components/Loading.dart';
import '../../components/PasswordField.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context,state){
          if(state is LoginSuccess){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const HomeScreen()));
          }
          if(state is LoginFailure){
            ShowSnackbar(context, type: SnackBarType.error, content: state.error);
          }

        },
        listenWhen: (_,state){
          return true;
        },
        builder: ( context, state) {
          if(state is LoginLoading) {
            return const Loading();
          }
          return _BuildContent(context);
        },
      )
    );
  }

  Scaffold _BuildContent(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'Sign in to continue,',
                              style: TextStyle(
                                  fontSize: 35,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      EmailField(
                        controller: _emailController,
                      ),
                      PasswordField(
                        controller: _passController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: "Login",
                        onClick: () {
                          context.read<LoginBloc>().add(LoginRequest(email:_emailController.text.trim(),password: _passController.text.trim()));
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: const Text("Forget password?")),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not a member?'),
                          TextButton(
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SignUpScreen()
                                  )
                                );
                              },
                              child: Text(
                                'Signup now.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor
                                ),
                              )
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}


