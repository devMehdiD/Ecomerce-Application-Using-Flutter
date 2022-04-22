import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerceprojects/componnet/widget.dart';
import 'package:ecomerceprojects/service/chosepayment.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  dynamic image;
  dynamic price;
  dynamic name;

  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  var carte = FirebaseFirestore.instance
      .collection("carteproduit")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
  getdata() async {
    var response = await carte.get();

    for (var element in response.docs) {
      setState(() {
        items.add(element.data());
      });
      setState(() {
        docs.add(element.id);
      });
    }
    // ignore: avoid_print
    print(docs);
  }

  List docs = [];
  List items = [];
  // ignore: non_constant_identifier_names
  var selected_index = 0;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: items.isNotEmpty
            ? AnimatedList(
                key: _key,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return mylist(items[index], index, animation);
                },
              )
            : const Center(
                child: Text(
                  "leading ...",
                  style: TextStyle(color: Colors.white),
                ),
              ));
  }

  Widget mylist(item, int index, Animation<double> animation) => SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(
                "${item['name']}",
                style: const TextStyle(color: Colors.black),
              ),
              isThreeLine: true,
              subtitle: Row(
                children: [
                  Expanded(
                      child: Text(
                    "${item['price']} \$",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
                  Expanded(
                      child: Text(
                    "${item['pricecoche']} \$",
                    style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  )),
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 600),
                                    pageBuilder: (context, animation,
                                        secondaryanimation) {
                                      var twen = Tween<Offset>(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero);
                                      var position = animation.drive(twen);
                                      return SlideTransition(
                                          position: position,
                                          child: ChosePayment(
                                            color: item['color'],
                                            image: item['image'],
                                            size: item['size'],
                                            price: item['price'],
                                            qty: item['qty'],
                                            name: item['name'],
                                          ));
                                    }));
                          },
                          icon: const Icon(
                            Icons.payment,
                            color: Colors.black,
                          ))),
                ],
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  item['image'],
                  fit: BoxFit.contain,
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    _removeitem(docs[index], index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ),
          ),
        ),
      );

//

  _removeitem(path, i) {
    var removeitem = items.removeAt(i);
    //print(removeitem);
    AnimatedListRemovedItemBuilder builder;
    builder = (buildcontext, animatioin) {
      return mylist(removeitem, i, animatioin);
    };
    _key.currentState!.removeItem(i, builder);
    // ignore: avoid_print
    class_widget().delet(path, context);
  }
}
