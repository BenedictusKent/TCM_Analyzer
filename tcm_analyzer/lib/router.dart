import 'package:flutter/material.dart';
import 'package:tcm_analyzer/home.dart';
import 'package:tcm_analyzer/info.dart';
import 'package:tcm_analyzer/camera.dart';
import 'package:tcm_analyzer/view.dart';
import 'package:tcm_analyzer/result.dart';

// App routing and their required arguments
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/info':
        return MaterialPageRoute(builder: (_) => InfoPage(data: args));
      case '/camera':
        return MaterialPageRoute(builder: (_) => CameraScreen());
      case '/view':
        return MaterialPageRoute(builder: (_) => ViewPage(image: args));
      case '/result':
        return MaterialPageRoute(builder: (_) {
          ScreenArguments arguments = args;
          return ResultPage(
              responseData: arguments.resData,
              decodedImgBytes: arguments.nameData);
        });
      default:
        return _errorRoute();
    }
  }

  // if page not found
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ERROR"),
        ),
      );
    });
  }
}
