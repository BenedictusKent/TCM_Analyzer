import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:tcm_analyzer/classes.dart';

// Result page
class ResultPage extends StatefulWidget {
  final List responseData;
  final Uint8List decodedImgBytes;
  ResultPage({
    Key key,
    @required this.responseData,
    @required this.decodedImgBytes,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isResultNull = false;
  @override
  Widget build(BuildContext context) {
    if (widget.responseData.length == 0) {
      isResultNull = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediction Result"),
        backgroundColor: Color(0xFE2B3F87),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              while (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // show bounded image
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.memory(
                widget.decodedImgBytes,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            // show list of predicted herbs
            isResultNull
                ? Center(
                    child: Text(
                      "Sorry, no herb predicted.",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.responseData.length,
                    itemBuilder: (context, index) {
                      final item = herbClass[widget.responseData[index]];
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/info',
                                arguments: item["engName"]);
                          },
                          child: Container(
                              height: 130,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withAlpha(100),
                                        blurRadius: 10.0),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(item["thumbnail"],
                                        height: 100, width: 100),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10)),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item["engName"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          item["cnName"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              )));
                    },
                  )
          ],
        ),
      ),
    );
  }
}

// function to pass multiple arguments from one page to this page
class ScreenArguments {
  final List resData;
  final Uint8List nameData;
  ScreenArguments(this.resData, this.nameData);
}
