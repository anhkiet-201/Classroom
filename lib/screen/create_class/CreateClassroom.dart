import 'package:class_room_chin/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateClassroom extends StatelessWidget {
  CreateClassroom({Key? key}) : super(key: key);

  final _classNameController = TextEditingController();
  final _ternController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Create a new class',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                controller: _classNameController,
                hintText: 'Class name',
                prefixIcon: const Icon(Iconsax.note_add),
              ),
              CustomTextField(
                controller: _ternController,
                hintText: 'Tern',
                prefixIcon: const Icon(Iconsax.timer_1),
              ),
              CustomTextField(
                controller: _subjectController,
                hintText: 'Subject',
                prefixIcon: const Icon(Iconsax.main_component),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
