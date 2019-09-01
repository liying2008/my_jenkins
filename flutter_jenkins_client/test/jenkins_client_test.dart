import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_jenkins_client/jenkins_client.dart';

import 'constants.dart';

void main() {
  test('get all views', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final views = await jenkinsClient.getViews();
    print(views);
  });

  test('get view 1', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final view = await jenkinsClient.getView('view2');
    print(view);
  });

  test('get view 2', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final view = await jenkinsClient.getView('中文');
    print(view);
  });

  test('get view 3', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final view = await jenkinsClient.getView('view 1');
    print(view);
  });

  test('get jobs', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final jobs = await jenkinsClient.getJobs(view: 'view2');
    print(jobs);
  });

  test('get job 1', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    final jobDetails = await jenkinsClient.getJob('Pipeline2');
    print(jobDetails);
  });
}
