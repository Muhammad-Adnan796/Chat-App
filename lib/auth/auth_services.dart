
import 'package:chat_app/auth/widgets/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthClass {
  Future<void> createuser(String email, String password);
  Future<void> login(String email, String password);
  Future<void> resetpassword(String email,);
  Future<void> signout();

  


  User? get currentUser;
}

class Authservices extends AuthClass {
  static final Authservices instance = Authservices();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Future<User?> createuser(String email, String password) async {
    try {
      final respnse = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (respnse.user == null) {
        throw Exception(AuthErrors.userCreationFailed);
      }
      return respnse.user;
    } catch (e) {
      debugPrint("${AuthErrors.userCreationFailed} $e");
      rethrow;
    }
  }

  @override
  User? get currentUser => _auth.currentUser;



  @override
  Future<User?> resetpassword(String email,) async {
    try {
      final respnse = await _auth.sendPasswordResetEmail(
          email: email,);

      
     
    } catch (e) {
      debugPrint("${AuthErrors.userCreationFailed} $e");
      rethrow;
    }
    return null;
  }



  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw Exception(AuthErrors.loginError);
      }
      return response.user;
    } catch (e) {
      debugPrint("${AuthErrors.loginError} $e");
      rethrow;
    }
  }

  @override
  Future<void> signout() async {
    await _auth.signOut();
  }
  

}