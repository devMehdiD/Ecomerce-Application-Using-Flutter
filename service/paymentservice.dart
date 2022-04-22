// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/Authentification/methode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Paymen {
  static var demende = FirebaseFirestore.instance.collection("demende");
  static late Map<String, dynamic> paymentdata;
  static String id = "";

  static Future<void> payment(
      String amount,
      crency,
      context,
      adress,
      city,
      color,
      contry,
      email,
      image,
      name,
      price,
      int qty,
      size,
      time,
      userid) async {
    paymentdata = await makepayment(amount, crency, qty);
    await Stripe.instance
        .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentdata['client_secret'],
                applePay: true,
                googlePay: true,
                testEnv: true,
                style: ThemeMode.light,
                merchantCountryCode: 'US',
                merchantDisplayName: 'ANNIE'))
        .then((value) {});

    try {
      await Stripe.instance
          .presentPaymentSheet(
              // ignore: deprecated_member_use
              parameters: PresentGooglePayParams(
                  clientSecret: paymentdata['client_secret'],
                  forSetupIntent: true))
          .then((value) {
        id = paymentdata['id'];
        adddata(adress, city, color, contry, email, image, name, price, qty,
            size, time, userid);
        authentification().flushbar("Payment Success", "Success", context);
      });
      // ignore: unused_catch_stack
    } catch (e, s) {
      authentification().flushbar("Payment Canceled", "Error", context);
    }
  }

  static makepayment(String amountn, String currency, qty) async {
    try {
      Map<String, String> body = {
        'amount': calculateAmount(amountn, qty),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51JZZPPAeGoqcHnMGdbFwJcHVaXwYwhdaARs7EmEY8wBdzUnreZBqRbkqRCZIakBpYAMtoohshtN9npetF5qFo8RM00GSVJ5QmV',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  static calculateAmount(amountn, qty) {
    var price = (int.parse(amountn)) * qty * 100;
    return price.toString();
  }

  static adddata(adress, city, color, contry, email, image, name, price, qty,
      size, time, userid) async {
    await demende.add({
      "adress": adress,
      "city": city,
      "color": color,
      "contry": contry,
      "email": email,
      "image": image,
      "name": name,
      "paymentid": id,
      "price": price,
      "qty": qty,
      "size": size,
      "time": time,
      "userid": userid
    });
  }
}
