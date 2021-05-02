import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TCM Analyzer"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Press Me"),
          onPressed: () {
            Navigator.pushNamed(context, '/info', arguments: "From home page");
          },
        ),
      ),
    );
  }
}
