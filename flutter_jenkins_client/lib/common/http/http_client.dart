import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_jenkins_client/common/util/endecode.dart';
import 'package:flutter_jenkins_client/jenkins_client.dart';

class HttpClient {
  static BaseOptions _getBaseOptions(JenkinsClient jenkinsClient,
      {contentType}) {
    if (contentType == null) {
      contentType = ContentType.json;
    }
    return BaseOptions(
      baseUrl: jenkinsClient.url,
//      connectTimeout: 5000,
//      receiveTimeout: 10000,
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

  static Future<Response<String>> get(
      JenkinsClient jenkinsClient, String path, Map<String, String> params) {
    print('path = $path, params = $params');
    var dio = Dio(_getBaseOptions(jenkinsClient));

    return dio.get(path, queryParameters: params);
  }
}
