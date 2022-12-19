import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

class CommonUtils {
  static void log(String message) {
    if (!kReleaseMode) {
      dev.log(message);
    }
  }
}
