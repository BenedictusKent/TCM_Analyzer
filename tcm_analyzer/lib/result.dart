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
    );
  }
}
