
import 'package:class_room_chin/bloc/signup/sign_up_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/CustomTextField.dart';
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

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
        child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if(state is SignUpSuccess){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomeScreen()));
          }

          if(state is SignUpFailure){
            ShowSnackbar(context, title: "Error!", content: state.error);
          }
        },
        listenWhen: (_, state) {
          return true;
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return Scaffold(
              body: Center(
                child: LoadingAnimationWidget.twistingDots(
                  size: 50,
                  leftDotColor: color2,
                  rightDotColor: color3,
                ),
              ),
            );
          }
        return _BuildContent(context);
      },
    ));
  }

  Scaffold _BuildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
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
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                        hintText: 'Username',
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        controller: _usernameController,
                      ),
                      const SizedBox(
                        height: 30,
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
                        text: "Signup",
                        onClick: () {
                          context.read<SignUpBloc>().add(SignUpRequest(email: _emailController.text.trim(), password: _passController.text, username: _usernameController.text));
                        },
                      ),
                      const SizedBox(
                        height: 30,
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
        ));
  }
}
