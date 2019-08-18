import 'package:flutter_jenkins_client/jenkins_object.dart';

class View extends JenkinsObject {
  final String name;
  final String url;
  final String description;

  View({String ldClass, this.name, this.url, this.description})
      : super(ldClass);

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      ldClass: json['_class'],
      name: json['name'],
      url: json['url'],
      description: json['description'],
    );
  }

  @override
  String toString() {
    return 'View{_class: $ldClass, name: $name, url: $url, description: $description}';
  }
}
