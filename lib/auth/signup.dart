import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/auth/widgets/errors.dart';
import 'package:chat_app/auth/widgets/auth.constants.dart';
import 'package:chat_app/auth/widgets/custombutton.dart';
import 'package:chat_app/auth/widgets/textfiled.dart';
import 'package:chat_app/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
    static const id = "signout";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Authservices _authServices = Authservices();

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController cpasswordC = TextEditingController();

  String email = "";
  String password = "";
  String cpassword = "";

  bool isvisible = false;
  bool isvisible1 = false;

  Future<void> signup() async {
    try {
      final user = await _authServices.createuser(email, password);
      if (user != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      Alert(
        context: context,
        title: AuthErrors.errorAlert,
        desc: "$e",
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AuthColor.splashclr,
      body: SingleChildScrollView(
        child: Padding(
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
                  AuthConstants.creataccount,
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
                  obscuretext: false,
                  onchangtext: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  controller: emailC,
                  fontfamily: AuthConstants.poppinmedium,
                  fontsize: 12.sp,
                  fontweight: FontWeight.w500,
                  labeltext: AuthConstants.email,
                  prefixicon: Icon(
                    Icons.person_rounded,
                    color: AuthColor.iconclr,
                    size: 24.sp,
                  ),
                  texttype: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Textfield(
                  texttype: TextInputType.text,
                  obscuretext: isvisible,
                  onchangtext: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  controller: passwordC,
                  fontfamily: AuthConstants.poppinmedium,
                  fontsize: 12.sp,
                  fontweight: FontWeight.w500,
                  labeltext: AuthConstants.password,
                  prefixicon: Icon(
                    Icons.lock,
                    color: AuthColor.iconclr,
                    size: 24.sp,
                  ),
                  suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                    icon: Icon(
                      isvisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AuthColor.iconclr,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Textfield(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty";
                    }
                    if (passwordC.text != cpasswordC.text) {
                      return AuthErrors.passwordSignupError;
                    }
                    return null;
                  },
                  texttype: TextInputType.text,
                  obscuretext: isvisible1,
                  onchangtext: (value) {
                    setState(() {
                      cpassword = value;
                    });
                  },
                  controller: cpasswordC,
                  fontfamily: AuthConstants.poppinmedium,
                  fontsize: 12.sp,
                  fontweight: FontWeight.w500,
                  labeltext: AuthConstants.confirmpassword,
                  prefixicon: Icon(
                    Icons.lock,
                    color: AuthColor.iconclr,
                    size: 24.sp,
                  ),
                  suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        isvisible1 = !isvisible1;
                      });
                    },
                    icon: Icon(
                      isvisible1
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AuthColor.iconclr,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                RichText(
                  text: TextSpan(
                    text: AuthConstants.alreadyaccount,
                    style: TextStyle(
                      color: AuthColor.labelclr,
                      fontFamily: AuthConstants.poppinmedium,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    children: [
                      TextSpan(
                        text: AuthConstants.signin,
                        style: TextStyle(
                          color: AuthColor.forgotbuttonclr,
                          fontFamily: AuthConstants.poppinmedium,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, "/signin"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AuthConstants.register,
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
                        onPress: signup,
                        shape: const CircleBorder(),
                        size: 22.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13.h,
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
      ),
    );
  }
}
