import 'package:flutter/material.dart';
import 'package:tcm_analyzer/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCM Analyzer',
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
