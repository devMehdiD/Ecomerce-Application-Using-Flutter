import 'package:ecomerceprojects/allcategories/chemise.dart';
import 'package:ecomerceprojects/allcategories/costume.dart';
import 'package:ecomerceprojects/allcategories/dresscat.dart';
import 'package:ecomerceprojects/allcategories/jaket.dart';
import 'package:ecomerceprojects/allcategories/laptop.dart';
import 'package:ecomerceprojects/allcategories/pontalon.dart';
import 'package:ecomerceprojects/allcategories/saccat.dart';
import 'package:ecomerceprojects/allcategories/watch.dart';
import 'package:ecomerceprojects/componnet/carte.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Allcategories extends StatefulWidget {
  const Allcategories({Key? key}) : super(key: key);

  @override
  _AllcategoriesState createState() => _AllcategoriesState();
}

class _AllcategoriesState extends State<Allcategories>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    mode();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Color bg = Colors.white;
  bool them = false;
  mode() {
    // ignore: unrelated_type_equality_checks
    if (ThemeMode.dark == true) {
      setState(() {
        them = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 2),
                          transitionsBuilder: (buildcontext, animation,
                              secondanimation, child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.elasticInOut);
                            return ScaleTransition(
                              alignment: Alignment.center,
                              scale: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (context, animation, secondanimation) {
                            return Cart();
                          }));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          title: const Text(
            "All Categories",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.count(
          primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 4,
          staggeredTiles: const <StaggeredTile>[
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 3.5),
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 3.5),
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 3.5),
            StaggeredTile.count(2, 4),
            StaggeredTile.count(2, 3.5),
          ],
          children: [
            buildcontent(const Pontaloncat(), "assets/categories/pontalon.jpg",
                Colors.white, Colors.black),
            buildcontent(const JaketCat(), "assets/categories/jaket.jpg",
                Colors.white, Colors.white),
            buildcontent(const Dresscat(), "assets/categories/robe.jpg",
                Colors.pink, Colors.black),
            buildcontent(const SwatchCat(), "assets/categories/watch.jpg",
                Colors.purple, Colors.black),
            buildcontent(const Lpatopcat(), "assets/categories/pc.jpg",
                Colors.lightGreenAccent, Colors.black),
            buildcontent(const Saccat(), "assets/categories/sac.jpg",
                Colors.redAccent, Colors.black),
            buildcontent(const CostumeCat(), "assets/categories/costume.JPG",
                Colors.deepOrange, Colors.black),
            buildcontent(
                const Chemisecat(),
                "assets/categories/chemisehome.jpg",
                Colors.green,
                Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildcontent(
      StatefulWidget f, String path, Color color, Color colorr) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (buildcontext, animation, secondanimation) {
                    var twen = Tween<Offset>(
                        begin: const Offset(0, 1), end: Offset.zero);
                    var position = animation.drive(twen);
                    return SlideTransition(
                      position: position,
                      child: f,
                    );
                  }));
        },
      ),
    );
  }
}
