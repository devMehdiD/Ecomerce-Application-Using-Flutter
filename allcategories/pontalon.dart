import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/componnet/produit.dart';
import 'package:ecomerceprojects/componnet/widget.dart';
import 'package:ecomerceprojects/produit/backservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Pontaloncat extends StatefulWidget {
  const Pontaloncat({Key? key}) : super(key: key);

  @override
  _PhoneCateState createState() => _PhoneCateState();
}

class _PhoneCateState extends State<Pontaloncat>
    with SingleTickerProviderStateMixin {
  var trousers = FirebaseFirestore.instance.collection("pontalon");
  late AnimationController _controller;
  var selectedindex = 0;

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
          title: const Text("Sac For Woamen"),
          centerTitle: true,
        ),
        body: ListView(children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: TypeAheadField(
                animationDuration: const Duration(seconds: 1),
                textFieldConfiguration: TextFieldConfiguration(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      suffixIcon: const Icon(
                        AntDesign.search1,
                      ),
                      hintText: "Search Phone",
                      hintStyle: const TextStyle(color: Colors.grey)),
                ),
                suggestionsCallback: (pattern) async {
                  return await BackendService()
                      .gettrousersfromfirebase(pattern);
                },
                itemBuilder: (context, DocumentSnapshot<Object?> suggestion) {
                  return ListTile(
                      title: Text("${suggestion['name']}"),
                      leading: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(100),
                        // ignore: avoid_unnecessary_containers
                        child: Image.network("${suggestion['image']}"),
                      ),
                      subtitle: Text("${suggestion['price']} \$"));
                },
                onSuggestionSelected: (DocumentSnapshot<Object?> suggestion) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Produit(
                            rate: "${suggestion['rate']}",
                            pricecoche: "${suggestion['pricecoche']}",
                            image2: "${suggestion['image2']}",
                            image: "${suggestion['image']}",
                            name: "${suggestion['name']}",
                            price: suggestion['price'],
                            desc: "${suggestion['desc']}",
                            image3: "${suggestion['image3']}",
                            image4: "${suggestion['image4']}",
                          )));
                }),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: animationtwen(),
                width: double.infinity,
              ),
            ),
          )
        ]));
  }

  animationtwen() {
    return SizedBox(
      height: 400,
      child: StreamBuilder(
          stream: trousers.snapshots(),
          builder: (buildcontetxt, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      selectedindex = index;
                    });
                  },
                  controller: PageController(viewportFraction: 0.8),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    double scale = selectedindex == index ? 1 : 0.9;

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: scale, end: scale),
                      curve: Curves.ease,
                      duration: const Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Transform.scale(
                            alignment: Alignment.center,
                            scale: value,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: child));
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder: (buildcontetx, animation,
                                      secondanimation) {
                                    var twen = Tween<Offset>(
                                        begin: const Offset(0, 1),
                                        end: Offset.zero);
                                    var possition = animation.drive(twen);
                                    return SlideTransition(
                                        position: possition,
                                        child: Produit(
                                          rate: snapshot.data!.docs[index]
                                              ['rate'],
                                          pricecoche: snapshot.data!.docs[index]
                                              ['pricecoche'],
                                          image2: snapshot.data!.docs[index]
                                              ['image2'],
                                          image: snapshot.data!.docs[index]
                                              ['image'],
                                          name: snapshot.data!.docs[index]
                                              ['name'],
                                          price: snapshot.data!.docs[index]
                                              ['price'],
                                          desc: snapshot.data!.docs[index]
                                              ['desc'],
                                          image3: snapshot.data!.docs[index]
                                              ['image3'],
                                          image4: snapshot.data!.docs[index]
                                              ['image4'],
                                        ));
                                  }));
                        },
                        child: Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GridTile(
                            header: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapshot.data!.docs[index]['name']} ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.7)),
                                )
                              ],
                            ),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data!.docs[index]['image']),
                                      fit: BoxFit.fill)),
                            ),
                            footer: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showModal(
                                          configuration:
                                              const FadeScaleTransitionConfiguration(
                                                  reverseTransitionDuration:
                                                      Duration(
                                                          milliseconds: 600),
                                                  transitionDuration:
                                                      Duration(seconds: 1)),
                                          context: context,
                                          builder: (buildcontext) {
                                            return class_widget()
                                                .showdailoglike(
                                                    snapshot, index, context);
                                          });
                                    },
                                    icon: const Icon(
                                      AntDesign.hearto,
                                      color: Colors.black,
                                    )),
                                Text(
                                  "${snapshot.data!.docs[index]['price']} \$",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${snapshot.data!.docs[index]['pricecoche']} \$",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 15),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModal(
                                          configuration:
                                              const FadeScaleTransitionConfiguration(
                                                  reverseTransitionDuration:
                                                      Duration(
                                                          milliseconds: 600),
                                                  transitionDuration:
                                                      Duration(seconds: 1)),
                                          context: context,
                                          builder: (buildcontext) {
                                            return class_widget().showdailog(
                                                snapshot, index, context);
                                          });
                                    },
                                    icon: const Icon(
                                      AntDesign.shoppingcart,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
