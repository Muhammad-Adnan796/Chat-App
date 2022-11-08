import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/auth/forgotpass.dart';
import 'package:chat_app/auth/otp.dart';
import 'package:chat_app/auth/signup.dart';
import 'package:chat_app/auth/widgets/errors.dart';
import 'package:chat_app/auth/widgets/auth.constants.dart';
import 'package:chat_app/auth/widgets/custombutton.dart';
import 'package:chat_app/auth/widgets/facbook_usermodal_class.dart';
import 'package:chat_app/auth/widgets/textfiled.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const id = "signin";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final Authservices _authServices = Authservices();

  String email = "";
  String password = "";

  bool isvisible = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> signin() async {
    try {
      if (email.isEmpty || password.isEmpty) {
        Alert(
                context: context,
                title: AuthErrors.errorAlert,
                desc: AuthErrors.enterValidCredentials)
            .show();
      }

      EasyLoading.isShow;
      User? loggedinuser = await _authServices.login(email, password);
      EasyLoading.dismiss();

      if (loggedinuser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Alert(
                context: context,
                title: AuthErrors.errorAlert,
                desc: AuthErrors.userNotFound)
            .show();
      }
    } catch (e) {
      Alert(
        context: context,
        title: AuthErrors.errorAlert,
        desc: "$e",
      ).show();
    }
  }

  GoogleSignIn gsn = GoogleSignIn();
  Future<void> googlesignin(BuildContext context) async {
    await gsn.signIn();
    if (gsn.currentUser != null) {
      print(gsn.currentUser!.displayName);
      print(gsn.currentUser!.photoUrl);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  FacebookAuth facebookAuth = FacebookAuth.instance;
  bool loggedin = false;
 static AccessToken? _accessToken;
 static UserModal? _currentUser;

  Future<void> facebooklogin() async {
    try {
      final LoginResult result = await facebookAuth.login();
      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken;
        final data = await facebookAuth.getUserData();
        UserModal modal = UserModal.fromJson(data);

        _currentUser = modal;
        setState(() {});
      }
      UserModal? user = _currentUser;
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              pictur: user.pictureModal!.url,
              username: user.name,
              width: user.pictureModal!.width! / 6,
              subtitle: user.email,
            ),
          ),
        );
      }
    } catch (error) {
      Alert(
        context: context,
        title: AuthErrors.errorAlert,
        desc: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColor.splashclr,
      resizeToAvoidBottomInset: true,
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
                  obscuretext: false,
                  validator: (value) {
                    if (value == null && value.isEmpty && value.contains("@")) {
                      return 'Please enter valid email.';
                    }
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter atleast 6 characters long';
                    }
                    return null;
                  },
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
                  height: 1.h,
                ),
                RichText(
                  text: TextSpan(
                    text: AuthConstants.dontaccount,
                    style: TextStyle(
                      color: AuthColor.labelclr,
                      fontFamily: AuthConstants.poppinmedium,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                    children: [
                      TextSpan(
                        text: AuthConstants.signup,
                        style: TextStyle(
                          color: AuthColor.forgotbuttonclr,
                          fontFamily: AuthConstants.poppinmedium,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      AuthConstants.forgotpassword,
                      style: TextStyle(
                        color: AuthColor.forgotbuttonclr,
                        fontFamily: AuthConstants.poppinmedium,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AuthConstants.signin,
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
                        onPress: signin,
                        shape: const CircleBorder(),
                        size: 22.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: Text(
                    AuthConstants.signinwith,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AuthColor.labelclr,
                      fontFamily: AuthConstants.poppinlight,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        googlesignin(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: AuthColor.iconclr,
                                spreadRadius: 2)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: AuthColor.filedclr,
                          radius: 20.sp,
                          child: Image.asset(
                            "images/google_pic.png",
                            height: 4.5.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpCode(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: AuthColor.iconclr,
                                spreadRadius: 2)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: AuthColor.filedclr,
                          radius: 20.sp,
                          child: Image.asset(
                            "images/phone_pic.png",
                            height: 4.5.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: facebooklogin,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: AuthColor.iconclr,
                                spreadRadius: 2)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: AuthColor.filedclr,
                          radius: 20.sp,
                          child: Image.asset(
                            "images/fb_pic.png",
                            height: 4.5.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
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
