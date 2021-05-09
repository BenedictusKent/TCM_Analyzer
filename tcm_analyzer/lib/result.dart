import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_size_getter/image_size_getter.dart' as isg;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class ResultPage extends StatefulWidget {
  final Map<String, dynamic> responseData;
  ResultPage({
    Key key,
    @required this.responseData,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediction Result"),
        backgroundColor: Color(0xFE2B3F87),
      ),
      
    );
  }
}
