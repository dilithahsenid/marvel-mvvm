import 'package:marvel_mvvm/data/network/base_service.dart';
import 'package:marvel_mvvm/data/response/api_response.dart';
import 'package:marvel_mvvm/data/response/status_code.dart';

class CharacterService extends BaseService {
  Future<ApiResponse> getCharacterList(Map<String, dynamic> params) async {
    String url = '/characters';
    try {
      var result = await executeGet(true, url, {}, params);
      return result;
    } catch (e) {
      return ApiResponse(statusCode: StatusCode.i5000);
    }
  }
}
