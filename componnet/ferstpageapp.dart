// ignore_for_file: sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers, unused_import, must_be_immutable

import 'dart:async';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecomerceprojects/allcategories/allcategories.dart';
import 'package:ecomerceprojects/componnet/like.dart';

import 'package:ecomerceprojects/settings/settingapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'carte.dart';
import 'ferstpage.dart';
import 'serch.dart';

class Festpage extends StatefulWidget {
  const Festpage({
    Key? key,
  }) : super(key: key);

  @override
  _PagePaymentState createState() => _PagePaymentState();
}

class _PagePaymentState extends State<Festpage> {
  static int _selectedIndex = 0;

  // ignore: unused_field

  @override
  void initState() {
    scren.add(const FerstPage());
    scren.add(Serch());
    scren.add(const Like());
    scren.add(Cart());
    scren.add(const Sttingsapp());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  List scren = [];

  Color bg = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                icon: const Icon(
                  AntDesign.hearto,
                )),
            IconButton(
                onPressed: () async {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ))
          ],
          centerTitle: true,
          title: const Text("Evento Market", style: TextStyle()),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: const Icon(
                AntDesign.search1,
              ))),
      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 2),
        child: scren.elementAt(_selectedIndex),
        transitionBuilder: (child, animation, secondanimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondanimation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(
            AntDesign.home,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            AntDesign.search1,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            AntDesign.hearto,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            AntDesign.shoppingcart,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            AntDesign.setting,
            size: 30,
            color: Colors.lightBlueAccent,
          ),
        ],
        index: _selectedIndex,
        animationCurve: Curves.bounceInOut,
        height: 70,
        backgroundColor: Colors.transparent,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  ///////// widgettttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt

}
