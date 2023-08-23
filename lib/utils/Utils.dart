import 'dart:math';

import 'package:flutter/services.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

String createClassID() {
  const CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
  Random random = Random(DateTime.now().microsecond);
  String result = '';
  while (result.length < 8) {
    result += CHARS[random.nextInt(CHARS.length)];
  }
  return result;
}

void copyToClipboard(String data) async {
  await Clipboard.setData(ClipboardData(text: data));
}
