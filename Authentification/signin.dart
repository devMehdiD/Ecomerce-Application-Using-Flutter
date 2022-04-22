// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/Authentification/forgetpassword.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:ecomerceprojects/Authentification/phone.dart';
import 'package:ecomerceprojects/Authentification/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class ChoseAuth extends StatefulWidget {
  const ChoseAuth({Key? key}) : super(key: key);

  @override
  _ChoseAuthState createState() => _ChoseAuthState();
}

class _ChoseAuthState extends State<ChoseAuth> {
  bool isEmail(String input) => EmailValidator.validate(input);
  bool scren = false;
  bool haidentext1 = true;
  bool haidentext2 = true;

  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late String emailuser;
  late String phoneno;
  late String smsCode;
  late String verificationId;

  GlobalKey<FormState> form = GlobalKey<FormState>();
  GlobalKey<FormState> phoneform = GlobalKey<FormState>();
  late String email;
  late String password;
  late String username;
  var userinfo = FirebaseFirestore.instance.collection("users");
  validatorofphone() {
    var phone = phoneform.currentState;
    if (phone!.validate()) {
      phone.save();
      return true;
    } else {
      return false;
    }
  }

  valid() {
    var form = formstate.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.white)],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xD954e3d6),
                    Color(0xCC0048ba),
                  ])),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Login with your",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 70,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onSaved: (val) {
                        email = val!;
                      },
                      validator: (val) {
                        if (isEmail("$val") == false) {
                          return "Email incorecte";
                        }
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        hintText: "example@gmail.com",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 70,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onSaved: (val) {
                        password = val!;
                      },
                      validator: (val) {
                        if (val!.length < 6 || val.length > 12) {
                          return "Weak Password";
                        }
                      },
                      obscureText: haidentext2,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                haidentext2 = !haidentext2;
                              });
                            },
                            icon: haidentext2
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  )),
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                  ),
                  child: Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 600),
                              pageBuilder: (buildcontext, animation, second) {
                                var begin = const Offset(0, 1);
                                var end = Offset.zero;
                                var twen =
                                    Tween<Offset>(begin: begin, end: end);
                                var animationposition = animation.drive(twen);
                                return SlideTransition(
                                  position: animationposition,
                                  child: const ForgetPassword(),
                                );
                              }));
                    },
                    child: const Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.lightBlueAccent,
                                blurRadius: 3,
                                offset: Offset(1, 2))
                          ],
                          decoration: TextDecoration.underline),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: MaterialButton(
                    elevation: 10,
                    color: Colors.white,
                    height: 40,
                    minWidth: 250,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    textColor: Colors.black87,
                    textTheme: ButtonTextTheme.normal,
                    onPressed: () async {
                      if (valid() == true) {
                        // ignore: await_only_futures
                        await authentification()
                            .loginWithemail(email, password, context);
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Or connect with ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          UserCredential user = await authentification()
                              .signInWithGoogle(context);
                          if (user.credential != null) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                "PagePayment", ModalRoute.withName("/"));
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(
                          AntDesign.google,
                          color: Colors.white,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder:
                                      (buildcontext, animation, second) {
                                    var begin = const Offset(0, 1);
                                    var end = Offset.zero;
                                    var twen =
                                        Tween<Offset>(begin: begin, end: end);
                                    var animationposition =
                                        animation.drive(twen);
                                    return SlideTransition(
                                      position: animationposition,
                                      child: const Phone(),
                                    );
                                  }));
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                )),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have account ? ",
                        style: TextStyle(color: Colors.white.withOpacity(0.6)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder:
                                      (buildcontext, animation, second) {
                                    var begin = const Offset(0.0, 1);
                                    var end = Offset.zero;
                                    var twen = Tween(begin: begin, end: end);
                                    var position = animation.drive(twen);
                                    return SlideTransition(
                                      position: position,
                                      child: const Signup(),
                                    );
                                  }));
                        },
                        child: const Text(
                          "Sign up ",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  alrt() {
    showModal(
        configuration: const FadeScaleTransitionConfiguration(
            transitionDuration: Duration(seconds: 2)),
        context: context,
        builder: (buildcontext) {
          return StatefulBuilder(builder: (buildcontext, set) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Center(child: Text("Reste Your Password")),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Back")),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: emailuser);
                              print(emailuser);
                              Navigator.pop(context);
                            } catch (e) {
                              authentification().flushbar(
                                  // ignore: unnecessary_string_interpolations
                                  "${e.toString()}",
                                  "Eroor",
                                  context);
                            }
                          },
                          child: const Text("Send")),
                    ),
                  ],
                )
              ],
              // ignore: sized_box_for_whitespace
              content: Container(
                height: 100,
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: 70,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "example@gamil.com",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35.5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                          ),
                          validator: (value) {
                            if (isEmail("$value") == false) {
                              return "Email Incorecte";
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              emailuser = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
