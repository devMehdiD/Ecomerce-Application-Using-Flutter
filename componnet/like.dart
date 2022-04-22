// ignore_for_file: unnecessary_string_escapes, avoid_unnecessary_containers, avoid_print

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

// ignore: camel_case_types
class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  _phoneState createState() => _phoneState();
}

// ignore: camel_case_types
class _phoneState extends State<Like> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // ignore: unused_field
  bool _connectionStatus = false;
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() => _connectionStatus = true);
        break;
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;

      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }

  delet(String path) async {
    await FirebaseFirestore.instance
        .collection("like")
        .doc(path)
        .delete()
        .then((value) =>
            authentification().flushbar("Item Deleted", "Succed", context))
        .catchError((e) {
      print(e);
    });
  }

  var carteproduit = FirebaseFirestore.instance.collection("carteproduit");
  dynamic value;
  var like = FirebaseFirestore.instance
      .collection("like")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // ignore: sized_box_for_whitespace
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildlike(),
        )
      ],
    ));
  }

  Object? itemm;

  Widget buildlike() => StreamBuilder<QuerySnapshot>(
      stream: like.snapshots(includeMetadataChanges: true),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // ignore: unnecessary_null_comparison

        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.antiAlias,
                        child:
                            Image.network(snapshot.data!.docs[index]['image']),
                      ),
                      title: Text(
                        "${snapshot.data!.docs[index]['name']}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                              child: Text(
                            "${snapshot.data!.docs[index]['price'] * snapshot.data!.docs[index]['qty']} \$",
                            style: const TextStyle(color: Colors.red),
                          )),
                          Expanded(
                              child: Text(
                            "${snapshot.data!.docs[index]['pricecoche']} \$",
                            style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough),
                          )),
                          Expanded(
                              child: Text(
                            "${snapshot.data!.docs[index]['rate']}⭐",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )),
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await carteproduit
                                .add({
                                  'qty': snapshot.data!.docs[index]['qty'],
                                  'size': snapshot.data!.docs[index]['size'],
                                  'color': snapshot.data!.docs[index]['color'],
                                  'name': snapshot.data!.docs[index]['name'],
                                  'price': snapshot.data!.docs[index]['price'],
                                  'image': snapshot.data!.docs[index]['image'],
                                  'pricecoche': snapshot.data!.docs[index]
                                      ['pricecoche'],
                                  'userid':
                                      FirebaseAuth.instance.currentUser!.uid,
                                })
                                .then((value) => authentification().flushbar(
                                    "Item Aded In Your Panie",
                                    "Success",
                                    context))
                                .catchError((e) {
                                  print(e);
                                });
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          )),
                    )),
              );
            },
          );
        }
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("No Item Liked"),
            SizedBox(
              width: 10,
            ),
            Icon(
              AntDesign.hearto,
              size: 30,
            ),
          ],
        ));
      });
}
