// ignore_for_file: avoid_print

import 'package:ecomerceprojects/service/paymentfinish.dart';
import 'package:ecomerceprojects/service/paymentwithnocreditcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

// ignore: must_be_immutable
class ChosePayment extends StatefulWidget {
  dynamic price;
  dynamic name;
  dynamic color;
  dynamic size;
  dynamic image;
  dynamic qty;

  ChosePayment(
      {Key? key,
      required this.price,
      required this.name,
      required this.color,
      required this.size,
      required this.image,
      required this.qty})
      : super(key: key);

  @override
  _ChosePaymentState createState() => _ChosePaymentState();
}

class _ChosePaymentState extends State<ChosePayment>
    with SingleTickerProviderStateMixin {
  String? paynow = "PayNow";

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Payment Mode",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ))),
      body: ListView(
        children: [
          // ignore: sized_box_for_whitespace, avoid_unnecessary_containers
          Container(
            child: Image.asset("assets/payimages/paynowornot.png"),
          ),
          // ignore: avoid_unnecessary_containers
          ListTile(
            title: Row(
              children: [
                const Text('Crédit / Debit Card'),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Icon(Feather.credit_card))
              ],
            ),
            leading: Radio(
              value: "PayNow",
              groupValue: paynow,
              onChanged: (value) {
                setState(() {
                  paynow = value as String?;
                  print(paynow);
                });
              },
            ),
          ),
          // ignore: avoid_unnecessary_containers
          ListTile(
            title: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text('Cache On Delevery'),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Icon(Feather.dollar_sign))
              ],
            ),
            leading: Radio(
              value: "OnDelevry",
              groupValue: paynow,
              onChanged: (value) {
                setState(() {
                  paynow = value as String?;
                  print(paynow);
                });
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
          )
          // ignore: avoid_unnecessary_containers
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
              textColor: Colors.white,
              onPressed: () {
                if (paynow == "OnDelevry") {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 600),
                          pageBuilder: (context, animation, secondanimation) {
                            var twen = Tween<Offset>(
                                begin: const Offset(0, 1), end: Offset.zero);
                            var position = animation.drive(twen);
                            return SlideTransition(
                              position: position,
                              child: PayemntWithNoCreditCard(
                                price: widget.price,
                                name: widget.name,
                                color: widget.color,
                                size: widget.size,
                                image: widget.image,
                                qty: widget.qty,
                              ),
                            );
                          }));
                }
                if (paynow == "PayNow") {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 600),
                          pageBuilder: (context, animation, secondanimation) {
                            var twen = Tween<Offset>(
                                begin: const Offset(0, 1), end: Offset.zero);
                            var position = animation.drive(twen);
                            return SlideTransition(
                              position: position,
                              child: Finishpayment(
                                price: widget.price,
                                name: widget.name,
                                color: widget.color,
                                size: widget.size,
                                image: widget.image,
                                qty: widget.qty,
                              ),
                            );
                          }));
                }
              },
              child: const Text(
                "CONTINUE",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
    );
  }
}
