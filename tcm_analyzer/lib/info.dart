import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  // pass in arguments
  final String data;
  InfoPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info page"),
      ),
      body: Center(
        child: Text(widget.data),
      ),
    );
  }
}
