import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'methode.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late String email;
  late String password;
  late String username;
  bool isEmail(String input) => EmailValidator.validate(input);
  bool haidentext1 = true;
  bool haidentext2 = true;
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
                      "Create your",
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
                        child: Column(
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 70,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                validator: (val) {
                                  if (val!.length < 2 || val.length > 6) {
                                    return "Invalid Format";
                                  }
                                },
                                onSaved: (val) {
                                  setState(() {
                                    username = val!;
                                  });
                                },
                                cursorColor: Colors.red,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintText: "User Name",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            // ignore: sized_box_for_whitespace
                            Container(
                              height: 70,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                validator: (val) {
                                  if (isEmail("$val") == false) {
                                    return "Email incorecte";
                                  }
                                },
                                onSaved: (val) {
                                  email = val!;
                                },
                                cursorColor: Colors.red,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: "example@gmail.com",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
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
                            obscureText: haidentext1,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              hintText: "Password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      haidentext1 = !haidentext1;
                                    });
                                  },
                                  icon: haidentext1
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Have Account Sign in ?",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: MaterialButton(
                      color: Colors.white,
                      elevation: 10,
                      height: 40,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      textColor: Colors.black87,
                      onPressed: () async {
                        if (valid() == true) {
                          await authentification().signinwithemail(
                              username, email, password, context);
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
