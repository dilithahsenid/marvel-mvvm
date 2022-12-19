import 'package:marvel_mvvm/data/network/base_service.dart';
import 'package:marvel_mvvm/data/response/api_response.dart';
import 'package:marvel_mvvm/data/response/status_code.dart';
import 'package:marvel_mvvm/util/common_utils.dart';

class ComicService extends BaseService {
  Future<ApiResponse> getComicsList(Map<String, dynamic> params) async {
    String url = '/comics';
    try {
      var result = await executeGet(true, url, {}, params);
      return result;
    } catch (e) {
      return ApiResponse(statusCode: StatusCode.i5000);
    }
  }
}
