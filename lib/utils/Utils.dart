

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/Colors.dart';

bool isValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

ShowSnackbar(BuildContext context, {required String title, required String content}) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 125,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.close, color: Colors.white,size: 24,),
                  onTap: (){
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                )
              ],
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: Text(content),
            )
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    )
);