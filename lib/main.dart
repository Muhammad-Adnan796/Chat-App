import 'package:chat_app/auth/code.dart';
import 'package:chat_app/auth/otp.dart';
import 'package:chat_app/auth/signin.dart';
import 'package:chat_app/auth/signup.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAotKfpEuUUCXIKDgW61u3QR-meHBl32fQ",
            authDomain: "chat-app-45b37.firebaseapp.com",
            projectId: "chat-app-45b37",
            storageBucket: "chat-app-45b37.appspot.com",
            messagingSenderId: "94385872291",
            appId: "1:94385872291:web:b3a266f1c314c651a1ce16",
            measurementId: "G-B0Y5G4KWJQ"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          // "/signin": (context) => SignIn(),
          "/forgotpassword": (context) => OtpCode(),
          // "/signup": (context) => SignUp(),
          // "/homescreen": (context) => HomeScreen(),
        },
      );
    });
  }
}
