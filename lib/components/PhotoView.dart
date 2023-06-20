import 'package:class_room_chin/components/CustomImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhotoView extends StatelessWidget {
  const PhotoView(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
            child: CustomImage(url, fit: BoxFit.contain,),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back), color: Colors.white,padding: const EdgeInsets.all(20),),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
