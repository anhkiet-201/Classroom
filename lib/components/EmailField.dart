import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../utils/Utils.dart';
import 'CustomTextField.dart';

class EmailField extends StatefulWidget {
  const EmailField({Key? key, this.controller}) : super(key: key);
  final TextEditingController? controller;
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  bool _visiable = false;
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: 'Email',
      inputType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined),
      onChange: (value){
        if(value.isNotEmpty){
          _visiable = true;
          if(isValidEmail(value)){
            _isValid = true;
          }else{
            _isValid = false;
          }
        }else{
          _visiable = false;
        }
        setState(() {

        });
      },
      suffixIcon: Visibility(
        visible: _visiable,
        child: _isValid ? const Icon(Icons.check, color: Colors.green,) : const Icon(Icons.close,color: Colors.redAccent,),
      ),
    );
  }



}
