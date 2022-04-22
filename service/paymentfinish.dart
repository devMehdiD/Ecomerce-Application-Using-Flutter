// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecomerceprojects/componnet/widget.dart';
import 'package:ecomerceprojects/service/paymentservice.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'dart:core';

// ignore: must_be_immutable
class Finishpayment extends StatefulWidget {
  dynamic price;
  dynamic name;
  dynamic color;
  dynamic size;
  dynamic image;
  int qty;

  Finishpayment({
    Key? key,
    required this.name,
    required this.image,
    required this.color,
    required this.price,
    required this.size,
    required this.qty,
  }) : super(key: key);

  @override
  _FinishpaymentState createState() => _FinishpaymentState();
}

class _FinishpaymentState extends State<Finishpayment> {
  TextEditingController emailcontrolle = TextEditingController();
  TextEditingController adresscontrolle = TextEditingController();
  TextEditingController phonecontrolle = TextEditingController();
  var username = FirebaseAuth.instance.currentUser!.displayName;
  var demende = FirebaseFirestore.instance.collection("demende");
  var userid = FirebaseAuth.instance.currentUser!.uid;
  var delet = FirebaseFirestore.instance.collection("carteproduit");

  String? email;
  String? adresse;
  dynamic phone;
  String? contry;
  String? city;
  GlobalKey<FormState> mykey = GlobalKey<FormState>();
  Color? orange = Colors.orange[800] as Color;

  valid() {
    var formstate = mykey.currentState;
    if (formstate!.validate()) {
      formstate.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isEmail(String input) => EmailValidator.validate(input);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "PagePayment", ModalRoute.withName("/"));
              },
              icon: const Icon(AntDesign.home))
        ],
        centerTitle: true,
        title: const Text(
          "Pay With Carde ",
        ),
      ),
      body: ListView(
        children: [
          Form(
              key: mykey,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 5, top: 5),
                      height: 200,
                      child: Image.asset(
                        "assets/payimages/imagepay.png",
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(
                              Icons.search,
                            )),
                        showAsSuffixIcons: true,
                        showSearchBox: true,
                        onSaved: (val) {
                          contry = val;
                        },
                        validator: (val) {
                          if (val == null) {
                            return "Select Contry";
                          }
                          return null;
                        },
                        items: const [
                          "🇲🇦 Maroc",
                          "🇮🇹 Italia",
                          "🇹🇷 Tunisia",
                          '🇺🇸 Use',
                          "🇫🇷 France",
                          "🇪🇸 Espanoil",
                          "🇪🇬 Egypt",
                          '🇨🇦 Canada'
                        ],
                        mode: Mode.MENU,
                        // ignore: deprecated_member_use
                        hint: "Select Contry",
                        onChanged: (value) {
                          setState(() {
                            contry = value;
                          });
                        },
                        showSelectedItems: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      onSaved: (val) {
                        city = val;
                      },
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Value  incorecte";
                        }
                        return null;
                      },
                      maxLength: 20,
                      decoration: const InputDecoration(
                        hintText: "City",
                        prefixIcon: Icon(
                          Icons.location_city,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true,
                      cursorColor: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    height: 80,
                    child: TextFormField(
                      onSaved: (val) {
                        adresse = val;
                      },
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Value  incorecte";
                        }
                        return null;
                      },
                      maxLength: 20,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: true,
                      cursorColor: Colors.red,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ), //
                          ),
                          hintText: "Adress",
                          prefixIcon: Icon(
                            Icons.home,
                          )),
                      controller: adresscontrolle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    height: 80,
                    child: TextFormField(
                        maxLength: 30,
                        onSaved: (val) {
                          email = val;
                        },
                        validator: (val) {
                          if (isEmail("$val") == false) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        cursorColor: Colors.red,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: true,
                        controller: emailcontrolle,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)), //
                            ),
                            hintText: "example@gmail.com",
                            prefixIcon: Icon(
                              Icons.email,
                            ))),
                  ),
                  const SizedBox(
                    height: 100,
                  ),

                  // ignore: avoid_unnecessary_containers
                ],
              ))
        ],
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent[100] as Color
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: MaterialButton(
                child: Text("Pay Now ${widget.price * widget.qty} \$ ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                minWidth: MediaQuery.of(context).size.width,
                height: 60,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                onPressed: () async {
                  if (valid() == true) {
                    Paymen.payment(
                        "${widget.price}",
                        "USD",
                        context,
                        adresse,
                        city,
                        colorofproduit,
                        contry,
                        email,
                        widget.image,
                        widget.name,
                        "${widget.price * widget.qty}",
                        widget.qty,
                        size,
                        DateTime.now(),
                        userid);
                  }
                })),
      ),
    );
  }
}
