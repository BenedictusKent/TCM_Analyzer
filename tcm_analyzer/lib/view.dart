import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_size_getter/image_size_getter.dart' as isg;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:tcm_analyzer/result.dart';

bool isPressed = false;
bool isCropped = false;

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
    int x, y;
    if (wide != 0)
      x = ((wide / 2) - (width / 2)).round();
    else
      x = 500;
    if (high != 0)
      y = ((high / 2) - (height / 2)).round();
    else
      y = 500;
    File croppedFile = await FlutterNativeImage.cropImage(
        widget.image.path, x, y, width, height);
    return croppedFile;
  }

  Future doUpload(context) async {
    // open a bytestream
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://2d5da958d1b3.ngrok.io/api/predict'),
    );
    final mimeTypeData =
        lookupMimeType(widget.image.path, headerBytes: [0xFF, 0xD8]).split('/');
    String imageName = basename(widget.image.path).split('.')[0];
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        File(imgCropped.path).readAsBytesSync(),
        filename: imageName,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      ),
    );
    request.headers.addAll(headers);
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final List responseData = json.decode(response.body)['class'];
      print(json.decode(response.body)['class']);
      final decodedImgBytes = base64Decode(json.decode(response.body)['image']);
      Navigator.pushNamed(context, '/result',
          arguments: ScreenArguments(responseData, decodedImgBytes));
      setState(() => isPressed = false);
    } catch (e) {
      print(e);
      return null;
    }
  }

  void recropImage() async {
    File image = File(widget.image.path);
    File cropped = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      maxHeight: 500,
      maxWidth: 500,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Color(0xFE2B3F87),
        toolbarTitle: "Recrop Image",
        statusBarColor: Color(0xFE2B3F87),
        backgroundColor: Colors.black,
        hideBottomControls: true,
      ),
    );
    if (cropped != null) {
      setState(() {
        imgCropped = cropped;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() => isPressed = false);
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ElevatedButton(
                  child: isPressed
                      ? Text(
                          "Predicting ... ",
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: 'Abyssinica'),
                        )
                      : Text(
                          "Click to Predict",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: 'Abyssinica'),
                        ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFE2B3F87), minimumSize: Size(150, 50)),
                  onPressed: isPressed
                      ? null
                      : () => {
                            setState(() => isPressed = !isPressed),
                            doUpload(context),
                          },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 22),
                child: ElevatedButton(
                  child: Text(
                    "Recrop Image",
                    style: TextStyle(fontSize: 20.5, fontFamily: 'Abyssinica'),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFE2B3F87), minimumSize: Size(150, 50)),
                  onPressed: isPressed
                      ? null
                      : () => {
                            recropImage(),
                          },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
