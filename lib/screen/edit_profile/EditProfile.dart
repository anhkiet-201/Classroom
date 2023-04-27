import 'dart:io';
import 'package:class_room_chin/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/EmailField.dart';
import 'package:class_room_chin/constants/FirebaseConstants.dart';
import 'package:class_room_chin/models/UserRepostory.dart';
import 'package:flutter/material.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/CustomTextField.dart';
import '../../components/Loading.dart';
import '../../components/animation/ChangeWidgetAnimation.dart';
import '../../utils/Utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  XFile? _xFile;


  @override
  void initState() {
    context.read<EditProfileBloc>().add(EditProfileFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ShowSnackbar(context, title: "Error!", content: 'Update successful!');
          Navigator.of(context).maybePop();
        }

        if (state is EditProfileFailure) {
          ShowSnackbar(context, title: "Error!", content: state.error);
        }
      },
      listenWhen: (_, state) {
        return true;
      },
      builder: (context, state) {
        if (state is EditProfileLoading) {
          return const Loading();
        }

        if (state is EditProfileSuccess) {
          return const Loading();
        }

        if (state is EditProfileFetched) {
          final user = state.user;
          _birthdayController.text = user.birthday;
          _emailController.text = user.email;
          _usernameController.text = user.userName;
        }

        return _content(context);
      },
    ));
  }

  Widget _content(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'Edit Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  child: _xFile == null
                      ? CustomImage(
                          AUTH.currentUser?.photoURL ?? '',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          borderRadius: 75,
                        )
                      : ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(75)),
                          child: Image.file(
                            File(_xFile!.path),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (_, e, s) => const Center(
                                child:
                                    Text('This image type is not supported')),
                          ),
                        )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () async {
                        var result = (imagePicker.pickImage(
                            source: ImageSource.gallery));
                        _xFile = await result;
                        setState(() {});
                      },
                      icon: const Icon(Iconsax.edit_2)))
            ],
          ),
          Text(
            AUTH.currentUser?.displayName ?? '',
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 30,
          ),
          EmailField(
            controller: _emailController,
            enable: false,
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
          const SizedBox(
            height: 30,
          ),
          CustomButton(
              text: 'Save',
              onClick: () {
                context.read<EditProfileBloc>().add(EditProfileUpdate(
                    Userrepostory(
                        email: _emailController.text,
                        userName: _usernameController.text,
                        birthday: _birthdayController.text,
                        img: ''),
                    _xFile == null ? null : File(_xFile!.path)));
              }),
        ],
      ),
    );
  }
}
