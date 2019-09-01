import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/model/job.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;

  JobDetailsPage({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.name),
      ),
      body: Text(job.url),
    );
  }
}
