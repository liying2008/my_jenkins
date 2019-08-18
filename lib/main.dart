import 'package:flutter/material.dart';
import 'package:my_jenkins/view/views_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyJenkins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewsPage(title: 'Jenkins Views'),
    );
  }
}
