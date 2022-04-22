import 'dart:async';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ecomerceprojects/allcategories/allcategories.dart';
import 'package:ecomerceprojects/allcategories/chemise.dart';
import 'package:ecomerceprojects/allcategories/dresscat.dart';
import 'package:ecomerceprojects/allcategories/phonecat.dart';
import 'package:ecomerceprojects/allcategories/pontalon.dart';
import 'package:ecomerceprojects/allcategories/saccat.dart';
import 'package:ecomerceprojects/allcategories/watch.dart';
import 'package:ecomerceprojects/componnet/inkwell.dart';
import 'package:ecomerceprojects/componnet/produit.dart';
import 'package:ecomerceprojects/componnet/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'newproduct.dart';

class FerstPage extends StatefulWidget {
  const FerstPage({Key? key}) : super(key: key);

  @override
  _FerstPageState createState() => _FerstPageState();
}

class _FerstPageState extends State<FerstPage>
    with SingleTickerProviderStateMixin {
// COLOR VARIABLE
  bool _connectionStatus = false;

  /// var of contctivty
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
///// FIREBASE VERIBLE
  var grade = FirebaseFirestore.instance.collection("ferst");
  var email = FirebaseAuth.instance.currentUser!.email;
///////////// varible
  int qantite = 1;
  String? size = "X";
  int selecteindex = 0;
  ////////// list of widget Inkwell /////////////////////
  List<mYinkwell> inkwell = [
    mYinkwell(
        onTap: const PhoneCate(), pathimage: "assets/categories/phones.png"),
    mYinkwell(
        onTap: const SwatchCat(), pathimage: "assets/categories/swatch.png"),
    mYinkwell(
        onTap: const Dresscat(), pathimage: "assets/categories/robecat.png"),
    mYinkwell(onTap: const Saccat(), pathimage: "assets/categories/sacdos.png"),
    mYinkwell(
        onTap: const Chemisecat(), pathimage: "assets/categories/suit.png"),
    mYinkwell(
        onTap: const Pontaloncat(), pathimage: "assets/categories/chose.png"),
  ];
  ////////// list of widget Image Crousle Slider /////////////////////
  List<Widget> images = [
    Image.asset(
      "assets/images/pc.png",
      height: 150,
      width: double.infinity,
    ),
    Image.asset(
      "assets/images/tel.png",
      height: 150,
      width: double.infinity,
    ),
    Image.asset(
      "assets/images/watch.png",
      height: 150,
      width: double.infinity,
    ),
    Image.asset(
      "assets/images/chose.PNG",
      height: 150,
      width: double.infinity,
    ),
  ];
/////////////Like Item ////////////////////////

////// Controolle ScrollevIew/////////////
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    controller.addListener(() {
      setState(() {});
    });
    _connectivitySubscription.cancel();
    super.dispose();
  }

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

  int crentindiw = 0;
  List scren = [];
  double rate = 1;
  Color bg = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [const SizedBox(height: 20), ferstbody()],
      ),
    );
  }

  Widget ferstbody() => ListView(
        children: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child: CarouselSlider(
                  items: images,
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
                      onPageChanged: (value, reasaion) {
                        setState(() {
                          selecteindex = value;
                        });
                      }),
                ),
              ),
            ),
            Positioned.fill(
              top: 160,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                    effect: const WormEffect(
                        activeDotColor: Colors.lightBlueAccent,
                        dotHeight: 12,
                        dotWidth: 12),
                    activeIndex: selecteindex,
                    count: images.length),
              ),
            ),
          ]),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              children: [
                const Expanded(
                    flex: 4,
                    child: Text(
                      "Categories ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(seconds: 2),
                                  transitionsBuilder: (context, animation,
                                      secondanimation, child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOut);

                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, secondanimation) {
                                    return const Allcategories();
                                  }));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "See All ",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ))),
              ],
            ),
          ),
          SizedBox(height: 60, child: buildlistevie()),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Row(
              children: [
                const Expanded(
                    flex: 4,
                    child: Text(
                      "New Arrivals ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder: (buildcontext, animation,
                                      secondanimation) {
                                    var twen = Tween<Offset>(
                                        begin: const Offset(0, 1),
                                        end: Offset.zero);
                                    var position = animation.drive(twen);
                                    return SlideTransition(
                                        position: position,
                                        child: const AllProduct());
                                  }));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "See All ",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ))),
              ],
            ),
          ),
          SizedBox(height: 500, child: gradeview())
        ],
      );
  Widget gradeview() => StreamBuilder(
        stream: grade.snapshots(includeMetadataChanges: true),
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

  Widget buildlistevie() => CustomScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((buildcontext, int index) {
            double itemsize = 80;
            final size = index * itemsize / 2;
            final difernce = controller.offset - size;
            final persent = 1 - (difernce / (itemsize / 2));
            double opacity = persent;
            double scale = persent;
            if (opacity < 0) opacity = 0.0;

            if (opacity > 1) opacity = 1.0;
            if (persent > 1) scale = 1.0;
            var ink = inkwell[index];
            return Opacity(
              opacity: opacity,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(scale),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 1),
                            transitionsBuilder: (buildContext, animation,
                                secondaimaton, child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.easeInOut);
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (child, animation, secondanimation) {
                              return ink.onTap;
                            }));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      width: itemsize,
                      child: Image.asset(ink.pathimage)),
                ),
              ),
            );
          }, childCount: inkwell.length))
        ],
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
