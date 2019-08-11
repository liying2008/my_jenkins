import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_jenkins_client/common/util/endecode.dart';
import 'package:flutter_jenkins_client/jenkins_client.dart';

class HttpClient {
  static BaseOptions _getBaseOptions(JenkinsClient jenkinsClient, {contentType}) {
    if (contentType == null) {
      contentType = ContentType.json;
    }
    return BaseOptions(
      baseUrl: jenkinsClient.url,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      // 5s
      headers: {
        HttpHeaders.authorizationHeader: EnDecode.encodeBasicAuthToken(
            jenkinsClient.username, jenkinsClient.password),
      },
      contentType: contentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.plain,
    );
  }

  static Future<Response> get(JenkinsClient jenkinsClient, String path,
      Map<String, String> params) async {
    var dio = Dio(_getBaseOptions(jenkinsClient));

    Response<String> response;

    response = await dio.get(path, queryParameters: params);
    return response;
  }
}
