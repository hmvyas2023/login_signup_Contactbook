import 'package:flutter/material.dart';
import 'package:loginsignup/Loginpage.dart';
import 'package:loginsignup/addcontact.dart';
import 'package:loginsignup/splashscreen.dart';

import 'Database.dart';

class afterlogin extends StatefulWidget {
  @override
  State<afterlogin> createState() => _afterloginState();
}

class _afterloginState extends State<afterlogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mycontact();

    print("mydataaaaaa=======${splash.listofcontact}");
    print("length=======${splash.listofcontact.length}");
  }

  bool issearch = false;

  List<Map> searchlist = [];

  @override
  Widget build(BuildContext context) {
    double tHeight = MediaQuery.of(context).size.height;
    double tWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff00B09B),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    issearch = !issearch;
                  });
                },
                icon: issearch ? Icon(Icons.cancel) : Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {
                    splash.iswaiting = false;
                  });

                  splash.prefs!.setBool("screen", splash.iswaiting);

                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return loginpage();
                    },
                  ));
                },
                icon: Icon(Icons.logout))
          ],
          title: issearch
              ? TextField(
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      searchlist.clear();
                      for (int i = 0; i < splash.listofcontact.length; i++) {
                        if (splash.listofcontact[i]['Name']
                                .toUpperCase()
                                .contains(value.toUpperCase()) ||
                            splash.listofcontact[i]['Number']
                                .toUpperCase()
                                .contains(value.toUpperCase())) {
                          searchlist.add(splash.listofcontact[i]);
                        }
                      }
                    });

                    print(splash.listofcontact);

                    setState(() {
                      // for(int i=0;i<splash.listofcontact.length;i++){
                      //
                      //   searchlist.clear();
                      //
                      //   if(splash.listofcontact[i]['Name'].){
                      //
                      //     searchlist.add(value);
                      //
                      //   }
                      // }
                    });

                    print(searchlist);
                  },
                )
              : Text("Welcome ${splash.prefs!.getString("name")}")),
      drawer: Opacity(
        opacity: 0.8,
        child: Drawer(
            backgroundColor: Color(0xff00B09B),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Icon(Icons.account_circle, size: 100),
                  ),
                  flex: 30,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name : ${splash.prefs!.getString("name")}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text("Number : ${splash.prefs!.getString("number")}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text("Email : ${splash.prefs!.getString("email")}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text(
                              "password : ${splash.prefs!.getString("password")}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text(
                              "booooool = == = = ${splash.prefs!.getBool("screen")}",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text(
                            "id : ${splash.prefs!.getString("id")}",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ]),
                  ),
                  flex: 60,
                )
              ],
            )),
      ),
      body: Container(
        height: tHeight,
        width: tWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xff00B09B), Color(0xff96C93D)])),
        child: issearch
            ? ListView.builder(
                itemCount: searchlist.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: ListTile(
                        onLongPress: () {},
                        leading: CircleAvatar(
                          backgroundColor: Color(0xff9B31F5),
                          radius: 40,
                          child: Text("${searchlist[index]['Name']}"[0]),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${searchlist[index]['Name']}"),
                            Text("${searchlist[index]['Number']}")
                          ],
                        )),
                  );
                },
              )
            : ListView.builder(
                itemCount: splash.listofcontact.length,
                itemBuilder: (context, index) {
                  print("llllll==${splash.listofcontact.length}");
                  return SingleChildScrollView(
                    child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff4359FA),
                            radius: 30,
                            child: Text(
                                "${splash.listofcontact[index]['Name']}"[0],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 123) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => addcontact(
                                        name: splash.listofcontact[index]
                                            ['Name'],
                                        contact: splash.listofcontact[index]
                                            ['Number'],
                                        id: splash.listofcontact[index]['id']),
                                  ));
                            } else if (value == 1234) {
                              Mydatabase()
                                  .deleteContact(
                                      splash.listofcontact[index]['id'],
                                      splash.db!)
                                  .then((value) => mycontact());
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 123, child: Text('Update')),
                            PopupMenuItem(value: 1234, child: Text('Delete')),
                          ],
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${splash.listofcontact[index]['Name']}"),
                            Text("${splash.listofcontact[index]['Number']}")
                          ],
                        )),
                  );
                },
              ),
      ),
      floatingActionButton: IconButton(
        padding: EdgeInsets.all(20),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return addcontact();
            },
          ));
        },
        icon: Icon(Icons.add_circle, size: 50, color: Color(0xff9B31F5)),
      ),
    );
  }

  void mycontact() {
    Mydatabase().selectcontact(splash.user!, splash.db!).then((value) {
      print("${splash.user}");

      setState(() {
        splash.listofcontact = value;
      });
    });
  }
}
