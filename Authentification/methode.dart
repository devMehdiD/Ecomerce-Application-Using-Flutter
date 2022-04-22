// ignore_for_file: unrelated_type_equality_checks

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class authentification {
  var userinfo = FirebaseFirestore.instance.collection("users");
  signinwithemail(username, email, password, context) async {
    try {
      showloding("assets/animation/watting.json", context);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      await userinfo
          .doc(user.uid)
          .set({'username': username, 'email': email, 'userid': user.uid});
      Navigator.pop(context);
      flushbar(
          "Account Created Pleaze Verrify Your Account ", "Succeeded", context);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.pop(context);
        flushbar("weak-password", "Erro", context);
      }
      if (e.code == 'email-already-in-use') {
        Navigator.pop(context);
        // ignore: avoid_print
        flushbar("email-already-in-use", "Error", context);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  loginWithemail(email, password, context) async {
    try {
      showloding("assets/animation/watting.json", context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.emailVerified == true) {
        Navigator.pushNamedAndRemoveUntil(
            context, "PagePayment", ModalRoute.withName("/"));
      } else {
        // ignore: avoid_print
        Navigator.pop(context);
        flushbar("Pleaze Verrify Your Account", "Error", context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        flushbar("user-not-found", "Error", context);
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        // ignore: avoid_print
        flushbar("Wrong-Password", "Error", context);

        //showloding();

      }
    }
  }

  showloding(path, context) {
    return showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: 100,
              child: Center(child: Lottie.asset(path, height: 100)),
            ),
          );
        });
  }

  Future<UserCredential> signInWithGoogle(context) async {
    showloding("assets/animation/watting.json", context);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // ignore: unused_local_variable
    User? user = FirebaseAuth.instance.currentUser;

    // Once signed in, return the UserCredential
    var cred = await FirebaseAuth.instance.signInWithCredential(credential);
    if (cred.user != null) {
      await addusers(cred.user!.email, cred.user!.uid, cred.user!.displayName);
    }
    return cred;
  }

  addusers(email, userid, username) {
    return userinfo
        .add({"email": email, "userid": userid, "username": username});
  }

  flushbar(message, title, context) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      duration: const Duration(seconds: 3),
      message: message,
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      titleColor: Colors.black,
      messageColor: Colors.black,
    ).show(context);
  }
}
