import 'package:flutter_jenkins_client/jenkins_object.dart';

class View extends JenkinsObject {
  final String name;
  final String url;

  View({String ldClass, this.name, this.url}) : super(ldClass);

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      ldClass: json['_class'],
      name: json['name'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'View{_class: $ldClass, name: $name, url: $url}';
  }
}
