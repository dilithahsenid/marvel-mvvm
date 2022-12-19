import 'dart:convert';
import 'dart:io';

import 'package:marvel_mvvm/data/response/api_response.dart';
import 'package:marvel_mvvm/data/response/status_code.dart';
import 'package:marvel_mvvm/util/common_utils.dart';
import 'package:marvel_mvvm/util/constants.dart';
import 'package:marvel_mvvm/util/crypto_utils.dart';
import 'package:http/http.dart' as http;

abstract class BaseService {
  final String baseUrl = "https://gateway.marvel.com:443/v1/public";

  Map<String, String> _generateKeyMap() {
    var nowString = DateTime.now().toIso8601String();
    return {
      "ts": nowString,
      "apiKey": Constants.marvelPublicKey,
      "hash": CryptoUtil.generateMd5Hash(
          '$nowString${Constants.marvelPrivateKey}${Constants.marvelPublicKey}')
    };
  }

  String _generateParamsString(Map<String, dynamic> params) {
    String paramString = "";
    for (var element in params.entries) {
      if (element.value != null) {
        paramString += "${element.key}=${element.value}&";
      }
    }
    return paramString.substring(0, paramString.length - 1);
  }

  Future<ApiResponse> executePost(bool isSecure, Uri url,
      Map<String, String> headers, dynamic request) async {
    try {
      if (isSecure) {
        var queryParameters = Map.fromEntries(url.queryParameters.entries);
        queryParameters.addAll(_generateKeyMap());
        url.replace(queryParameters: queryParameters);
      }
      CommonUtils.log(url.toString());
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(request),
      );
      if (response.statusCode == HttpStatus.unauthorized ||
          response.statusCode == HttpStatus.forbidden) {
        CommonUtils.log(
            "User is not authorized to access the url [$url] , response [${response.body}]");
        return Future.value(ApiResponse(statusCode: StatusCode.e4001));
      } else if (response.statusCode != HttpStatus.ok) {
        CommonUtils.log(
            "The http call was not success for the url [$url], status : [${response.statusCode}], [${response.body}]");
        throw Exception(
            "Http Call was unsuccessful with status [${response.statusCode}]");
      }
      CommonUtils.log("response received successfully ${response.statusCode}");
      ApiResponse apiResponse = ApiResponse(
          statusCode: StatusCode.s0000, payload: jsonDecode(response.body));
      return Future.value(apiResponse);
    } on Exception catch (e) {
      CommonUtils.log(
          "Error occurred while calling api with url $url, exception ${e.toString()}");
      CommonUtils.log("[NFH-ERR] response error [${e.toString()}]");
      return Future.value(ApiResponse(statusCode: StatusCode.i5000));
    }
  }

  Future<ApiResponse> executeGet(bool isSecure, String url,
      Map<String, String> headers, Map<String, dynamic> params) async {
    try {
      Uri uri;
      if (isSecure) {
        var keyMap = _generateKeyMap();
        uri = Uri.parse(
            "$baseUrl$url?ts=${keyMap['ts']}&apikey=${keyMap['apiKey']}&hash=${keyMap['hash']}&${_generateParamsString(params)}");
      } else {
        uri = Uri.parse("$baseUrl$url?${_generateParamsString(params)}");
      }
      CommonUtils.log(url.toString());
      var response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == HttpStatus.unauthorized ||
          response.statusCode == HttpStatus.forbidden) {
        CommonUtils.log("User is not authorized to access the url [$url]");
        return Future.value(ApiResponse(statusCode: StatusCode.e4001));
      } else if (response.statusCode != HttpStatus.ok) {
        CommonUtils.log(
            "The http call was not success for the url [$url], status : [${response.statusCode}], [${response.body}]");
        throw Exception(
            "Http Call was unsuccessful with status [${response.statusCode}]");
      }
      CommonUtils.log("response received successfully ${response.statusCode}");
      ApiResponse apiResponse = ApiResponse(
          statusCode: StatusCode.s0000, payload: jsonDecode(response.body));
      return Future.value(apiResponse);
    } on Exception catch (e) {
      CommonUtils.log(
          "Error occurred while calling api with url $url, exception ${e.toString()}");
      CommonUtils.log("[NFH-ERR] response error [${e.toString()}]");
      return Future.value(ApiResponse(statusCode: StatusCode.i5000));
    }
  }
}
