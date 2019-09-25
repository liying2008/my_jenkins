import 'package:flutter/material.dart';
import 'package:flutter_jenkins_client/model/job.dart';
import 'package:my_jenkins/common/widget/status_icon.dart';
import 'package:my_jenkins/global/event/event_bus.dart';
import 'package:my_jenkins/global/tool/jenkins_client.dart';
import 'package:my_jenkins/global/tool/logger.dart';
import 'package:my_jenkins/job/job_details_page.dart';
import 'package:my_jenkins/view/event/view_event.dart';

class JobsListWidget extends StatefulWidget {
  final String folder;
  final String view;

  JobsListWidget({Key key, this.folder, this.view}) : super(key: key);

  @override
  _JobsListWidgetState createState() => _JobsListWidgetState();
}

class _JobsListWidgetState extends State<JobsListWidget> {
  var _jobs = <Job>[];

  _JobsListWidgetState() {
    eventBus.on<SelectViewEvent>().listen((event) {
      setState(() {
        _jobs.clear();
      });
      _getJobs(widget.folder, event.view.name);
    });
  }

  @override
  void initState() {
    _getJobs(widget.folder, widget.view);
    super.initState();
  }

  void _getJobs(String folder, String view) {
    logger.i('_JobsListWidgetState#_getJobs(), folder=$folder, view=$view');
    jenkinsClient.getJobs(view: view).then((jobs) {
      logger.i('_JobsListWidgetState#_getJobs()#jobs: $jobs');
      setState(() {
        jobs.forEach((name, job) {
          _jobs.add(job);
        });
      });
    }, onError: (e) {
      logger.i('_JobsListWidgetState#_getJobs()#e: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: _jobs.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(_jobs[index].name),
                leading: StatusIcon(
                  ldClass: _jobs[index].ldClass,
                  color: _jobs[index].color,
                ),
                subtitle: Text(_jobs[index].fullName ?? ''),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return JobDetailsPage(job: _jobs[index]);
                  }));
                }),
          );
        },
      ),
    );
  }
}
