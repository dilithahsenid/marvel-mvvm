import 'package:flutter/material.dart';
import 'package:marvel_mvvm/model/comic.dart';
import 'package:marvel_mvvm/repository/comic_repository.dart';

class ComicViewModel extends ChangeNotifier {
  final ComicRepository _comicRepository = ComicRepository();
  final List<Comic> _comics = [];
  bool isLoading = false;

  ComicViewModel() {
    getComics();
  }

  List<Comic> get comics => _comics;

  getComics() async {
    if (!isLoading) {
      notifyLoading(true);
      var comics =
          await _comicRepository.getComics(limit: 20, offset: _comics.length);
      _comics.addAll(comics);
      notifyLoading(false);
    }
  }

  notifyLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }
}
