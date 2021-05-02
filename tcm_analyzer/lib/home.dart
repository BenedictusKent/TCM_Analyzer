import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // declaration
  final myController = TextEditingController();
  List<String> names = ["寧夏枸杞", "熟地黃", "黨參", "甘草", "懷牛膝", "麥門冬"];
  AnimationController animationController;
  Animation translation;
  Animation rotation;
  Animation otherrotation;

  double getRadians(double degree) {
    double radian = 57.2958;
    return degree / radian;
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          // app bar
          Container(
            height: 180.0,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFE2B3F87),
            child: Column(children: <Widget>[
              // title
              Container(
                  padding: EdgeInsets.fromLTRB(0, 80, 190, 10),
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
                          ))
                        ],
                      ),
                    )),
              )
            ]),
          ),

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
            margin: EdgeInsets.only(top: 10.0, left: 10.0),
            height: 38.0,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/info', arguments: names[0]);
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
            height: 190.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                for (int i = 1; i < 6; ++i)
                  Container(
                      margin: EdgeInsets.only(left: 10.0),
                      height: 38.0,
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
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 18.0,
                                    fontFamily: 'Abyssinica'))),
                      ))
              ],
            ),
          ),

          // Custom FAB
          Container(
            height: MediaQuery.of(context).size.height - 488,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 20.0,
                  bottom: 10.0,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      // tap box
                      IgnorePointer(
                        child: Container(
                          color: Colors.transparent,
                          height: 160.0,
                          width: 170.0,
                        ),
                      ),

                      // add image from camera
                      Transform.translate(
                        offset: Offset.fromDirection(
                            getRadians(270), translation.value * 90),
                        child: Transform(
                          transform:
                              Matrix4.rotationZ(getRadians(rotation.value))
                                ..scale(translation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                              Colors.red,
                              60,
                              50,
                              Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                              ),
                              () {}),
                        ),
                      ),

                      // add image from gallery
                      Transform.translate(
                        offset: Offset.fromDirection(
                            getRadians(180), translation.value * 90),
                        child: Transform(
                          transform:
                              Matrix4.rotationZ(getRadians(rotation.value))
                                ..scale(translation.value),
                          alignment: Alignment.center,
                          child: CircularButton(
                              Colors.orange,
                              60,
                              50,
                              Icon(
                                Icons.add_photo_alternate,
                                color: Colors.white,
                              ),
                              () {}),
                        ),
                      ),

                      // plus icon button
                      Transform(
                        transform:
                            Matrix4.rotationZ(getRadians(otherrotation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                            Color(0xFE2B3F87),
                            60,
                            50,
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ), () {
                          if (animationController.isCompleted)
                            animationController.reverse();
                          else
                            animationController.forward();
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
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
