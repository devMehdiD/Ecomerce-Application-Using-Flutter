// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/componnet/produit.dart';
import 'package:ecomerceprojects/componnet/switch.dart';

import 'package:ecomerceprojects/produit/backservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: use_key_in_widget_constructors
class Serch extends StatefulWidget {
  @override
  _LangageState createState() => _LangageState();
}

class _LangageState extends State<Serch> {
  TextEditingController controller = TextEditingController();
  var prduit = FirebaseFirestore.instance.collection("produitpagetue");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TypeAheadField(
                animationDuration: const Duration(seconds: 1),
                textFieldConfiguration: TextFieldConfiguration(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      suffixIcon: const Icon(
                        AntDesign.search1,
                        color: Colors.lightBlueAccent,
                      ),
                      hintText: "Search Produit",
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                suggestionsCallback: (pattern) async {
                  return await BackendService().gesproduit(pattern);
                },
                itemBuilder: (context, DocumentSnapshot<Object?> suggestion) {
                  return ListTile(
                      title: Text("${suggestion['name']}"),
                      leading: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network("${suggestion['image']}")),
                      subtitle: Text("${suggestion['price']} \$"));
                },
                onSuggestionSelected: (DocumentSnapshot<Object?> suggestion) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Produit(
                            rate: "${suggestion['rate']}",
                            pricecoche: "${suggestion['pricecoche']}",
                            image2: "${suggestion['image2']}",
                            image: "${suggestion['image']}",
                            name: "${suggestion['name']}",
                            price: suggestion['price'],
                            desc: "${suggestion['desc']}",
                            image3: "${suggestion['image3']}",
                            image4: "${suggestion['image4']}",
                          )));
                }),
          ),
          const SizedBox(
            height: 10,
          ),

          // ignore: sized_box_for_whitespace
          Container(
              height: MediaQuery.of(context).size.height, child: allProduit()),
        ],
      ),
    );
  }

  Widget allProduit() => StreamBuilder(
      stream: prduit.snapshots(includeMetadataChanges: true),
      builder: (buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (buildcontext, int index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (buildcontext) {
                        return Produit(
                          name: snapshot.data!.docs[index]['name'],
                          pricecoche: snapshot.data!.docs[index]['pricecoche'],
                          price: snapshot.data!.docs[index]['price'],
                          image: snapshot.data!.docs[index]['image'],
                          image2: snapshot.data!.docs[index]['image2'],
                          desc: snapshot.data!.docs[index]['desc'],
                          rate: snapshot.data!.docs[index]['rate'],
                          image3: snapshot.data!.docs[index]['image3'],
                          image4: snapshot.data!.docs[index]['image4'],
                        );
                      }));
                    },
                    child: SizedBox(
                        width: MediaQuery.maybeOf(context)!.size.width / 2,
                        child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Container(
                                        height: 260,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.all(5),
                                        child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder:
                                                        (buildcontext) {
                                                  return Switchimage(
                                                    image: snapshot.data!
                                                        .docs[index]['image'],
                                                    image2: snapshot.data!
                                                        .docs[index]['image2'],
                                                    image3: snapshot.data!
                                                        .docs[index]['image3'],
                                                    image4: snapshot.data!
                                                        .docs[index]['image4'],
                                                  );
                                                }));
                                              },
                                              child: Carousel(
                                                  dotSize: 4.0,
                                                  dotSpacing: 15.0,
                                                  dotColor:
                                                      Colors.lightGreenAccent,
                                                  indicatorBgPadding: 5.0,
                                                  borderRadius: true,
                                                  dotBgColor: Colors
                                                      .lightBlueAccent
                                                      .withOpacity(0.2),
                                                  images: [
                                                    Image.network(
                                                        "${snapshot.data!.docs[index]['image']}"),
                                                    Image.network(
                                                        "${snapshot.data!.docs[index]['image2']}"),
                                                  ]),
                                            )))),
                                SizedBox(
                                    height: 50,
                                    child: Text(
                                        "⭐️ ${snapshot.data!.docs[index]['rate']}")),
                                SizedBox(
                                  height: 50,
                                  child: Text(
                                      "${snapshot.data!.docs[index]['name']}",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600])),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 50,
                                      child: Text(
                                          "${snapshot.data!.docs[index]['price']} \$",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlueAccent)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      height: 50,
                                      child: Text(
                                          "${snapshot.data!.docs[index]['pricecoche']} \$",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.black)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 50,
                                      child: Text(
                                          "- ${snapshot.data!.docs[index]['promo']} %",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange[800])),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 50,
                                  child: Text(
                                    "- ${snapshot.data!.docs[index]['desc']}",
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ))),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
