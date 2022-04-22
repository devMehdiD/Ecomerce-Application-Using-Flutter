import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Sttingsapp extends StatefulWidget {
  final modekey = "key-mode";
  const Sttingsapp({Key? key}) : super(key: key);

  @override
  _SttingsappState createState() => _SttingsappState();
}

class _SttingsappState extends State<Sttingsapp> {
  var ordernotcreditcard = FirebaseFirestore.instance
      .collection("demendnocreditcard")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  var userinfo = FirebaseFirestore.instance
      .collection("users")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  var userid = FirebaseAuth.instance.currentUser!.uid;
  var orderr = FirebaseFirestore.instance
      .collection("demende")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  var userprifileinfo = FirebaseFirestore.instance
      .collection("users")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  updateusername(String username) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'username': username});
  }

  @override
  void initState() {
    super.initState();
    getinfouser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List data = [];
  getinfouser() async {
    var infouser = await userinfo.get();
    // ignore: avoid_function_literals_in_foreach_calls
    infouser.docs.forEach((element) {
      setState(() {
        data.add(element.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(height: 70, child: getinfouserr()),
        SettingsGroup(title: " Géneral", children: [
          builddarkmode(),
          order(),
          ordernotpayed(),
          rateus(),
          about(),
        ]),
        SettingsGroup(title: "Account Settings", children: [
          deleteaccount(),
          logout(),
        ]),
      ],
    ));
  }

  Widget builddarkmode() => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SwitchSettingsTile(
          settingKey: widget.modekey,
          title: "Them Mode",
          enabledLabel: "Enabled",
          disabledLabel: "Desabled",
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.purple,
            child: Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
          ),
        ),
      );
  Widget order() => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SimpleSettingsTile(
          title: "Order Paid",
          subtitle: "View Orders",
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent,
            child: Icon(
              AntDesign.clockcircle,
              color: Colors.white,
            ),
          ),
          child: SettingsScreen(title: "Order", children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: paymentsordercreditcard(),
            ),
          ]),
        ),
      );
  Widget getinfouserr() => StreamBuilder(
      stream: userinfo.snapshots(includeMetadataChanges: true),
      builder: (buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (buildcontext, int index) {
                return SimpleSettingsTile(
                  title: "${snapshot.data!.docs[index]['username']}",
                  subtitle: "${snapshot.data!.docs[index]['email']}",
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Feather.user,
                      color: Colors.white,
                    ),
                  ),
                  child: SettingsScreen(title: "User Info", children: [
                    SizedBox(height: 300, child: infoprofile()),
                  ]),
                );
              });
        }
        return const Center(
          child: Text("Loading"),
        );
      });
  Widget logout() => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SimpleSettingsTile(
        title: "Log Out",
        subtitle: "Log Out From Your Account",
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, "ChoseAuth", (route) => false);
        },
      ));
  Widget rateus() => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SimpleSettingsTile(
        title: "Rate Us",
        subtitle: "Rate App",
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Icon(
            AntDesign.star,
            color: Colors.white,
          ),
        ),
        onTap: () async {
          var url = "https://flutter.dev";
          await canLaunch(url)
              ? await launch(url)
              // ignore: avoid_print
              : print("we cant lunch this $url");
        },
      ));
  Widget about() => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SimpleSettingsTile(
        title: "About",
        subtitle: "More Info About Service",
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blue,
          child: Icon(
            AntDesign.info,
            color: Colors.white,
          ),
        ),
        onTap: () async {
          var url = "https://pub.dev/packages/url_launcher";
          await canLaunch(url)
              ? await launch(url)
              // ignore: avoid_print
              : print("we cant lunch this $url");
        },
      ));
  Widget deleteaccount() => Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: SimpleSettingsTile(
        title: "Delete",
        subtitle: "Delete You Acount",
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onTap: () async {
          try {
            await FirebaseAuth.instance.currentUser!.delete();
            Navigator.of(context).pushNamed("Sign");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'requires-recent-login') {
              // ignore: avoid_print
              print(
                  'The user must reauthenticate before this operation can be executed.');
            }
          }
        },
      ));

  Widget paymentsordercreditcard() => StreamBuilder(
      stream: orderr.snapshots(includeMetadataChanges: true),
      builder:
          (BuildContext buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (buildcontext, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${snapshot.data!.docs[index]['price']} \$",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                    "${snapshot.data!.docs[index]['name']}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              " ${snapshot.data!.docs[index]['color']} ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${snapshot.data!.docs[index]['time'].toDate().day} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "/${snapshot.data!.docs[index]['time'].toDate().month} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "/${snapshot.data!.docs[index]['time'].toDate().year} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "Succide",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    "State",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Feather.truck,
                                    color: Colors.black,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: Image.asset("assets/payimages/delevry.png")),
              const Text("Nothing"),
            ],
          ),
        );
      });

  Widget infoprofile() => StreamBuilder(
      stream: userprifileinfo.snapshots(includeMetadataChanges: true),
      builder:
          (BuildContext buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (buildcontext, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Feather.user,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Expanded(
                          child: ListTile(
                            isThreeLine: true,
                            title: const Text("User Name"),
                            leading: const Icon(Icons.person),
                            subtitle: Text(
                                "${snapshot.data!.docs[index]['username']}"),
                          ),
                        )
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(children: [
                        Expanded(
                          child: ListTile(
                            isThreeLine: true,
                            title: const Text("Email & Number"),
                            leading: const Icon(Icons.email),
                            subtitle:
                                Text("${snapshot.data!.docs[index]['email']}"),
                          ),
                        ),
                      ]),
                    ],
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Erorr"),
          );
        }
        return const Center(child: CircularProgressIndicator());
      });
  Widget paymentorderwithnotcreditcard() => StreamBuilder(
      stream: ordernotcreditcard.snapshots(includeMetadataChanges: true),
      builder:
          (BuildContext buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (buildcontext, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Paid Not  ${snapshot.data!.docs[index]['price'] * snapshot.data!.docs[index]['qty']} \$",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                    "${snapshot.data!.docs[index]['name']}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              " ${snapshot.data!.docs[index]['color']} ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${snapshot.data!.docs[index]['time'].toDate().day} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "/${snapshot.data!.docs[index]['time'].toDate().month} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "/${snapshot.data!.docs[index]['time'].toDate().year} ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "Succide",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: const Text(
                                    "State",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Feather.truck,
                                    color: Colors.black,
                                  ))),
                        ],
                      ),
                      const SizedBox(
                        height: 120,
                      )
                    ],
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // ignore: avoid_unnecessary_containers
        return Center(
          child: Column(
            children: [
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Image.asset("assets/payimages/delevry.png"))),
              const Text("No Order"),
            ],
          ),
        );
      });
  Widget ordernotpayed() => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SimpleSettingsTile(
          title: "Order Paid Not ",
          subtitle: "View Orders",
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueAccent,
            child: Icon(
              AntDesign.clockcircle,
              color: Colors.white,
            ),
          ),
          child: SettingsScreen(title: "Order", children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: paymentorderwithnotcreditcard()),
          ]),
        ),
      );
}
