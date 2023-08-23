import 'package:class_room_chin/bloc/join_class/join_class_bloc.dart';
import 'package:class_room_chin/components/CustomImage.dart';
import 'package:class_room_chin/components/EmptyView.dart';
import 'package:class_room_chin/components/Loading.dart';
import 'package:class_room_chin/components/PresentWidget/present_widget.dart';
import 'package:class_room_chin/components/SnackBar.dart';
import 'package:class_room_chin/components/animation/ChangeWidgetAnimation.dart';
import 'package:class_room_chin/constants/enum/PermissionManagerType.dart';
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:class_room_chin/extension/NavigatorContext.dart';
import 'package:class_room_chin/extension/Optional.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/screen/scan_qr/ScanQRScreen.dart';
import 'package:class_room_chin/utils/PermissionManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/CustomButton.dart';
import '../../components/CustomScaffoldWithAppBar.dart';
import '../../components/CustomTextField.dart';

/// view
class JoinClassroom extends StatefulWidget {
  const JoinClassroom({super.key});

  @override
  State<JoinClassroom> createState() => _JoinClassroomState();
}

class _JoinClassroomState extends State<JoinClassroom> {
  final TextEditingController _classIdController = TextEditingController();
  bool _scanQRClick = false;
  late final JoinClassBloc _bloc;
  late final PresentController _presentController;

  @override
  Widget build(BuildContext context) {
    return PresentWidget(
        controller: _presentController,
        child: CustomScaffoldWithAppbar(
          title: 'Join class',
          actions: [
            IconButton(
                onPressed: _qrScanButtonHandler,
                icon: const Icon(Icons.qr_code_2_rounded))
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Use a classroom code of 5-7 letters and numbers, no spaces or symbols to join class',
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _classIdController,
                  hintText: 'Class code',
                  prefixIcon: const Icon(Iconsax.main_component),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(text: 'OK', onClick: _showClassInfo)
              ],
            ),
          ),
        )
    );
  }

  Widget _classInfoContent(Classroom classroom) => Container(
    color: context.getDynamicColor.background,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        AspectRatio(
          aspectRatio: 16/12,
          child: CustomImage(
            classroom.img,
            borderRadius: 15,
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          classroom.className,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          'Tern: ${classroom.tern}',
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 20,),
        Text(
          classroom.description,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(text: 'Cancel', onClick: () {_presentController.hidePresent();}),
            CustomButton(text: 'Join class', onClick: () {_bloc.joinClass(classroom);})
          ],
        ),
        const SizedBox(height: 20,)
      ],
    ),
  );

  Widget _empty() =>  Scaffold(
    body: const EmptyView(
      text: 'Not found class!',
    ),
    bottomNavigationBar: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(text: 'Close', onClick: _presentController.hidePresent),
        ),
        const SizedBox(height: 50,)
      ],
    ),
  );
  /// inactive 1
  /// paused 2
  /// resumed 0
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0 && _scanQRClick) {
      _handleOnResume();
    }
  }

  @override
  void initState() {
    _bloc = JoinClassBloc();
    _presentController = PresentController();
    super.initState();
  }

}

/// private func
extension on _JoinClassroomState {
  _handleOnResume() async {
    PermissionManager.instants
        .checkPermissionStatus(type: PermissionManagerType.camera)
        .then((value) {
      if (value.isDenied) {
        ShowSnackbar(context, content: 'Permission is denied', type: SnackBarType.error);
      } else {
        context.startActivity<String>(const ScanQRScreen(), duration: const Duration(milliseconds: 300))
            .then(_onReceiveClassID);
      }
      _scanQRClick = false;
    });
  }

  _qrScanButtonHandler() {
    _scanQRClick = true;
    PermissionManager.instants.requestPermissionIfNeed(
        type: PermissionManagerType.camera, onCompete: _qrScanCompleteHandler);
  }

  _qrScanCompleteHandler(bool granted) {
    if (granted) {
      context.startActivity<String>(const ScanQRScreen(), duration: const Duration(milliseconds: 300))
          .then(_onReceiveClassID);
      _scanQRClick = false;
    }
  }

  _onReceiveClassID(String? classID) {
    if(_classIdController.guard) {
      setState(() {
        _classIdController.text = classID!;
      });
    }
  }

  _showClassInfo() {
    FocusScope.of(context).requestFocus(FocusNode());
    if(_classIdController.text.isNotEmpty && _classIdController.text.length > 7) {
      _bloc.showClassInfo(_classIdController.text);
      _presentController.showPresent(content: _classInfo());
    } else {
      ShowSnackbar(
          context
          , content: 'Class code invalidate!',
        type: SnackBarType.error
      );
    }
  }

  Widget _classInfo() => Container(
      color: context.getDynamicColor.background,
      child: ChangeWidgetAnimation(
        child: BlocConsumer<JoinClassBloc, JoinClassState>(
          bloc: _bloc,
          listenWhen: (_, __) => true,
          listener: (_, state) {
            if(state == JoinClassState.joinError) {
             _presentController.hidePresent();
              ShowSnackbar(context, content: _bloc.error, type: SnackBarType.error);
            }
            if(state == JoinClassState.loading) {
              _presentController.dismissible = false;
            } else {
              _presentController.dismissible = true;
            }
          },
          builder: (_, state) {
            if(state == JoinClassState.loading) {
              return const Loading();
            }
            if(state == JoinClassState.failure) {
              return _empty();
            }
            return _classInfoContent(_bloc.classroom!);
          },
        ),
      )
  );
}


