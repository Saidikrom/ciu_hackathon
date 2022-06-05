import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class Object3DScreen extends StatefulWidget {
  const Object3DScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<Object3DScreen> createState() => _Object3DScreemState();
}

class _Object3DScreemState extends State<Object3DScreen> {
  void whenArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => removeObject(name);
    arCoreController.onPlaneTap = handleonPlaneTap;
  }

  void handleonPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    addObject(hit);
  }

  removeObject(String name) {
    showDialog(
      context: context,
      builder: (BuildContext c) => AlertDialog(
        content: Row(
          children: [
            Text("Remove" + name),
            IconButton(
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  addObject(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      final objectNode = ArCoreReferenceNode(
        name: objectSelected,
        object3DFileName: objectSelected,
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
      );
      arCoreController.addArCoreNode(objectNode);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext c) => AlertDialog(
          content: Text("Select an Image."),
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    arCoreController.dispose();
  }

  @override
  ArCoreController arCoreController;
  String objectSelected;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ArCoreView(
              onArCoreViewCreated: whenArCoreViewCreated,
              enableTapRecognizer: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListObjectSelection(
                onTab: (value) {
                  objectSelected = value;
                },
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: InkWell(
            //     onTap: () async {},
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 50),
            //       child: CircleAvatar(
            //         backgroundColor: Colors.white,
            //         radius: 30,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ListObjectSelection extends StatefulWidget {
  final Function onTab;
  ListObjectSelection({this.onTab});
  @override
  State<ListObjectSelection> createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  List<String> gifs = [
    "assets/stulll.png",
    "assets/tummba.png",
    "assets/tumba.png",
  ];

  List<String> fileName = [
    "uni.sfb",
    "Art.sfb",
    "u.sfb",
  ];
  List<String> name = [
    "Stull",
    "Tumba",
    "krovat",
  ];
  List<String> share = [
    " #1 Stull ---- \$50",
    " #2 Tumba,---- \$90",
    " #3 krovat, ---- \$100",
  ];
  List<String> cost = [
    "\$50",
    "\$90",
    "\$100",
  ];
  String selected;

  void ShareText() {
    Share.share(name[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 300,
        child: ListView.builder(
          itemCount: gifs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = gifs[index];
                  widget.onTab(fileName[index]);
                });
              },
              child: Card(
                color: selected == gifs[index]
                    ? Color.fromARGB(255, 162, 244, 54)
                    : Color.fromARGB(255, 255, 255, 255),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Column(
                      children: [
                        Image.asset(
                          gifs[index],
                          scale: 7,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          name[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          cost[index],
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                              height: 45,
                              width: 160,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: selected == gifs[index]
                                        ? MaterialStateProperty.all(
                                            Color.fromARGB(255, 255, 255, 255))
                                        : null),
                                onPressed: () {
                                  void ShareText() {
                                    Share.share(share[index]);
                                  }

                                  ShareText();
                                },
                                child: Text(
                                  "Buy",
                                  style: TextStyle(
                                      color: selected == gifs[index]
                                          ? Color.fromARGB(255, 0, 0, 0)
                                          : null),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
