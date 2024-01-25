import 'package:flutter/material.dart';
import 'package:lay_out_index/variable/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lay_out_index/variable/other.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TileColor colorsss = TileColor();
  List<dynamic> users = [];

  @override
  void initState() {
    dataShow();
  }

  void indicator() async {
    showDialog(
        context: context,
        builder: ((context) {
          return const Center(child: CircularProgressIndicator());
        }));
  }

  @override
  Future<void> dataShow() async {
    try {
      const url = 'https://reqres.in/api/users?page=2';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      final body = response.body;
      final json = jsonDecode(body);
      if (response.statusCode == 200) {
        setState(() {
          users = json['data'];
        });
      }
    } catch (e) {
      print("ramessh");
      indicator();
    }
  }

  HomeColor colorss = HomeColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorsss.backgroundColor,
        appBar: AppBar(
          title: Text(
            "User Information",
            style: TextStyle(color: colorss.appbarText),
          ),
          backgroundColor: colorss.appbar,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: search(),
            ),
            Expanded(flex: 1, child: textt()),
            Expanded(flex: 10, child: list())
          ],
        ));
  }

  //show the list using this widget
  Widget list() {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.transparent,
          );
        },
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final fName = user['first_name'];
          final id = user['id'];
          final lName = user['last_name'];
          final profilePic = user['avatar'];
          final email = user['email'];

          return Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(148, 158, 158, 158), // Shadow color
                  blurRadius: 5.0, // Spread of the shadow
                  offset: Offset(0, 2), // Offset of the shadow
                ),
              ],
            ),
            child: ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return the AlertDialog
                      return AlertDialog(
                        actionsPadding: EdgeInsets.only(
                            left: screenwidth * 0.02,
                            right: screenwidth * 0.01,
                            top: screenwidth * 0.02,
                            bottom: screenwidth * 0.04),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(profilePic),
                                  backgroundColor: Colors.transparent,
                                  radius: 50,
                                  child: ClipOval(
                                    child: Image.network(
                                      profilePic,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 250,
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                    text: "First Name         ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                                TextSpan(
                                                    text: fName,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                    text: "Second Name    ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                                TextSpan(
                                                    text: lName,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        width: 1000,
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "Email                   ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                                TextSpan(
                                                    text: email,
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorss.appbar,
                                  foregroundColor: colorss
                                      .appbarText, // Change the button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(
                                            20)), // Make it square
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Center(
                                  child: Text('Close'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                //title for id
                title: RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "ID              ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: id.toString(),
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ],
                )),

                //substile for name
                subtitle: RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Name       ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: fName,
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ],
                ))),
          );
        });
  }

  Widget search() {
    return Container(
      color: colorsss.tile,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 20,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: colorsss.backgroundColor,
                    contentPadding: EdgeInsets.only(left: 20),
                    hintText: "User Id",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none)),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 7,
              child: Container(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorss.appbar,
                    foregroundColor:
                        colorss.appbarText, // Change the button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20)), // Make it square
                    ),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Center(
                    child: Text('Search'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textt() {
    var screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: screenwidth,
        alignment: Alignment.centerLeft,
        child: Text(
          "AVELABLE USER",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
