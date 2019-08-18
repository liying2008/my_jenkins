import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/job.dart';
import 'package:my_jenkins/global/tool/jenkins_client.dart';
import 'package:my_jenkins/global/tool/logger.dart';

class JobsListWidget extends StatefulWidget {
  final String folder;
  final String view;
  final bool show;

  JobsListWidget({Key key, this.folder, this.view, this.show})
      : super(key: key);

  @override
  _JobsListWidgetState createState() =>
      _JobsListWidgetState(folder: folder, view: view, show: show);
}

class _JobsListWidgetState extends State<JobsListWidget> {
  final String folder;
  final String view;
  final bool show;
  List<Job> _jobs = [];

  _JobsListWidgetState({this.folder, this.view, this.show}) {
    if (show) {
      _getJobs(folder, view);
    }
  }

  void _getJobs(String folder, String view) async {
    logger.i('JobsListWidget#_getJobs(), folder=$folder, view=$view');
    try {
      var jobs = await jenkinsClient.getJobs(view: view);
      logger.i('JobsListWidget#_getJobs()#jobs: $jobs');
      setState(() {
        jobs.forEach((name, job) {
          _jobs.add(job);
        });
      });
    } catch (e) {
      logger.i('JobsListWidget#_getJobs()#e: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _jobs.length,
              itemBuilder: (BuildContext context, int index) {
                return new Text(_jobs[index].name);
              },
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
