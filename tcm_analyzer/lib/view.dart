import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  final XFile image;
  ViewPage({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Page"),
        backgroundColor: Color(0xFE2B3F87),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height * 2 / 3,
            width: MediaQuery.of(context).size.width,
            child: Image.file(File(widget.image.path)),
          ),
          Padding(
            padding: EdgeInsets.all(40),
            child: ElevatedButton(
              child: Text(
                "Click to Predict",
                style: TextStyle(fontSize: 20.0, fontFamily: 'Abyssinica'),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFE2B3F87), minimumSize: Size(300, 50)),
              onPressed: () {
                print("success");
              },
            ),
          )
        ],
      ),
    );
  }
}
