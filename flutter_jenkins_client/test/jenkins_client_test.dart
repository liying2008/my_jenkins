import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_jenkins_client/jenkins_client.dart';

import 'constants.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });

  test('get all views', () async {
    final jenkinsClient = JenkinsClient(JENKINS_URL, USERNAME, PASSWORD);
    var views = await jenkinsClient.getViews();
    print(views);
  });
}
