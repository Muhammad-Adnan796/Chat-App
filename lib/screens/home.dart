import 'package:chat_app/auth/auth_services.dart';
import 'package:chat_app/auth/widgets/errors.dart';
import 'package:chat_app/auth/signin.dart';
import 'package:chat_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../auth/widgets/auth.constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.pictur, this.username, this.subtitle, this.width})
      : super(key: key);

  String? pictur;
  String? username;
  String? subtitle;
  var width;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Authservices _authservices = Authservices();

  GoogleSignIn gsn = GoogleSignIn();
  FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<void> signOut() async {
    await _authservices.signout();
    await gsn.signOut();
    await facebookAuth.logOut();

    Alert(
            context: context,
            title: AuthErrors.errorAlert,
            desc: AuthErrors.signupsccenful)
        .show();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: AuthColor.splashclr,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            widget.username.toString(),
            style: TextStyle(
              color: AuthColor.authtitleclr,
              fontFamily: AuthConstants.poppinmedium,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
          ),
          actions: [
            PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          signOut();
                        },
                        value: 1,
                        child: Text("Logout"),
                      )
                    ])
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.pictur.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ListTile(
                // leading: CircleAvatar(
                //   radius: widget.width,
                //   child:
                // ),
                title: Text(
                  widget.username.toString(),
                  style: TextStyle(
                    color: AuthColor.authtitleclr,
                    fontFamily: AuthConstants.poppinmedium,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
                subtitle: Text(
                  widget.subtitle.toString(),
                  style: TextStyle(
                    color: AuthColor.authtitleclr,
                    fontFamily: AuthConstants.poppinmedium,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
