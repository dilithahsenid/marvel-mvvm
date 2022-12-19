import 'package:marvel_mvvm/data/response/status_code.dart';

class ApiResponse {
  StatusCode statusCode;
  dynamic payload;

  ApiResponse({required this.statusCode, this.payload});
}
