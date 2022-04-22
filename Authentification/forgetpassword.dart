import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'methode.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  late String emailuser;
  bool isEmail(String input) => EmailValidator.validate(input);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
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
                  ]),
            ),
            child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Reset Your Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Now",
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
                        margin: const EdgeInsets.only(top: 10),
                        height: 70,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
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
                          decoration: const InputDecoration(
                            focusColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            hintText: "exemple@gmail.com",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: emailuser);

                            Navigator.pop(context);
                          } catch (e) {
                            authentification().flushbar(
                                // ignore: unnecessary_string_interpolations
                                "Invalid Input ",
                                "Eroor",
                                context);
                          }
                        },
                        child: const Text("Reset"),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
