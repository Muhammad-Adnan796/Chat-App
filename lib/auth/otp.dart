import 'package:chat_app/auth/widgets/errors.dart';
import 'package:chat_app/auth/phone_auth.dart';
import 'package:chat_app/auth/widgets/auth.constants.dart';
import 'package:chat_app/auth/widgets/custombutton.dart';
import 'package:chat_app/auth/widgets/textfiled.dart';
import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class OtpCode extends StatefulWidget {
  const OtpCode({Key? key}) : super(key: key);

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> {
  TextEditingController inputController = TextEditingController();

  String phone = "";

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AuthColor.splashclr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Text(
                AuthConstants.welcombeck,
                style: TextStyle(
                  height: 0.9.sp,
                  color: AuthColor.authtitleclr,
                  fontFamily: AuthConstants.poppinbold,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.sp,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Textfield(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    Alert(
                            context: context,
                            title: AuthErrors.errorAlert,
                            desc: AuthErrors.someThingWrong)
                        .show();
                  }
                  return null;
                },
                obscuretext: false,
                onchangtext: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                controller: inputController,
                fontfamily: AuthConstants.poppinmedium,
                fontsize: 12.sp,
                fontweight: FontWeight.w500,
                labeltext: AuthConstants.phonenumber,
                prefixtext: AuthConstants.pakcode,
                
                prefixicon: Icon(
                  Icons.phone_android,
                  color: AuthColor.iconclr,
                  size: 24.sp,
                ),
                texttype: TextInputType.number,
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "*",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AuthColor.forgotbuttonclr,
                      fontFamily: AuthConstants.poppinlight,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  Column(
                    children: [
                      Text(
                        AuthConstants.sendcodetext,
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AuthColor.labelclr,
                          fontFamily: AuthConstants.poppinlight,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AuthConstants.link,
                      style: TextStyle(
                        color: AuthColor.authtitleclr,
                        fontFamily: AuthConstants.poppinbold,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    CustomButton(
                      title: Icon(
                        Icons.arrow_forward_rounded,
                        color: AuthColor.authtitleclr,
                        size: 22.sp,
                      ),
                      color: AuthColor.forgotbuttonclr,
                      elevation: 20,
                      backgroundColor: AuthColor.forgotbuttonclr,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          final phone = "+92" + inputController.text;
                          PhoneAuth().loginwithPhone(context, phone);
                        }
                      },
                      shape: const CircleBorder(),
                      size: 22.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AuthConstants.back,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AuthColor.labelclr,
                      fontFamily: AuthConstants.poppinlight,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
