import 'dart:io';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_size_getter/image_size_getter.dart' as isg;
import 'package:image/image.dart' as img;
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
  File imgCropped;
  Future<File> cropImage(int height, int width) async {
    File convert = File(widget.image.path);
    var dim = isg.ImageSizeGetter.getSize(FileInput(convert));
    var high = dim.height;
    var wide = dim.width;
    int x = ((wide / 2) - (width / 2)).round();
    int y = ((high / 2) - (height / 2)).round();
    File croppedFile = await FlutterNativeImage.cropImage(
        widget.image.path, x, y, width, height);
    return croppedFile;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cropImage(395, 395).then((value) {
      setState(() {
        imgCropped = value;
      });
    });
  }

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
            child: imgCropped != null
                ? Image.file(File(imgCropped.path))
                : Text("It's null..."),
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
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
