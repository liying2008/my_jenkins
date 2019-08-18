import 'package:flutter_jenkins_client/jenkins_object.dart';

class Job extends JenkinsObject {
  final String name;
  final String url;
  final String fullName;
  final String color;

  Job({String ldClass, this.name, this.url, this.fullName, this.color})
      : super(ldClass);

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      ldClass: json['_class'],
      name: json['name'],
      url: json['url'],
      fullName: json['fullName'],
      color: json['color'],
    );
  }

  @override
  String toString() {
    return 'Job{_class: $ldClass, name: $name, url: $url, fullName: $fullName, color: $color}';
  }
}
