import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  static const _IMAGE_PATH_PREFIX = 'assets/images/';
  final String ldClass;
  final String color;

  StatusIcon({@required this.ldClass, @required this.color});

  @override
  Widget build(BuildContext context) {
    var path = _IMAGE_PATH_PREFIX + 'help.gif';
    if (color != null && color.isNotEmpty) {
      path = _IMAGE_PATH_PREFIX + color + '.gif';
    } else if (ldClass == 'com.cloudbees.hudson.plugins.folder.Folder') {
      path = _IMAGE_PATH_PREFIX + 'folder.gif';
    } else if (ldClass ==
        'org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject') {
      path = _IMAGE_PATH_PREFIX + 'github-repo.png';
    }
    return Image.asset(
      path,
      width: 40,
      height: 40,
    );
  }
}
