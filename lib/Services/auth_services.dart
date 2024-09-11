import 'package:firebase_auth/firebase_auth.dart';

class AuthServicesHelper {
  static Future<String> createAccountWithEmail(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account created!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //login

  static Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //logout
  static Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "logout successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //check if user already logged in

  static Future<bool> isUserLoggedIn() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null ? true : false;
  }

  
}
