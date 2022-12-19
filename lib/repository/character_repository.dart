import 'package:marvel_mvvm/data/network/character_service.dart';
import 'package:marvel_mvvm/data/response/status_code.dart';
import 'package:marvel_mvvm/model/character.dart';

class CharacterRepository {
  final CharacterService _characterService = CharacterService();

  Future<List<Character>> getCharacters({int? limit, int? offset}) async {
    Map<String, dynamic> params = {"limit": limit, "offset": offset};
    var apiResponse = await _characterService.getCharacterList(params);
    if (apiResponse.statusCode == StatusCode.s0000) {
      var characters = (apiResponse.payload["data"]["results"] as List)
          .map((e) => Character.fromJson(e))
          .toList();
      return characters;
    } else {
      return [];
    }
  }
}
