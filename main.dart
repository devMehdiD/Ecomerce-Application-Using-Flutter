import 'package:ecomerceprojects/settings/settingapp.dart';
import 'package:ecomerceprojects/Authentification/signin.dart';
import 'package:ecomerceprojects/slider/sliderpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'componnet/ferstpageapp.dart';

late bool islogin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51JZZPPAeGoqcHnMGKGlLBsXry8e9nY2Be2TwH91SfzLsvjhrN5aQnRcBNDuCVT2hZFr8QMTooWCRSXibLFq35se100AwbEcxQc';

  await Stripe.instance.applySettings();
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
  runApp(const MyApp());
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    islogin = true;
  } else {
    islogin = false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool defaultValue = false;
    ThemeData dark = ThemeData(
        brightness: Brightness.dark,
        appBarTheme:
            const AppBarTheme(elevation: 0, color: Colors.transparent));
    ThemeData ligth = ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0));
    // ignore: unused_local_variablelu, unused_local_variable
    final isdarkmode = Settings.getValue(const Sttingsapp().modekey, false);
    return ValueChangeObserver<bool>(
        cacheKey: const Sttingsapp().modekey,
        defaultValue: defaultValue,
        builder: (_, isdarkmode, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: isdarkmode ? dark : ligth,
              home: islogin ? const Festpage() : const Sliderpage(),
              routes: {
                'PagePayment': (context) {
                  return const Festpage();
                },
                'ChoseAuth': (context) {
                  return const ChoseAuth();
                },
              },
            ));
  }
}
