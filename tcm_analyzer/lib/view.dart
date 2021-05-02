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
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Image.file(File(widget.image.path)),
          )
        ],
      ),
    );
  }
}
