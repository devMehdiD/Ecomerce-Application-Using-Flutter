import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

// ignore: must_be_immutable
class PayemntWithNoCreditCard extends StatefulWidget {
  dynamic price;
  dynamic name;
  dynamic color;
  dynamic size;
  dynamic image;
  int qty;

  PayemntWithNoCreditCard({
    Key? key,
    required this.name,
    required this.image,
    required this.color,
    required this.price,
    required this.size,
    required this.qty,
  }) : super(key: key);

  @override
  _PayemntWithNoCreditCardState createState() =>
      _PayemntWithNoCreditCardState();
}

class _PayemntWithNoCreditCardState extends State<PayemntWithNoCreditCard> {
  TextEditingController emailcontrolle = TextEditingController();
  TextEditingController adresscontrolle = TextEditingController();
  TextEditingController phonecontrolle = TextEditingController();
  var username = FirebaseAuth.instance.currentUser!.displayName;
  var demende = FirebaseFirestore.instance.collection("demendnocreditcard");
  var userid = FirebaseAuth.instance.currentUser!.uid;
  String? email;
  String? adresse;
  dynamic phone;
  String? contry;
  String? city;
  GlobalKey<FormState> mykey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  String pattern = r'^(?:[+]9)?[0-9]{10}$';

  bool isphone(String input) => RegExp(pattern).hasMatch(input);

  @override
  void initState() {
    super.initState();
  }

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
          "Pay With No Carde ",
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
                        "assets/payimages/paynocreditcard.png",
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
                    height: 10,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // ignore: avoid_unnecessary_containers
                ],
              )),
          Container(
            height: 60,
          )
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
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              onPressed: () async {
                if (valid() == true) {
                  demende.add({
                    'email': email,
                    'adress': adresse,
                    'size': widget.size,
                    'color': widget.color,
                    'price': widget.price,
                    'image': widget.image,
                    'name': widget.name,
                    'qty': widget.qty,
                    'time': DateTime.now(),
                    'userId': userid,
                    'contry': contry,
                    'city': city
                  }).then((value) => authentification()
                      .flushbar("Operation Succide", "Succide", context));
                } else {
                  authentification()
                      .flushbar("Operation feild", "error", context);
                }
              },
              child: Text("Demende Now ${widget.price * widget.qty} \$ ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            )),
      ),
    );
  }
}
