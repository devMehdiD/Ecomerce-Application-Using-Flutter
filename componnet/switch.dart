// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Switchimage extends StatefulWidget {
  dynamic image;
  dynamic image2;
  dynamic image3;
  dynamic image4;

  Switchimage(
      {Key? key,
      required this.image,
      required this.image2,
      required this.image3,
      required this.image4})
      : super(key: key);

  @override
  _SwitchState createState() => _SwitchState();
}

class _SwitchState extends State<Switchimage> {
  Widget? _pic;
  // ignore: unused_field
  Widget? _pic2;
  @override
  void initState() {
    _pic = Image.network(widget.image);
    _pic2 = Image.network(widget.image2);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateImgWidget(String url) async {
    setState(() {
      _pic = const Center(child: CircularProgressIndicator());
    });
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();
    setState(() {
      _pic = Image.memory(bytes);
      // ignore: avoid_print
      print(_pic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          title: const Text("Evanto Market",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Card(
                color: Colors.white,
                child: _pic,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        bottomSheet: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateImgWidget(
                      widget.image2,
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
                      child: Card(
                          color: Colors.white,
                          child: Image.network(
                            widget.image2,
                            fit: BoxFit.contain,
                          ))),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateImgWidget(
                      widget.image,
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
                      child: Card(
                        color: Colors.white,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.contain,
                        ),
                      )),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateImgWidget(
                      widget.image3,
                    );
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(5),
                      child: Card(
                          color: Colors.white,
                          child: Image.network(
                            widget.image3,
                            fit: BoxFit.contain,
                          ))),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    updateImgWidget(
                      widget.image4,
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.all(5),
                    child: Card(
                      color: Colors.white,
                      child: Image.network(
                        widget.image4,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )

        /*Row(children: [
        
       
        
        
        
      ]),*/
        );
  }
}
