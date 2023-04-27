import 'package:class_room_chin/bloc/create_class/create_classroom_bloc.dart';
import 'package:class_room_chin/components/CustomButton.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/components/CustomTextField.dart';
import 'package:class_room_chin/constants/FirebaseConstants.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../bloc/home/home_bloc.dart';
import '../../components/Loading.dart';
import '../../components/animation/ChangeWidgetAnimation.dart';
import '../../utils/Utils.dart';

class CreateClassroom extends StatelessWidget {
  CreateClassroom({Key? key}) : super(key: key);

  final _classNameController = TextEditingController();
  final _ternController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeWidgetAnimation(
        child: BlocConsumer<CreateClassroomBloc, CreateClassroomState>(
          listener: (context, state) {
            if (state is CreateClassroomSuccessful) {
              ShowSnackbar(context, title: "Congratulations!", content: 'Create classroom successful!');
              context.read<HomeBloc>().add(HomeFetchRequest());
              Navigator.of(context).maybePop();
            }

            if (state is CreateClassroomFailure) {
              ShowSnackbar(context, title: "Error!", content: state.error);
            }
          },
          listenWhen: (_, state) {
            return true;
          },
          builder: (context, state) {
            if (state is CreateClassroomLoading) {
              return const Loading();
            }

            return _content(context);
          },
        ));
  }

  CustomScaffoldWithAppbar _content(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'Cretae a new class',
      child: Column(
        children: [
          CustomTextField(
            controller: _classNameController,
            hintText: 'Class name (required)',
            prefixIcon: const Icon(Iconsax.note_add),
          ),
          CustomTextField(
            controller: _ternController,
            hintText: 'Tern',
            prefixIcon: const Icon(Iconsax.timer_1),
          ),
          CustomTextField(
            controller: _descriptionController,
            hintText: 'Short description',
            prefixIcon: const Icon(Iconsax.main_component),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(text: 'OK', onClick: () {
            context.read<CreateClassroomBloc>().add(
              CreateClassroomRequest(
                  Classroom.create(className: _classNameController.text, classOwner: AUTH.currentUser!.uid, tern: _ternController.text, description: _descriptionController.text)
              )
            );
          })
        ],
      ));
  }
}
