import 'package:flutter_jenkins_client/model/jenkins_object.dart';

class Build extends JenkinsObject {
  final int number;
  final int queueId;
  final String url;

  Build({String ldClass, this.number, this.queueId, this.url})
      : super(ldClass: ldClass);

  factory Build.fromJson(Map<String, dynamic> json) {
    return Build(
      ldClass: json['_class'],
      number: json['number'],
      queueId: json['queueId'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'Build{number: $number, queueId: $queueId, url: $url}';
  }
}
