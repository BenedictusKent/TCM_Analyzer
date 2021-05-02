import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // app bar
          Container(
            height: 180.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFE2B3F87),
            child: Column(children: <Widget>[
              // title
              Container(
                  padding: EdgeInsets.fromLTRB(0, 80, 190, 10),
                  child: Text(
                    "TCM Analyzer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontFamily: 'Abyssinica'),
                  )),
              // search bar
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFEDEDED),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Material(
                      color: Color(0xFFEDEDED),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          Expanded(
                              child: TextField(
                            controller: myController,
                            decoration:
                                InputDecoration.collapsed(hintText: "search"),
                          ))
                        ],
                      ),
                    )),
              )
            ]),
          ),

          // "Recent"
          Container(
            margin: EdgeInsets.only(top: 15.0, left: 15.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Recent",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontFamily: 'Abyssinica',
              ),
            ),
          )
        ],
      ),
    );
  }
}
