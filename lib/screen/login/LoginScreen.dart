
import 'package:class_room_chin/bloc/login/login_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/animation/ChangeWidgetAnimation.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/screen/home/HomeScreen.dart';
import 'package:class_room_chin/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/EmailField.dart';
import '../../components/Line.dart';
import '../../components/PasswordField.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context,state){
          if(state is LoginSuccess){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomeScreen()));
          }

          if(state is LoginFailure){
            ShowSnackbar(context, title: "Error!", content: state.error);
          }

        },
        listenWhen: (_,state){
          return true;
        },
        builder: ( context, state) {

          if(state is LoginLoading) {
            return Scaffold(
              body: Center(
                child:  LoadingAnimationWidget.twistingDots(
                  size: 50,
                  leftDotColor: classColor2,
                  rightDotColor: classColor3,
                ),
              ),
            );
          }

          return _BuildContent(context);


        },
      )
    );
  }

  Scaffold _BuildContent(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
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
                                        color: primaryColor.withOpacity(0.6)),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      EmailField(
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PasswordField(
                        controller: _passController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButton(
                        text: "Login",
                        onClick: () {
                          context.read<LoginBloc>().add(LoginRequest(_emailController.text.trim(), _passController.text.trim()));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: Text("Forget password?")),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Line(
                        text: "Or",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: "Facebook",
                        onClick: () {},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: "Google",
                        onClick: () {},
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )));
  }
}


