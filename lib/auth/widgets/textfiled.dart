import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'auth.constants.dart';

class Textfield extends StatelessWidget {
  String? prefixtext;
  var controller;
  final Function(String) onchangtext;
  dynamic Function(dynamic)? validator;
  TextInputType? texttype;
  IconButton? suffixicon;
  var prefixicon;
  String? labeltext;
  var fontfamily;
  var fontweight;
  double fontsize;
  var obscuretext;

  Textfield({
    this.prefixtext,
    this.controller,
    required this.onchangtext,
    this.validator,
    this.texttype,
    this.suffixicon,
    this.prefixicon,
    this.labeltext,
    this.fontfamily,
    this.fontweight,
    required this.fontsize,
    this.obscuretext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator as String? Function(String?)?,
      style: TextStyle(color: AuthColor.authtitleclr, fontSize: 12.sp),
      obscureText: obscuretext,
      cursorColor: AuthColor.labelclr,
      controller: controller,
      onChanged: onchangtext,
      keyboardType: texttype,
      decoration: InputDecoration(
        prefixText: prefixtext,
        prefixStyle: TextStyle(
            fontFamily: AuthConstants.poppinmedium,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AuthColor.labelclr,),
        suffixIcon: suffixicon,
        suffixIconColor: AuthColor.labelclr,
        filled: true,
        fillColor: AuthColor.filedclr,
        prefixIcon: prefixicon,
        prefixIconColor: AuthColor.labelclr,
        labelText: labeltext,
        labelStyle: TextStyle(
          fontFamily: fontfamily,
          fontWeight: fontweight,
          fontSize: fontsize,
          color: AuthColor.labelclr,
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AuthColor.filedclr),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AuthColor.filedclr)),
      ),
    );
  }
}
