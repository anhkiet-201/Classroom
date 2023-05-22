import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/Colors.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

ShowSnackbar(BuildContext context,
        {required String title, required String content, bool closeButton = false}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 125,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
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
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));

String createClassID() {
  const CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
  Random random = Random(DateTime.now().microsecond);
  String result = '';
  while (result.length < 8) {
    result += CHARS[random.nextInt(CHARS.length)];
  }
  return result;
}

Future<T?> navigatorPush<T>(BuildContext context, Widget target) =>
    Navigator.of(context).push<T>(PageRouteBuilder<T>(
        /// [opaque] set false, then the detail page can see the home page screen.
        opaque: false,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        fullscreenDialog: true,
        pageBuilder: (context, _, __) => target,
        transitionsBuilder: (context, animation, _, child) {
          //Animation<Offset> animationOffset = Tween<Offset>(begin: const Offset(0,-0.5), end:Offset.zero ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }));

//Future<T?> navigatorPush<T>(BuildContext context, Widget target) => Navigator.of(context).push(MaterialPageRoute(builder: (_)=>target));

