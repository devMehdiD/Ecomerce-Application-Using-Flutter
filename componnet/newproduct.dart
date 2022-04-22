import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ecomerceprojects/componnet/produit.dart';
import 'package:ecomerceprojects/componnet/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct>
    with SingleTickerProviderStateMixin {
  var newarrivals = FirebaseFirestore.instance.collection("newarrivals");

  /// var of conetion
  // ignore: unused_field
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  bool _connectionStatus = false;
  //////////////////////////////////////////
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // ignore: avoid_print
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("New Arrivals"),
      ),
      body: Stack(
        children: [gradeview()],
      ),
    );
  }

  Widget gradeview() => StreamBuilder(
        stream: newarrivals.snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return buildcontent(
                        Produit(
                            rate: rate,
                            pricecoche:
                                "${snapshot.data!.docs[index]['pricecoche']}",
                            image2: "${snapshot.data!.docs[index]['image2']}",
                            image: "${snapshot.data!.docs[index]['image']}",
                            name: "${snapshot.data!.docs[index]['name']}",
                            price: snapshot.data!.docs[index]['price'],
                            desc: "${snapshot.data!.docs[index]['desc']}",
                            image3: "${snapshot.data!.docs[index]['image3']}",
                            image4: "${snapshot.data!.docs[index]['image4']}"),
                        "${snapshot.data!.docs[index]['image']}",
                        Colors.white,
                        Colors.white,
                        index,
                        snapshot);
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.count(2, 3)),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
  Widget buildcontent(StatefulWidget f, String path, Color color, Color colorr,
      index, AsyncSnapshot<QuerySnapshot> snapshot) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryanimation) {
                    var twen = Tween<Offset>(
                        begin: const Offset(0, 1), end: Offset.zero);
                    var position = animation.drive(twen);
                    return SlideTransition(
                      position: position,
                      child: f,
                    );
                  }));
        },
        child: GridTile(
          child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: _connectionStatus
                  ? Image.network(
                      path,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          footer: Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        showModal(
                            configuration:
                                const FadeScaleTransitionConfiguration(
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 600),
                                    transitionDuration: Duration(seconds: 1)),
                            context: context,
                            builder: (buildcontext) {
                              return class_widget()
                                  .showdailog(snapshot, index, context);
                            });
                      }),
                  IconButton(
                    icon: const Icon(
                      AntDesign.hearto,
                      color: Colors.redAccent,
                      size: 25,
                    ),
                    onPressed: () {
                      showModal(
                          configuration: const FadeScaleTransitionConfiguration(
                              reverseTransitionDuration:
                                  Duration(microseconds: 600),
                              transitionDuration: Duration(seconds: 1)),
                          context: context,
                          builder: (
                            buildcontex,
                          ) {
                            return class_widget()
                                .showdailoglike(snapshot, index, context);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
