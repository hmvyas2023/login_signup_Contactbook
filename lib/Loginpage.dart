import 'package:flutter/material.dart';
import 'package:loginsignup/Database.dart';
import 'package:loginsignup/afterlogin.dart';
import 'package:loginsignup/signuppage.dart';
import 'package:loginsignup/splashscreen.dart';

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // Obtain shared preferences.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: Container(
        width: twidth,
        height: theight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xff00B09B), Color(0xff96C93D)])),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
              ),
              Image(
                  image: AssetImage("images/icons8-portal-logo-64.png"),
                  fit: BoxFit.fill),
              SizedBox(
                height: 70,
              ),
              Opacity(
                opacity: 0.9,
                child: Container(
                  height: theight * 0.4,
                  width: twidth * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.1)
                          ],
                          stops: [
                            0,
                            1
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: email,
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: password,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xff9B31F5))),
                              onPressed: () {
                                Mydatabase()
                                    .logindata(
                                        email.text, password.text, splash.db!)
                                    .then((value) {
                                  if (email.text.isEmpty &&
                                      password.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "please enter your email and password")));
                                  } else if (value.length == 1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Welcome")));

                                    setState(() {
                                      splash.iswaiting = true;
                                      splash.user = "${value[0]['id']}";

                                      splash.prefs!.setString(
                                          "email", "${value[0]['Email']}");
                                      splash.prefs!.setString("password",
                                          "${value[0]['Password']}");
                                      splash.prefs!.setString(
                                          "number", "${value[0]['Number']}");
                                      splash.prefs!.setString(
                                          "name", "${value[0]['Name']}");
                                      splash.prefs!
                                          .setBool("screen", splash.iswaiting);

                                      splash.prefs!
                                          .setString("id", splash.user!);
                                    });

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return afterlogin();
                                      },
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("wrong id/password")));
                                  }
                                });
                              },
                              child: Text("Login")),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Acoount ??",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9))),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return Signup();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Color(0xff4359FA),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  )),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
