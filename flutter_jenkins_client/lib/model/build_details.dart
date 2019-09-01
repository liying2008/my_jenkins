import 'package:flutter_jenkins_client/model/artifact.dart';
import 'package:flutter_jenkins_client/model/build.dart';
import 'package:flutter_jenkins_client/model/build_result.dart';

class BuildDetails extends Build {
  static const String TEXT_SIZE_HEADER = "x-text-size";
  static const String MORE_DATA_HEADER = "x-more-data";

  final bool building;
  final String description;
  final String displayName;
  final int duration;
  final int estimatedDuration;
  final String fullDisplayName;
  final String id;
  final int timestamp;
  final BuildResult result;
  final List<Artifact> artifacts;
  final String consoleOutputText;
  final String consoleOutputHtml;

//  final BuildChangeSet changeSet;
//  final List<BuildChangeSet> changeSets;
  final String builtOn;

//  final List<BuildChangeSetAuthor> culprits;

  BuildDetails(
      {String ldClass,
      int number,
      int queueId,
      String url,
      this.building,
      this.description,
      this.displayName,
      this.duration,
      this.estimatedDuration,
      this.fullDisplayName,
      this.id,
      this.timestamp,
      this.result,
      this.artifacts,
      this.consoleOutputText,
      this.consoleOutputHtml,
      this.builtOn})
      : super(ldClass: ldClass, number: number, queueId: queueId, url: url);

  factory BuildDetails.fromJson(Map<String, dynamic> json) {
    return BuildDetails(
      ldClass: json['_class'],
      number: json['number'],
      queueId: json['queueId'],
      url: json['url'],
      building: json['building'],
      description: json['description'],
      displayName: json['displayName'],
      duration: json['duration'],
      estimatedDuration: json['estimatedDuration'],
      fullDisplayName: json['fullDisplayName'],
      id: json['id'],
      timestamp: json['timestamp'],
      result: json['result'],
      artifacts: json['artifacts'],
      consoleOutputText: json['consoleOutputText'],
      consoleOutputHtml: json['consoleOutputHtml'],
      builtOn: json['builtOn'],
    );
  }
}
