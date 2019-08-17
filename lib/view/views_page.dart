import 'package:flutter/material.dart';
import 'package:my_jenkins/view/views_widget.dart';

class ViewsPage extends StatelessWidget {
  ViewsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ViewsWidget(),
    );
  }
}
