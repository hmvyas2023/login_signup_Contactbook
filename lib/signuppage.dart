import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/Database.dart';
import 'package:loginsignup/Loginpage.dart';
import 'package:loginsignup/splashscreen.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String gender = "male";
  bool cricketcheck = true;
  bool Readingcheck = true;
  bool Travellingcheck = true;

  bool namecheck = false;
  String? name_error;

  bool numbercheck = false;
  String? number_error;

  bool emailcheck = false;
  String? email_error;

  bool passcheck = false;
  String? pass_error;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: theight,
        width: twidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xff00B09B), Color(0xff96C93D)])),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    errorText: namecheck ? name_error : null,
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  final regex = RegExp(r'^[a-zA-Z ]+$');

                  setState(() {
                    if (name.text.isEmpty) {
                      namecheck = true;
                      name_error = "Enter the Name";
                    } else if (!regex.hasMatch(name.text)) {
                      namecheck = true;
                      name_error = "Invalid Name";
                    } else {
                      namecheck = false;
                      name_error = null;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  RegExp regex1 = RegExp(r'^(\+?91)?[7-9][0-9]{9}$');

                  setState(() {
                    if (number.text.isEmpty) {
                      numbercheck = true;
                      number_error = "Enter the Number";
                    } else if (!regex1.hasMatch(number.text)) {
                      numbercheck = true;
                      number_error = "Enter Valid Number";
                    } else {
                      numbercheck = false;
                      number_error = null;
                    }
                  });
                },
                controller: number,
                decoration: InputDecoration(
                    errorText: numbercheck ? number_error : null,
                    labelText: "Number",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  RegExp regx2 =
                      RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$");

                  setState(() {
                    if (email.text.isEmpty) {
                      emailcheck = true;
                      email_error = "Enter the Email";
                    } else if (!regx2.hasMatch(email.text)) {
                      emailcheck = true;
                      email_error = "Enter the Valid Email";
                    } else {
                      emailcheck = false;
                      email_error = null;
                    }
                  });
                },
                controller: email,
                decoration: InputDecoration(
                    errorText: emailcheck ? email_error : null,
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  RegExp regx4 = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      multiLine: false,
                      caseSensitive: false);

                  setState(() {
                    if (password.text.isEmpty) {
                      passcheck = true;
                      pass_error = "Enter the Password";
                    } else if (!regx4.hasMatch(password.text)) {
                      passcheck = true;
                      pass_error = "Enter the Valid Password";
                    } else {
                      passcheck = false;
                      pass_error = null;
                    }
                  });
                },
                controller: password,
                decoration: InputDecoration(
                    errorText: passcheck ? pass_error : null,
                    labelText: "Password",
                    helperText:
                        "Uppercase,Lowercase,Digit,Specialcharacter,Min.8characters",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Text("Gender:"),
                SizedBox(
                  width: 25,
                ),
                Text("Male"),
                Radio(
                  fillColor: MaterialStatePropertyAll(Color(0xff9B31F5)),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Text("Female"),
                Radio(
                  fillColor: MaterialStatePropertyAll(Color(0xff9B31F5)),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                )
              ]),
              Row(
                children: [
                  Text("Hobbies:  "),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          "Cricket",
                        ),
                        Checkbox(
                          fillColor:
                              MaterialStatePropertyAll(Color(0xff9B31F5)),
                          value: cricketcheck,
                          onChanged: (value) {
                            print(value);

                            setState(() {
                              cricketcheck = value!;
                            });
                          },
                        ),
                        Text(
                          "Reading",
                        ),
                        Checkbox(
                          fillColor:
                              MaterialStatePropertyAll(Color(0xff9B31F5)),
                          value: Readingcheck,
                          onChanged: (value) {
                            setState(() {
                              Readingcheck = value!;
                            });
                          },
                        ),
                        Text(
                          "Travelling",
                        ),
                        Checkbox(
                          fillColor:
                              MaterialStatePropertyAll(Color(0xff9B31F5)),
                          value: Travellingcheck,
                          onChanged: (value) {
                            setState(() {
                              Travellingcheck = value!;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff9B31F5))),
                  onPressed: () {
                    if (name.text.isEmpty &&
                        email.text.isEmpty &&
                        password.text.isEmpty &&
                        number.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter All the fill")));
                    } else {
                      Mydatabase()
                          .insertdata(name.text, password.text, email.text,
                              number.text, splash.db!)
                          .then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Register sucessfully")));

                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return loginpage();
                            },
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data alredy exist")));
                        }
                      });
                    }
                  },
                  child: Text("SignUp")),
              SizedBox(
                height: 50,
              ),
              Text(
                "**** ALL FIELDS ARE MANDATORY TO FILL *****",
                style: TextStyle(color: Colors.black.withOpacity(0.4)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
