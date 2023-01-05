// ignore: file_names

// ignore_for_file: avoid_print, file_names, duplicate_ignore, prefer_function_declarations_over_variables

// ignore: unused_import
import 'package:ecomerceprojects/componnet/ferstpageapp.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

// ignore: must_be_immutable
class Otp extends StatefulWidget {
  String phonenumber;
  String username;

  Otp({Key? key, required this.phonenumber, required this.username})
      : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with SingleTickerProviderStateMixin {
  GlobalKey<FormState> keyforma = GlobalKey<FormState>();
  late String verificationId;
  late AnimationController _controller;
  late String mypin = "";

  @override
  void initState() {
    verifyPhone();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  validphone() {
    var fom = keyforma.currentState;
    if (fom!.validate()) {
      fom.save();
      return true;
    } else {
      return false;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      // ignore: sized_box_for_whitespace
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
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                ),
              ),
              const SizedBox(
                child: Center(
                  child: Text(
                    "Verification Code ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                height: 150,
              ),
              const Center(
                child: Text(
                  "Pleaze Enter The Verification Code Send in ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Center(
                // ignore: unnecessary_string_interpolations
                child: Text(
                  // ignore: unnecessary_string_interpolations
                  "to ${widget.phonenumber}",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    key: keyforma,
                    child: PinPut(
                        textStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        selectedFieldDecoration: pinPutDecoration,
                        submittedFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.rotation,
                        fieldsCount: 6,
                        followingFieldDecoration: pinPutDecoration,
                        validator: (val) {
                          // ignore: unrelated_type_equality_checks
                          if (val != 6) {
                            return " Invalid Formta";
                          }
                        },
                        onSaved: (pin) {
                          setState(() {
                            mypin = pin!;
                            print(mypin);
                          });
                        },
                        onSubmit: (pin) async {
                          setState(() {
                            mypin = pin;
                            print(mypin);
                          });
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont Receive The OTP ? ",
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                      GestureDetector(
                        onTap: () {
                          verifyPhone();
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 60,
                  child: MaterialButton(
                    minWidth: 250,
                    color: Colors.white,
                    elevation: 10,
                    textColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      print(mypin);
                      try {
                        authentification().showloding(
                            "assets/animation/watting.json", context);
                        print(mypin);
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: mypin))
                            .then((value) {
                          // ignore: unnecessary_null_comparison
                          if (value != null) {
                            authentification().addusers(
                                widget.phonenumber,
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.username);
                            Navigator.pushNamedAndRemoveUntil(context,
                                "PagePayment", ModalRoute.withName("/"));
                          }
                        });
                      } catch (e) {
                        Navigator.pop(context);
                        authentification()
                            .flushbar("Invalid Otp", "Error", context);
                      }
                    },
                    child: const Text("Valider"),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Future<void> verifyPhone() async {
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verified = (AuthCredential credential) {
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        // ignore: unnecessary_null_comparison
        if (value != null) {
          print('user is loged');
        }
      });
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      // ignore: avoid_print
      print('${authException.message}');
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      setState(() {
        verificationId = verId;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phonenumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
