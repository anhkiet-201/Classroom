import 'package:class_room_chin/bloc/signup/sign_up_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/CustomTextField.dart';
import 'package:class_room_chin/components/Loading.dart';
import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/components/animation/ChangeWidgetAnimation.dart';
import 'package:class_room_chin/screen/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/EmailField.dart';
import '../../components/PasswordField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdayController =
      TextEditingController(text: '01/01/2001');

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
        child: BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()));
        }
        if (state is SignUpFailure) {
          ShowSnackbar(context, type: SnackBarType.error, content: state.error);
        }
      },
      listenWhen: (_, state) {
        return true;
      },
      builder: (context, state) {
        if (state is SignUpLoading) {
          return const Loading();
        }
        return _BuildContent(context);
      },
    ));
  }

  Scaffold _BuildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                      CustomTextField(
                        hintText: 'Birthday',
                        prefixIcon: const Icon(Icons.date_range_outlined),
                        readOnly: true,
                        controller: _birthdayController,
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now())
                              .then((value) {
                            if (value != null) {
                              _birthdayController.text =
                                  '${value.month}/${value.day}/${value.year}';
                            }
                          });
                        },
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
                        text: "Signup",
                        onClick: () {
                          context.read<SignUpBloc>().add(
                              SignUpRequest(
                                  email: _emailController.text.trim(),
                                  password: _passController.text,
                                  username: _usernameController.text,
                                  birthday: _birthdayController.text
                              )
                          );
                        },
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
