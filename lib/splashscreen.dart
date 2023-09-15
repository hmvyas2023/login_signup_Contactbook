import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'Database.dart';
import 'Loginpage.dart';
import 'afterlogin.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  static Database? db;
  static SharedPreferences? prefs;
  static bool iswaiting = false;
  static List<Map> listofcontact = [];
  static String? user = splash.prefs?.getString("id");

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with TickerProviderStateMixin {
  late Animation circleanimation;
  late Animation sqaureanimation;
  late Animation coloranimation1;
  late Animation coloranimation2;
  late Animation textanimation;
  late AnimationController controller;
  late AnimationController controllertext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    controllertext =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    circleanimation = Tween(begin: 80.0, end: 200.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    sqaureanimation = Tween(begin: 100.0, end: 300.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut));

    textanimation = Tween(begin: 0.0, end: 15.0).animate(
        CurvedAnimation(parent: controllertext, curve: Curves.easeInOutBack));

    coloranimation1 =
        ColorTween(begin: Colors.green, end: Colors.red).animate(controller);
    coloranimation2 = ColorTween(begin: Colors.yellowAccent, end: Colors.black)
        .animate(controller);

    controller.forward();

    controllertext.forward();

    controllertext.addListener(() {
      setState(() {});
    });

    controller.addListener(() {
      if (controller.isCompleted) {
        controller.reverse();
      }
    });

    mydatabase();
    mysharepref();

    mypage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controllertext.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
            child: RotationTransition(
          turns: controller,
          child: Container(
              color: coloranimation1.value,
              width: circleanimation.value,
              child: Center(
                child: Text("Flutter".toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textanimation.value)),
              ),
              height: circleanimation.value),
        )),
      ),
    );
  }

  void mypage() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (splash.iswaiting) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => afterlogin(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => loginpage(),
            ));
      }
    });
  }

  void mydatabase() {
    Mydatabase().createdatabase().then((value) {
      setState(() {
        splash.db = value;
      });
    });
  }

  Future<void> mysharepref() async {
    // Obtain shared preferences.
    splash.prefs = await SharedPreferences.getInstance();

    setState(() {
      splash.prefs!.getString("email") ?? "";
      splash.prefs!.getString("password") ?? "";
      splash.prefs!.getString("name") ?? "";
      splash.prefs!.getString("number") ?? "";
      splash.user = splash.prefs!.getString("id") ?? "";
      splash.iswaiting = splash.prefs!.getBool("screen") ?? false;

      print(splash.iswaiting);
    });
  }
}
