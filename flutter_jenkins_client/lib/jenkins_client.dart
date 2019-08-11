library flutter_jenkins_client;

import 'dart:convert';

import 'package:flutter_jenkins_client/common/errors.dart';
import 'package:flutter_jenkins_client/common/http/http_client.dart';
import 'package:flutter_jenkins_client/view.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class JenkinsClient {
  final String url;
  final String username;
  final String password;

  JenkinsClient(this.url, this.username, this.password);

  Future<Map<String, View>> getViews() async {
    var map = Map<String, View>();
    var params = {'tree': 'views[name,url]'};
    var resp = await HttpClient.get(this, '/api/json', params);
    if (resp.statusCode != 200) {
      throw FetchDataFailedError("get views failed!");
    }
    var data = json.decode(resp.data);
    var views = data['views'];
    views.forEach((viewJson){
      var view = View.fromJson(viewJson);
      map[view.name] = view;
    });
    return map;
  }

  View getView(String name) {
    return View();
  }
}
