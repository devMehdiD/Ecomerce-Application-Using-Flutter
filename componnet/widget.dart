// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var like = FirebaseFirestore.instance.collection("like");
var carte = FirebaseFirestore.instance.collection("carteproduit");
Color colorborder3 = Colors.white;
Color colorborder4 = Colors.white;
Color colorborder1 = Colors.black;
Color colorborder2 = Colors.white;
int qantite = 1;
double rate = 1;
String? size = "X";
String colorofproduit = "Black";

class class_widget {
  likeitem(qty, size, color, name, price, image, promo, pricecoche, userid,
      rate, context) async {
    await like
        .add({
          'qty': qty,
          'size': size,
          'color': color,
          'name': name,
          'price': price,
          'image': image,
          'promo': promo,
          'pricecoche': pricecoche,
          'userid': userid,
          'rate': rate
          // ignore: avoid_print
        })
        .then((value) =>
            authentification().flushbar("Item Liked", "Success", context))
        // ignore: avoid_print
        .onError((error, stackTrace) => print("$error"));
  }

  Widget buildrate() => Expanded(
        child: RatingBar.builder(
          updateOnDrag: true,
          initialRating: rate,
          itemSize: 30,
          minRating: 1,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            rate = rating;
          },
        ),
      );

  addintocarte(
      color, image, name, price, pricecoche, qty, size, userid, context) async {
    await carte.add({
      "color": color,
      "image": image,
      "name": name,
      "price": price,
      "pricecoche": pricecoche,
      "qty": qty,
      "size": size,
      "userid": userid
    }).then((value) => authentification()
        .flushbar("Item Aded In Your Panie", "Success", context));
  }

  showdailoglike(AsyncSnapshot snapshot, index, context) {
    return StatefulBuilder(builder: (buildcontext, setState) {
      return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        await likeitem(
                            qantite,
                            size,
                            colorofproduit,
                            snapshot.data!.docs[index]['name'],
                            snapshot.data!.docs[index]['price'],
                            snapshot.data!.docs[index]['image'],
                            snapshot.data!.docs[index]['promo'],
                            snapshot.data!.docs[index]['pricecoche'],
                            FirebaseAuth.instance.currentUser!.uid,
                            rate,
                            context);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Like")),
                ),
              ],
            )
          ],
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                buildrate(),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Qantite"),
                    ),
                    MaterialButton(
                        height: 5,
                        minWidth: 10,
                        color: Colors.grey[100],
                        elevation: 0,
                        onPressed: () {
                          if (qantite == 1) {
                            // ignore: avoid_returning_null_for_void
                            return null;
                          } else {
                            setState(() {
                              qantite--;
                            });
                          }
                        },
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.blue[800]),
                        )),
                    // ignore: avoid_unnecessary_containers
                    Container(child: Text("$qantite")),
                    MaterialButton(
                        height: 5,
                        minWidth: 10,
                        color: Colors.grey[100],
                        elevation: 0,
                        onPressed: () {
                          setState(() {
                            qantite++;
                          });
                        },
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.blue[800]),
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Size"),
                    ),
                    DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue[800],
                      ),
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
                  ],
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              colorofproduit = "Black";
                              colorborder1 = Colors.black;
                              colorborder2 = Colors.white;
                              colorborder3 = Colors.white;
                              colorborder4 = Colors.white;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorborder1)),
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
                                colorborder1 = Colors.white;
                                colorborder2 = Colors.black;
                                colorborder3 = Colors.white;
                                colorborder4 = Colors.white;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorborder2)),
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
                              colorborder2 = Colors.white;
                              colorborder1 = Colors.white;

                              colorborder3 = Colors.black;
                              colorborder4 = Colors.white;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorborder3)),
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
                                colorborder1 = Colors.white;
                                colorborder3 = Colors.white;
                                colorborder2 = Colors.white;
                                colorborder4 = Colors.black;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorborder4)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  color: Colors.grey,
                                ),
                              ),
                            ))
                      ]),
                ),
              ],
            ),
          ));
    });
  }

  showdailog(AsyncSnapshot snapshot, index, context) {
    return StatefulBuilder(builder: (buildcontext, setState) {
      return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        class_widget().addintocarte(
                            colorofproduit,
                            snapshot.data.docs[index]['image'],
                            snapshot.data.docs[index]['name'],
                            snapshot.data.docs[index]['price'],
                            snapshot.data.docs[index]['pricecoche'],
                            qantite,
                            size,
                            FirebaseAuth.instance.currentUser!.uid,
                            context);

                        Navigator.of(context).pop();
                      },
                      child: const Text("Add")),
                ),
              ],
            )
          ],
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                buildrate(),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Qantite"),
                    ),
                    MaterialButton(
                        height: 5,
                        minWidth: 10,
                        color: Colors.grey[100],
                        elevation: 0,
                        onPressed: () {
                          if (qantite == 1) {
                            // ignore: avoid_returning_null_for_void
                            return null;
                          } else {
                            setState(() {
                              qantite--;
                            });
                          }
                        },
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.blue[800]),
                        )),
                    // ignore: avoid_unnecessary_containers
                    Container(child: Text("$qantite")),
                    MaterialButton(
                        height: 5,
                        minWidth: 10,
                        color: Colors.grey[100],
                        elevation: 0,
                        onPressed: () {
                          setState(() {
                            qantite++;
                          });
                        },
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.blue[800]),
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text("Size"),
                    ),
                    DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue[800],
                      ),
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
                  ],
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              colorofproduit = "Black";
                              colorborder1 = Colors.black;
                              colorborder2 = Colors.transparent;
                              colorborder3 = Colors.transparent;
                              colorborder4 = Colors.transparent;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorborder1)),
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
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorborder2)),
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
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: colorborder3)),
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
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorborder4)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  color: Colors.grey,
                                ),
                              ),
                            ))
                      ]),
                ),
              ],
            ),
          ));
    });
  }

  delet(i, context) async {
    // ignore: unused_local_variable, prefer_typing_uninitialized_variables
    var snapshot;
    await FirebaseFirestore.instance
        .collection("carteproduit")
        .doc(i)
        .delete()
        .then((value) =>
            authentification().flushbar("Item Deleted", "Delete", context))
        .catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }
}
