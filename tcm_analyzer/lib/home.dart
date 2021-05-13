import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:tcm_analyzer/classes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // declaration
  final myController = TextEditingController();
  List<String> names = ["寧夏枸杞", "熟地黃", "黨參", "甘草", "懷牛膝", "麥門冬"];
  XFile image;
  AnimationController animationController;
  Animation translation;
  Animation rotation;
  Animation otherrotation;

  // functions
  double getRadians(double degree) {
    double radian = 57.2958;
    return degree / radian;
  }

  Future pickImage(ImageSource imageSource) async {
    PickedFile img = await ImagePicker().getImage(source: imageSource);
    if (img != null) {
      image = XFile(img.path);
      Navigator.pushNamed(context, '/view', arguments: image);
    }
  }


  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    translation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    otherrotation = Tween<double>(begin: 0.0, end: 225.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UnicornButton> childButtons = [];

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Camera",
        currentButton: FloatingActionButton(
          heroTag: "Camera",
          backgroundColor: Colors.red,
          mini: true,
          child: Icon(Icons.add_a_photo_rounded),
          onPressed: () {
            Navigator.pushNamed(context, '/camera');
          },
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Gallery",
        currentButton: FloatingActionButton(
          heroTag: "Gallery",
          backgroundColor: Colors.orange,
          mini: true,
          child: Icon(Icons.add_photo_alternate),
          onPressed: () {
            pickImage(ImageSource.gallery);
          },
        )));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          // app bar
          Container(
            height: 160.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFE2B3F87),
            child: Column(children: <Widget>[
              // title
              Container(
                  padding: EdgeInsets.fromLTRB(10, 50, 180, 20),
                  child: Text(
                    "TCM Analyzer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontFamily: 'Abyssinica'),
                  )),
              // search bar
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xFFEDEDED),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Material(
                      color: Color(0xFFEDEDED),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          Expanded(
                              child: TextField(
                            controller: myController,
                            decoration:
                                InputDecoration.collapsed(hintText: "search"),
                            onSubmitted: (value) {
                              if (value != "") {
                                names.removeAt(5);
                                names.insert(0, myController.text);
                              }
                              myController.clear();
                              Navigator.pushNamed(context, '/info',
                                  arguments: names[0]);
                            },
                          ))
                        ],
                      ),
                    )),
              )
            ]),
          ),

          Expanded(
            flex: 1,
            child: PageView(children: <Widget>[
              Container(
                  child: Stack(
                children: <Widget>[
                  // "Recent"
                  Container(
                    margin: EdgeInsets.only(top: 15.0, left: 15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Recent",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Abyssinica',
                      ),
                    ),
                  ),

                  // Recent searches (first)
                  Container(
                    margin: EdgeInsets.only(top: 50.0, left: 10.0),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/info',
                            arguments: names[0]);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(names[0],
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 18.0,
                                fontFamily: 'Abyssinica')),
                      ),
                    ),
                  ),

                  // Recent searches (second to end)
                  Container(
                    height: 200.0,
                    margin: EdgeInsets.only(top: 90.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        for (int i = 1; i < 6; ++i)
                          Container(
                              margin: EdgeInsets.only(left: 10.0),
                              height: 39.0,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/info',
                                      arguments: names[i]);
                                },
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(names[i],
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 18.0,
                                            fontFamily: 'Abyssinica'))),
                              ))
                      ],
                    ),
                  ),
                ],
              )),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: herbClass.length,
                      itemBuilder: (context, index) {
                        final item = herbClass[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/info',
                            arguments: item["engName"]);
                          },
                          child: Container(
                          height: 120,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset(
                                  item["thumbnail"],
                                  height: 100,
                                  width: 100
                                ),
                                Padding(
                                padding: const EdgeInsets.only(
                                  left: 10
                                )
                                ),
                                Expanded(
                                 child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item["engName"],
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      item["cnName"],
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                                ),
                              ],
                            ),
                          )
                        )
                        );
                      },
                    )
                ]),
              ),
              Container(color: Colors.blue),
            ]),
          ),
        ]),
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0),
            parentButtonBackground: Colors.blue[900],
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: childButtons));
  }
}

class CircularButton extends StatelessWidget {
  // declare variables
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(this.color, this.width, this.height, this.icon, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onClick,
      ),
    );
  }
}
