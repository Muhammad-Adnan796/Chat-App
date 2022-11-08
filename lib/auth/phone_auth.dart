import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/auth/widgets/errors.dart';
import 'package:chat_app/colors.dart';
import 'package:chat_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import 'widgets/auth.constants.dart';
import 'widgets/custombutton.dart';

class PhoneAuth {
  Future<void> loginwithPhone(
    BuildContext context,
    String phone,
  ) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController otpC = TextEditingController();
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        Navigator.pop(context);
        User? user = result.user;
        if (user != null) {
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
            desc: AuthErrors.userNotFound,
          ).show();
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        Alert(
          context: context,
          title: AuthErrors.errorAlert,
          desc: e.toString(),
        ).show();
      },
      codeSent: (
        String verificationcode,
        var token,
      ) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                backgroundColor: AuthColor.splashclr,
                title: const Text(
                  AuthConstants.otptext,
                  style: TextStyle(
                      fontFamily: AuthConstants.poppinmedium,
                      color: AuthColor.authtitleclr),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PinCodeTextField(
                      validator: (value) {
                        if (value == null) {
                          return AuthErrors.someThingWrong.toString();
                        }
                        return null;
                      },
                      controller: otpC,
                      enableActiveFill: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enablePinAutofill: true,
                      enabled: true,
                      textStyle: const TextStyle(
                          fontFamily: AuthConstants.poppinsemibold,
                          color: AuthColor.authtitleclr),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(7),
                        fieldWidth: 30,
                        selectedColor: AuthColor.filedclr,
                        disabledColor: AuthColor.filedclr,
                        inactiveFillColor: AuthColor.filedclr,
                        activeColor: AuthColor.filedclr,
                        activeFillColor: AuthColor.filedclr,
                        inactiveColor: AuthColor.filedclr,
                        fieldOuterPadding: EdgeInsets.zero,
                        selectedFillColor: AuthColor.filedclr,
                      ),
                      length: 6,
                      obscureText: false,
                      animationDuration: Duration(milliseconds: 300),
                      appContext: context,
                      onChanged: (value) {
                        // setState(() {
                        //   currentText = value;
                        // });
                      },
                    ),
                  ],
                ),
                actions: [
                 SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              title: Text(
                AuthConstants.verify,
                style: TextStyle(
                  fontFamily: AuthConstants.poppinsemibold,
                  color: AuthColor.authtitleclr,
                ),
              ),
              color: AuthColor.forgotbuttonclr,
              elevation: 20,
              backgroundColor: AuthColor.forgotbuttonclr,
               onPress: () async {
                        final code = otpC.text;
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationcode,
                                smsCode: code);
                        UserCredential result =
                            await _auth.signInWithCredential(credential);
                        User? user = result.user;
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );

                          print('successs');
                        } else {
                          Fluttertoast.showToast(msg: 'error');
                        }
                      },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              size: 40.sp,
            ),
          ),
        ),
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (id) => {},
    );
  }
}






















//  final _formKey = GlobalKey<FormState>();
//     AlertDialog alert = AlertDialog(
//       backgroundColor: AuthColor.splashclr,
//       title: const Text(
//         AuthConstants.otptext,
//         style: TextStyle(
//             fontFamily: AuthConstants.poppinmedium,
//             color: AuthColor.authtitleclr),
//       ),
    //   content: Form(
    //     key: _formKey,
    //     child: PinCodeTextField(
    //       validator: (value) {
    //         if (value == null) {
    //           return AuthErrors.someThingWrong.toString();
    //         }
    //         return null;
    //       },
    //   controller: otpC,
    //       enableActiveFill: true,
    //       autovalidateMode: AutovalidateMode.onUserInteraction,


    //       enablePinAutofill: true,
    //       enabled: true,
    //       textStyle: const TextStyle(
    //           fontFamily: AuthConstants.poppinsemibold,
    //           color: AuthColor.authtitleclr),
    //       pinTheme: PinTheme(
    //         shape: PinCodeFieldShape.box,
    //         borderRadius: BorderRadius.circular(7),
    //         fieldWidth: 30,
    //         selectedColor: AuthColor.filedclr,
    //         disabledColor: AuthColor.filedclr,
    //         inactiveFillColor: AuthColor.filedclr,
    //         activeColor: AuthColor.filedclr,
    //         activeFillColor: AuthColor.filedclr,
    //         inactiveColor: AuthColor.filedclr,
    //         fieldOuterPadding: EdgeInsets.zero,
    //         selectedFillColor: AuthColor.filedclr,
    //       ),
    //       length: 6,
    //       obscureText: false,
    //       animationDuration: Duration(milliseconds: 300),
    //       appContext: context,
    //       onChanged: (value) {
    //         // setState(() {
    //         //   currentText = value;
    //         // });
    //       },
    //     ),
    //   ),
    //   actions: [
    //     SizedBox(
    //       height: 60,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: CustomButton(
    //           title: Text(
    //             AuthConstants.verify,
    //             style: TextStyle(
    //               fontFamily: AuthConstants.poppinsemibold,
    //               color: AuthColor.authtitleclr,
    //             ),
    //           ),
    //           color: AuthColor.forgotbuttonclr,
    //           elevation: 20,
    //           backgroundColor: AuthColor.forgotbuttonclr,
    //           onPress: () async {
    //              final code = otpC.text;
    //             AuthCredential credential = PhoneAuthProvider.credential(
    //               verificationId: verificationcode,
    //               smsCode: code,
    //             );
    //             UserCredential result = await _auth.signInWithCredential(credential);
    //             User? user = result.user;
    //             if (user != null) {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => HomeScreen(),
    //                 ),
    //               );
                 
    //             } else {
    //               Alert(
    //                 context: context,
    //                 title: AuthErrors.errorAlert,
    //                 desc: AuthErrors.someThingWrong,
    //               ).show();
    //             }
    //           },
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           size: 40.sp,
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    // // show the dialog
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return alert;
    //   },
    // );