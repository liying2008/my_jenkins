import 'package:flutter_jenkins_client/model/job.dart';

class JobDetails extends Job {
  final String description;
  final String displayName;
  final String fullDisplayName;
  final bool buildable;

//  final List<Build> builds = [];
//
//  final Build firstBuild;
//
//  final Build lastBuild;
//
//  final Build lastCompletedBuild;
//
//  final Build lastFailedBuild;
//
//  final Build lastStableBuild;
//
//  final Build lastSuccessfulBuild;
//
//  final Build lastUnstableBuild;
//
//  final Build lastUnsuccessfulBuild;

  final bool inQueue;
  final bool keepDependencies;
  final int nextBuildNumber;
  final bool concurrentBuild;

//
//  final QueueItem queueItem;
//
//  final List<Job> downstreamProjects;
//
//  final List<Job> upstreamProjects;

  JobDetails(
      {String ldClass,
      String fullName,
      String name,
      String url,
      String color,
      this.description,
      this.displayName,
      this.fullDisplayName,
      this.buildable,
      this.inQueue,
      this.keepDependencies,
      this.nextBuildNumber,
      this.concurrentBuild})
      : super(
            ldClass: ldClass,
            name: name,
            url: url,
            fullName: fullName,
            color: color);

  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
      ldClass: json['_class'],
      description: json['description'],
      displayName: json['displayName'],
      fullDisplayName: json['fullDisplayName'],
      fullName: json['fullName'],
      name: json['name'],
      url: json['url'],
      buildable: json['buildable'],
      color: json['color'],
      inQueue: json['inQueue'],
      keepDependencies: json['keepDependencies'],
      nextBuildNumber: json['nextBuildNumber'],
      concurrentBuild: json['concurrentBuild'],
    );
  }

  @override
  String toString() {
    return 'JobDetails{description: $description, displayName: $displayName, fullDisplayName: $fullDisplayName, buildable: $buildable, inQueue: $inQueue, keepDependencies: $keepDependencies, nextBuildNumber: $nextBuildNumber, concurrentBuild: $concurrentBuild}';
  }
}
