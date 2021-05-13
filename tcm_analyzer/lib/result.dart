import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List responseData;
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
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.responseData.length,
            itemBuilder: (context, index) {
              final item = widget.responseData[index];
              return ListTile(
                title: Text(item),
              );
            },
          )
        ],
      ),
    );
  }
}
