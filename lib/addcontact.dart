import 'package:flutter/material.dart';
import 'package:loginsignup/Database.dart';
import 'package:loginsignup/afterlogin.dart';
import 'package:loginsignup/splashscreen.dart';

class addcontact extends StatefulWidget {
  String name;
  String contact;
  int id;

  addcontact({Key? key, this.name = '', this.contact = '', this.id = 0})
      : super(key: key);

  @override
  State<addcontact> createState() => _addcontactState();
}

class _addcontactState extends State<addcontact> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Name.text = widget.name;
    Number.text = widget.contact;
  }

  TextEditingController Name = TextEditingController();
  TextEditingController Number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double tHeight = MediaQuery.of(context).size.height;
    double tWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff00B09B), title: Text("Add Contact")),
      body: Container(
        height: tHeight,
        width: tWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xff00B09B), Color(0xff96C93D)])),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: Name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: Number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Number")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff9B31F5))),
                onPressed: () {
                  if (widget.name.isNotEmpty) {
                    // update

                    Mydatabase()
                        .updateContact(
                            Name.text, Number.text, widget.id, splash.db!)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => afterlogin(),
                          ));
                    });
                  } else {
                    Mydatabase()
                        .insertcontactdata(
                            Name.text, Number.text, splash.user!, splash.db!)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => afterlogin(),
                          ));
                      print(value);
                    });
                  }
                },
                child: (widget.name.isNotEmpty
                    ? Text("Update")
                    : Text("Add Contact")))
          ]),
        ),
      ),
    );
  }
}
