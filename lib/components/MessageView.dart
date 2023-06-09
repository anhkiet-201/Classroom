import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/FirebaseConstants.dart';
import '../models/Message.dart';
import 'CustomImage.dart';

class MessageView extends StatelessWidget {
  const MessageView(this.messages, {Key? key}) : super(key: key);
  final List<Message> messages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (_, index){
          final message = messages[index];
          return message.uid == AUTH.currentUser!.uid ? _BMessage(message, context) : _AMessage(message, context);
        },
      ),
    );
  }

  Padding _AMessage(Message message, BuildContext context) {
    final time = DateTime.fromMicrosecondsSinceEpoch(message.time);
    const radius = Radius.circular(20);
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomImage(
                AUTH.currentUser?.photoURL ?? '',
                height: 30,
                width: 30,
                borderRadius: 25,
              ),
              const SizedBox(width: 10,),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: context.getDynamicColor().secondaryContainer,
                    borderRadius: const BorderRadius.only(
                        topLeft: radius,
                        topRight: radius,
                        bottomRight: radius
                    )
                  ),
                  child: Text(
                      message.content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: context.getDynamicColor().onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  DateFormat().add_E().add_d().add_MMM().addPattern('-').add_Hm().format(time).toString(),
                  style: const TextStyle(
                    fontSize: 12
                  ),
                ),
              )
            ],
          ),
        );
  }

  Padding _BMessage(Message message, BuildContext context) {
    final time = DateTime.fromMicrosecondsSinceEpoch(message.time);
    const radius = Radius.circular(20);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              DateFormat().add_E().add_d().add_MMM().addPattern('-').add_Hm().format(time).toString(),
              style: const TextStyle(
                  fontSize: 12
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: context.getDynamicColor().scrim,
                  borderRadius: const BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                    bottomLeft: radius
                  )
              ),
              child: Text(
                  message.content,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

