import 'package:marvel_mvvm/data/network/comic_service.dart';
import 'package:marvel_mvvm/data/response/status_code.dart';
import 'package:marvel_mvvm/model/comic.dart';

class ComicRepository {
  final ComicService _comicService = ComicService();

  Future<List<Comic>> getComics({int? limit, int? offset}) async {
    Map<String, dynamic> params = {"limit": limit, "offset": offset};
    var apiResponse = await _comicService.getComicsList(params);
    if (apiResponse.statusCode == StatusCode.s0000) {
      var comics = (apiResponse.payload["data"]["results"] as List)
          .map((e) => Comic.fromJson(e))
          .toList();
      return comics;
    } else {
      return [];
    }
  }
}
