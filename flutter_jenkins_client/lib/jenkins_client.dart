library flutter_jenkins_client;

import 'dart:convert';

import 'package:flutter_jenkins_client/common/errors.dart';
import 'package:flutter_jenkins_client/common/http/http_client.dart';
import 'package:flutter_jenkins_client/model/job.dart';
import 'package:flutter_jenkins_client/model/job_details.dart';
import 'package:flutter_jenkins_client/model/view.dart';

class JenkinsClient {
  final String url;
  final String username;
  final String password;

  JenkinsClient(this.url, this.username, this.password);

  Future<Map<String, View>> getViews() async {
    print('jenkins_client#getViews()');
    var map = Map<String, View>();
    var params = {'tree': 'views[name,url,description]'};
    var resp = await HttpClient.get(this, '/api/json', params);
    if (resp.statusCode != 200) {
      throw FetchDataFailedError("get views failed!");
    }
    var data = json.decode(resp.data);
    var views = data['views'];
    views.forEach((viewJson) {
      var view = View.fromJson(viewJson);
      map[view.name] = view;
    });
    return map;
  }

  Future<View> getView(String name) async {
    print('jenkins_client#getView()');
    var params = {'tree': 'name,url,description'};
    var resp = await HttpClient.get(this, '/view/$name/api/json', params);
    if (resp.statusCode != 200) {
      throw FetchDataFailedError("get view $name failed!");
    }
    var data = json.decode(resp.data);
    return View.fromJson(data);
  }

  Future<Map<String, Job>> getJobs({String folder, String view}) async {
    String path = '';
    if (folder != null && folder.isNotEmpty) {
      path += '/job/$folder';
    }
    if (view != null && view.isNotEmpty) {
      path += '/view/$view';
    }
    path = path + '/api/json';
    var map = Map<String, Job>();
    var params = {'tree': 'jobs[name,url,fullName,color]'};
    var resp = await HttpClient.get(this, path, params);
    if (resp.statusCode != 200) {
      throw FetchDataFailedError("get jobs failed!");
    }
    var data = json.decode(resp.data);
    var jobs = data['jobs'];
    jobs.forEach((jobJson) {
      var job = Job.fromJson(jobJson);
      map[job.name] = job;
    });
    return map;
  }

  Future<JobDetails> getJob(String name) async {
    print('jenkins_client#getJob()');
    var params = {'tree': '*'};
    var resp = await HttpClient.get(this, '/job/$name/api/json', params);
    if (resp.statusCode != 200) {
      throw FetchDataFailedError("get job $name failed!");
    }
    var data = json.decode(resp.data);
    return JobDetails.fromJson(data);
  }
}
