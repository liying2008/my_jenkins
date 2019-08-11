import 'package:flutter_jenkins_client/common/http/http_client.dart';
import 'package:flutter_jenkins_client/jenkins_client.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../constants.dart';


void main() {
  test('send GET request', () async {
    var jenkinsClient = JenkinsClient(JENKINS_URL, "admin", "admin");
    var params = {'tree': 'views[name,url]'};
    var resp = await HttpClient.get(jenkinsClient, '/api/json', params);
    print("resp.statusCode: ${resp.statusCode}");
    print("resp.extra: ${resp.extra}");
    print("resp.data: ${resp.data}");
  });

  test('send POST request', () {});
}
