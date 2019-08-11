import 'dart:convert';

class EnDecode {
  /// Base64 编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  /// Base64 解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  /// Basic Auth Token 编码
  static String encodeBasicAuthToken(String username, String password) {
    return 'Basic ' + encodeBase64(username + ':' + password);
  }
}
