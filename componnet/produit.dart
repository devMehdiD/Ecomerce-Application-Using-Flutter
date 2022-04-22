// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:ecomerceprojects/componnet/switch.dart';
import 'package:ecomerceprojects/service/chosepayment.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// ignore: unused_import
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class Produit extends StatefulWidget {
  dynamic image;
  dynamic name;
  int price;
  dynamic desc;
  dynamic image2;
  dynamic pricecoche;
  dynamic rate;
  dynamic image3;
  dynamic image4;

  Produit({
    Key? key,
    required this.rate,
    required this.pricecoche,
    required this.image2,
    required this.image,
    required this.name,
    required this.price,
    required this.desc,
    required this.image3,
    required this.image4,
  }) : super(key: key);

  @override
  _ProduitState createState() => _ProduitState();
}

class _ProduitState extends State<Produit> {
  Color colorborder3 = Colors.white;
  Color colorborder4 = Colors.white;
  Color colorborder1 = Colors.black;
  Color colorborder2 = Colors.white;
  String colorofproduit = "Black";
  String size = 'X';

  int qty = 1;
  var username = FirebaseAuth.instance.currentUser!.displayName;
  var email = FirebaseAuth.instance.currentUser!.email;
  var phonenumber = FirebaseAuth.instance.currentUser!.phoneNumber;

  var carteproduit = FirebaseFirestore.instance.collection("carteproduit");
  var demende = FirebaseFirestore.instance.collection("demende");

  addelement() {
    return carteproduit
        .add({
          'price': widget.price,
          'name': widget.name,
          'image': widget.image,
          'userid': FirebaseAuth.instance.currentUser!.uid,
          'size': size,
          'color': colorofproduit,
          'qty': qty,
          'pricecoche': widget.pricecoche
          // ignore: duplicate_ignore
          // ignore: duplicate_ignore, duplicate_ignore
        })
        .then((value) => authentification()
            .flushbar("Item aded In your Panie", "Sccucide", context))
        .catchError((e) {
          print(e);
        });
  }

  int crentindex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color bg = Colors.white;
  bool them = false;

  Color coloranimation = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Product",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ))),
      body: ListView(scrollDirection: Axis.vertical, children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builcontext) {
                return Switchimage(
                  image: widget.image,
                  image2: widget.image2,
                  image3: widget.image3,
                  image4: widget.image4,
                );
              }));
            },
            child: Stack(children: [
              CarouselSlider(
                items: [
                  Image.network(
                    "${widget.image}",
                  ),
                  Image.network(
                    "${widget.image2}",
                  ),
                ],
                options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, r) {
                      setState(() {
                        crentindex = index;
                      });
                    }),
              ),
              Positioned.fill(
                top: 160,
                child: Center(
                    child: AnimatedSmoothIndicator(
                  activeIndex: crentindex,
                  count: 2,
                  effect: const WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: Colors.lightBlueAccent,
                  ),
                )),
              )
            ]),
          ),
        ),

        // ignore: avoid_unnecessary_containers
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "${widget.name}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Text("⭐️ ${widget.rate}")),
          ],
        ),

        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "${widget.pricecoche}",
                  style: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "${widget.price * qty} \$",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),

        Row(
          children: [
            Expanded(
                child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Size",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  height: 50,
                  child: DropdownButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    value: size,
                    onChanged: (String? newValue) {
                      setState(() {
                        size = newValue!;
                        // ignore: avoid_print
                        print(size);
                      });
                    },
                    items: ['X', 'L', 'XL', 'XS', 'S', 'M']
                        .map<DropdownMenuItem<String>>(
                            (String item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ))
                        .toList(),
                  ),
                ),
              ],
            ))
          ],
        ),
        Row(children: [
          Container(
            margin: const EdgeInsets.only(left: 7, right: 7),
            child: const Text(
              "Color :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                colorborder1 = Colors.black;
                colorborder2 = Colors.transparent;
                colorborder3 = Colors.transparent;
                colorborder4 = Colors.transparent;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: colorborder1)),
                height: 40,
                width: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  colorofproduit = "Red";
                  colorborder1 = Colors.transparent;
                  colorborder2 = Colors.black;
                  colorborder3 = Colors.transparent;
                  colorborder4 = Colors.transparent;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: colorborder2)),
                  height: 40,
                  width: 40,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.red,
                  ),
                ),
              )),
          InkWell(
            onTap: () {
              setState(() {
                colorofproduit = "Blue";
                colorborder2 = Colors.transparent;
                colorborder1 = Colors.transparent;

                colorborder3 = Colors.black;
                colorborder4 = Colors.transparent;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: colorborder3)),
                height: 40,
                width: 40,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  colorofproduit = "grey";
                  colorborder1 = Colors.transparent;
                  colorborder3 = Colors.transparent;
                  colorborder2 = Colors.transparent;
                  colorborder4 = Colors.black;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: colorborder4)),
                  height: 40,
                  width: 40,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.grey,
                  ),
                ),
              ))
        ]),

        Row(
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: const Text("Qantité",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            MaterialButton(
                height: 5,
                minWidth: 10,
                color: Colors.grey[100],
                elevation: 0,
                onPressed: () {
                  if (qty == 1) {
                    // ignore: avoid_returning_null_for_void
                    return null;
                  } else {
                    setState(() {
                      qty--;
                    });
                  }
                },
                child: Text(
                  "-",
                  style: TextStyle(color: Colors.blue[800]),
                )),
            // ignore: avoid_unnecessary_containers
            Container(child: Text("$qty")),
            MaterialButton(
                height: 5,
                minWidth: 10,
                color: Colors.grey[100],
                elevation: 0,
                onPressed: () {
                  setState(() {
                    qty++;
                  });
                },
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.blue[800]),
                ))
          ],
        ),

        ///start

        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          child: const Text(
            "Descrption :",
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text("${widget.desc}"),
        ),
        Container(
          height: 100,
        )
      ]),
      // ignore: sized_box_for_whitespace
      bottomSheet: Row(
        children: [
          Expanded(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blueAccent,
                    Colors.lightBlueAccent[100] as Color
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: MaterialButton(
                    minWidth: 205,
                    height: 50,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 600),
                              pageBuilder:
                                  (context, animation, secondanimation) {
                                var twen = Tween<Offset>(
                                    begin: const Offset(0, 1),
                                    end: Offset.zero);
                                var position = animation.drive(twen);

                                return SlideTransition(
                                  position: position,
                                  child: ChosePayment(
                                    price: widget.price,
                                    name: widget.name,
                                    color: colorofproduit,
                                    size: size,
                                    image: widget.image,
                                    qty: qty,
                                  ),
                                );
                              }));
                    },
                    child: const Text(
                      "BUY NOW",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))),
          Expanded(
              child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 50,
            textColor: Colors.lightBlueAccent,
            onPressed: () async {
              await addelement();
            },
            child: const Text(
              "ADD TO CART",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
