
import 'package:class_room_chin/extension/DynamicColor.dart';
import 'package:flutter/material.dart';

enum SnackBarType {
  error("Error!"), success("Congratulations!"), notification("Notification!");
  const SnackBarType(this.title);
  final String title;

  Color getColor(BuildContext context){
    switch(this) {
      case error: return context.getDynamicColor.error;
      case success: return context.getDynamicColor.primary;
      case notification: return context.getDynamicColor.primary;
    }
  }
}

ShowSnackbar(BuildContext context,
    {SnackBarType type = SnackBarType.success, required String content, bool closeButton = false}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 125,
          decoration: BoxDecoration(
              color: type.getColor(context),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    type.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Visibility(
                    visible: closeButton,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Text(content),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));