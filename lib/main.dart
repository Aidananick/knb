import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "knb",
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.accessibility_new_rounded),
              ),
              Tab(
                icon: Icon(Icons.accessibility_new_rounded),
              ),
              Tab(
                icon: Icon(Icons.accessibility_new_rounded),
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/wallpaper.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: MyKNB()
              ),
              Center(
                child: Image(image: AssetImage('assets/images/wallpaper.png')),
              ),
              Center(
                child: Text("333333"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyKNB extends StatefulWidget {
  const MyKNB({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyStateKNB();
  }
}

class MyStateKNB extends State<MyKNB> {
  List<String> images = const [
    'assets/images/rock.jpg', //0
    'assets/images/sc.png', //1
    'assets/images/paper.png', //2
  ];
  late String image1;
  late String image2;
  late bool stopper;
  late bool oc1;
  late bool oc2;
  late int index1;
  late int index2;

  String getImage1() {
    setState(() {
      index1 = Random().nextInt(3);
    });
    return images[index1];
  }

  String getImage2() {
    setState(() {
      index2 = Random().nextInt(3);
    });
    return images[index2];
  }

  @override
  void initState() {
    super.initState();
    image1 = getImage1();
    image2 = getImage2();
    stopper = false;
    oc1 = false;
    oc2 = false;
  }

  void winner() {
    if (index1 == 0 && index2 == 1 ||
        index1 == 1 && index2 == 2 ||
        index1 == 2 && index2 == 0) {
      setState(() {
        oc1 = true;
        oc2 = false;
      });
    } else if (index2 == 0 && index1 == 1 ||
        index2 == 1 && index1 == 2 ||
        index2 == 2 && index1 == 0) {
      setState(() {
        oc1 = false;
        oc2 = true;
      });
    } else {
      setState(() {
        oc1 = false;
        oc2 = false;
      });
    }
  }
  var turns = 0.0;
  void _changeRotate(){
    setState((){
      turns += 1.0 / 4.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(50)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstChild: AnimatedRotation(
                turns:turns,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  width:150,
                  height:150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85),
                    border: Border.all(width: 0),
                    image: DecorationImage(
                        opacity: 1,
                        image: AssetImage(image1),
                        fit:BoxFit.fill),
                  ),
                ),
              ),
              secondChild: Container(
                width:150,
                height:150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(85),
                  border: Border.all(width: 0),
                  image: DecorationImage(
                      opacity: 1,
                      image: AssetImage('assets/images/winner.png'),
                      fit:BoxFit.fill),
                ),
              ),
              crossFadeState: oc1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(seconds: 1),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.all(50)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCrossFade(
              firstChild: AnimatedRotation(
                turns:turns,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  width:150,
                  height:150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85),
                    border: Border.all(width: 0),
                    image: DecorationImage(
                        opacity: 1,
                        image: AssetImage(image2),
                        fit:BoxFit.fill),
                  ),
                ),
              ),
              secondChild: Container(
                width:150,
                height:150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(85),
                  border: Border.all(width: 0),
                  image: DecorationImage(
                      opacity: 1,
                      image: AssetImage('assets/images/winner.png'),
                      fit:BoxFit.fill),
                ),
              ),
              crossFadeState: oc2 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(seconds: 1),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(50)),
            ElevatedButton(
                onPressed: () {

                  setState(() {

                    stopper = false;
                    oc2 = false;
                    oc1 = false;
                  });
                  Timer.periodic(const Duration(milliseconds: 3), (timer) async {
                    setState(() {
                      image1 = getImage1();
                      _changeRotate();
                    });
                    if (stopper) {
                      timer.cancel();
                      winner();
                    }
                  });
                  Timer.periodic(const Duration(milliseconds: 3),
                          (timer) async {
                        setState(() {
                          _changeRotate();
                          image2 = getImage2();
                        });
                        if (stopper) {
                          timer.cancel();
                          winner();
                        }
                      });
                },
                child: const Text("start")),
            Padding(padding: EdgeInsets.all(50)),
            ElevatedButton(
                onPressed: ()
                {

                  setState(() {
                    stopper = true;
                  });
                },
                child: const Text("stop")),
          ],
        ),
      ],
    );
  }
}
