import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/auth/signin.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

import 'auth/widgets/facbook_usermodal_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Authservices _authservices = Authservices();
  GoogleSignIn gsn = GoogleSignIn();
  FacebookAuth facebookAuth = FacebookAuth.instance;
 UserModal? _currentUser;
 

  @override
  Widget build(BuildContext context) {
     UserModal? user = _currentUser;
    return AnimatedSplashScreen(
      splash: Icon(
        CupertinoIcons.chat_bubble_2,
        color: AuthColor.forgotbuttonclr,
        size: 100.sp,
      ),
      nextScreen:
       gsn.currentUser != null ||
      user != null ||
       _authservices.currentUser != null
      
          ? HomeScreen()
          : const SignIn(),
      animationDuration: const Duration(seconds: 2),
      backgroundColor: AuthColor.splashclr,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
