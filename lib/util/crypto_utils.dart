import 'dart:convert';

import 'package:crypto/crypto.dart';

class CryptoUtil {
  static String generateMd5Hash(String value) {
    var bytes = utf8.encode(value);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}
