import 'package:ecomerceprojects/Authentification/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

// ignore: must_be_immutable
class Sliderpage extends StatefulWidget {
  const Sliderpage({
    Key? key,
  }) : super(key: key);

  @override
  SliderpageState createState() => SliderpageState();
}

class SliderpageState extends State<Sliderpage> with TickerProviderStateMixin {
  List<Slide> sliders = [];

  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    sliders.add(Slide(
      widgetTitle: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (buildcontext, animation, child) {
            return Opacity(
              opacity: animation,
              child: child,
            );
          },
          child: const Text(
            "Online Payment",
            style: TextStyle(
                color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      widgetDescription:
          const Text("With Super Market You Cant Make Oline Payment  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              )),
      centerWidget: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (buildcontext, animation, child) {
            return Opacity(
              opacity: animation,
              child: child,
            );
          },
          child: Image.asset(
            "assets/payimages/imagepay.png",
            width: 200,
            height: 200,
          )),
    ));
    sliders.add(Slide(
      widgetTitle: Center(
          child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (buildcontext, animation, child) {
          return Opacity(
            opacity: animation,
            child: child,
          );
        },
        child: const Text(
          "Dellvery Boy",
          style: TextStyle(
              color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      )),
      backgroundColor: Colors.white,
      description: "Speacial For You.Free Dellvred fess For Many Cities",
      styleDescription: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      centerWidget: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (buildcontext, animation, child) {
            return Opacity(
              opacity: animation,
              child: child,
            );
          },
          child: Image.asset(
            "assets/payimages/delevry.png",
            width: 200,
            height: 200,
          )),
    ));
    sliders.add(Slide(
      widgetTitle: Center(
          child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (buildcontext, animation, child) {
          return Opacity(
            opacity: animation,
            child: child,
          );
        },
        child: const Text(
          "Search Items",
          style: TextStyle(
              color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      )),
      backgroundColor: Colors.white,
      description: "With Super Market You Cant Search The Million Of Items",
      styleDescription: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      centerWidget: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (buildcontext, animation, child) {
            return Opacity(
              opacity: animation,
              child: child,
            );
          },
          child: Image.asset(
            "assets/payimages/serch.png",
            width: 200,
            height: 200,
          )),
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: IntroSlider(
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        onDonePress: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (buildcontext, animation, child) {
                    var twen = Tween<Offset>(
                        begin: const Offset(0, 1), end: Offset.zero);
                    var position = animation.drive(twen);
                    return SlideTransition(
                      position: position,
                      child: const ChoseAuth(),
                    );
                  }));
        },
        renderDoneBtn: const Text(
          "Done",
          style: TextStyle(color: Colors.black),
        ),
        renderSkipBtn: const Text(
          "Skip",
          style: TextStyle(color: Colors.black),
        ),
        renderNextBtn: const Text(
          "Next",
          style: TextStyle(color: Colors.black),
        ),
        slides: sliders,
        colorDot: Colors.grey,
        colorActiveDot: Colors.blue,
      ),
    );
  }
}
