import 'package:marvel_mvvm/model/image_obj.dart';

class Character {
  int? id;
  String? name;
  String? description;
  ImageObj? thumbnail;

  Character({this.id, this.name, this.thumbnail, this.description});

  Character.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    thumbnail = ImageObj.fromJson(json["thumbnail"]);
    description = json["description"];
  }
}
