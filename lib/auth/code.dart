// import 'package:chat_app/auth/errors.dart';
// import 'package:chat_app/auth/widgets/auth.constants.dart';
// import 'package:chat_app/auth/widgets/custombutton.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../colors.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

 
//   Future<void> alert(BuildContext context) {
//     return Alert(
//             buttons: [
//           DialogButton(
//               child: Text(AuthConstants.sendcode),
//               onPressed: () async {
              
//               }),
//         ],
//             context: context,
//             title: AuthConstants.otptext,
//             desc: Column(
//               children: [
//                 PinCodeTextField(
                  
//                   length: 6,
//                   obscureText: false,
//                   animationDuration: Duration(milliseconds: 300),
//                   appContext: context,
//                   onChanged: (value) {
//                     // setState(() {
//                     //   currentText = value;
//                     // });
//                   },
//                 )
//               ],
//             ).toString())
//         .show();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Center(
//               child: CustomButton(
//                 title: Icon(
//                   Icons.arrow_forward_rounded,
//                   color: AuthColor.authtitleclr,
//                   size: 22.sp,
//                 ),
//                 color: AuthColor.forgotbuttonclr,
//                 elevation: 20,
//                 backgroundColor: AuthColor.forgotbuttonclr,
//                 onPress: () {
//                   showAlertDialog(context);
//                 },
//                 shape: const CircleBorder(),
//                 size: 22.sp,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
