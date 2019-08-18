import 'package:flutter_jenkins_client/jenkins_object.dart';

class Folder extends JenkinsObject {
  final String name;

  Folder({String ldClass, this.name}) : super(ldClass);

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      ldClass: json['_class'],
      name: json['name'],
    );
  }

  @override
  String toString() {
    return 'Folder{_class: $ldClass, name: $name}';
  }
}
