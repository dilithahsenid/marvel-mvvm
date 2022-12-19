import 'dart:convert';

import 'package:marvel_mvvm/model/image_obj.dart';

class Comic {
  int? id;
  String? title;
  ImageObj? thumbnail;
  List<ImageObj>? images;

  Comic({this.id, this.title, this.thumbnail, this.images});

  Comic.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    thumbnail = ImageObj.fromJson(json["thumbnail"]);
    images = (json["images"] as List).map((e) => ImageObj.fromJson(e)).toList();
  }
}
