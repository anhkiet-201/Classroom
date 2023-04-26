import 'package:class_room_chin/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/screen/edit_profile/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import '../../constants/FirebaseConstants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithAppbar(
      title: 'Profile',
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(
                AUTH.currentUser?.photoURL ?? '',
                height: 150,
                width: 150,
                borderRadius: 80,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AUTH.currentUser?.displayName ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      AUTH.currentUser?.email ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.read<EditProfileBloc>().add(EditProfileFetch());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const EditProfile()))
                    .then((value){
                      setState(() {

                      });
                    });
                  },
                  icon: const Icon(Iconsax.edit_2))
            ],
          )
        ],
      ),
    );
  }
}

