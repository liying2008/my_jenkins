import 'package:flutter_jenkins_client/jenkins_object.dart';

class Job extends JenkinsObject {
  final String name;
  final String url;

  Job({String ldClass, this.name, this.url}) : super(ldClass);

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      ldClass: json['_class'],
      name: json['name'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'Job{_class: $ldClass, name: $name, url: $url}';
  }
}
