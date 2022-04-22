// ignore_for_file: avoid_print, prefer_function_declarations_over_variables
// ignore: unused_import
import 'dart:async';
import 'dart:ui';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomerceprojects/componnet/ferstpageapp.dart';
// ignore: unused_import
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:ecomerceprojects/Authentification/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  var auth = FirebaseAuth.instance;
  bool codeSent = false;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  GlobalKey<FormState> formcode = GlobalKey<FormState>();
  late CountryCode contrycode =
      CountryCode(dialCode: "+212", code: "MA", name: "", flagUri: "MA");
  TextEditingController textEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late String username;

  late String phoneno;
  late String getsmsCode = "";
  late String verificationId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  smscodevalidator() {
    var smscodeform = formcode.currentState;
    if (smscodeform!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  validator() {
    var myform = form.currentState;
    if (myform!.validate()) {
      myform.save();
      return true;
    } else {
      return false;
    }
  }

  showdailg() => showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: const Text("SMS Code"),
          content: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: Form(
                key: formcode,
                child: TextFormField(
                  validator: (v) {
                    if (v!.length != 6) {
                      return "?";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      getsmsCode = val!;
                    });
                  },
                  onChanged: (smscode) {
                    setState(() {
                      getsmsCode = smscode;
                      print(smscode);
                    });
                  },
                ),
              )),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back"),
                  ),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () async {
                        if (smscodevalidator() == true) {
                          // ignore: unnecessary_string_interpolations
                          print("$getsmsCode");

                          if (auth.currentUser != null) {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) {
                              return const Festpage();
                            }), (route) => false);
                          }
                        }
                      },
                      child: const Text("Done")),
                ),
              ],
            )
          ],
        );
      });

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Form(
                key: form,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.length < 2 || val.length > 6) {
                            return "Invalid User Name";
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
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
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      height: 70,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Phone NuMBER Invalid";
                          }
                        },
                        onSaved: (value) {
                          phoneno = "${contrycode.dialCode}$value";
                          print(phoneno);
                        },
                        decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            showFlag: true,
                            dialogBackgroundColor: Colors.grey,
                            textStyle: const TextStyle(color: Colors.white),
                            initialSelection: "+212",
                            barrierColor: Colors.white,
                            onChanged: (contrycod) {
                              setState(() {
                                contrycode = contrycod;
                              });
                            },
                          ),
                          hintText: "Phone Number",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.white,
                        height: 40,
                        elevation: 10,
                        minWidth: 250,
                        textTheme: ButtonTextTheme.accent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        textColor: Colors.black87,
                        onPressed: () async {
                          if (validator() == true) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (buildcontext) {
                              return Otp(
                                  phonenumber: phoneno, username: username);
                            }));
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
