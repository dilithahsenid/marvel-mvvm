import 'package:flutter/cupertino.dart';
import 'package:marvel_mvvm/model/character.dart';
import 'package:marvel_mvvm/repository/character_repository.dart';

class CharacterViewModel extends ChangeNotifier {
  final CharacterRepository _characterRepository = CharacterRepository();
  final List<Character> _characters = [];
  bool isLoading = false;

  CharacterViewModel() {
    getCharacters();
  }

  List<Character> get characters => _characters;

  getCharacters() async {
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
      var characters = await _characterRepository.getCharacters(
          limit: 20, offset: _characters.length);
      _characters.addAll(characters);
      isLoading = false;
      notifyListeners();
    }
  }
}
