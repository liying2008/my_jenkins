import 'package:flutter_jenkins_client/model/jenkins_object.dart';

class Artifact extends JenkinsObject {
  final String displayPath;
  final String fileName;
  final String relativePath;

  Artifact({String ldClass, this.displayPath, this.fileName, this.relativePath})
      : super(ldClass: ldClass);

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      ldClass: json['_class'],
      displayPath: json['displayPath'],
      fileName: json['fileName'],
      relativePath: json['relativePath'],
    );
  }

  @override
  String toString() {
    return 'Artifact{displayPath: $displayPath, fileName: $fileName, relativePath: $relativePath}';
  }
}
