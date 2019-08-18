import 'package:flutter_jenkins_client/jenkins_client.dart';
import 'package:my_jenkins/global/constant/constants.dart';

final JenkinsClient jenkinsClient =
    JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
