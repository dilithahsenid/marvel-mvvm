import 'package:marvel_mvvm/model/image_size.dart';

class ImageObj {
  String? path;
  String? extension;

  ImageObj({this.path, this.extension});

  ImageObj.fromJson(Map<String, dynamic> json) {
    path = json["path"];
    extension = json["extension"];
  }

  getImageUrl(ImageSize imageSize) {
    return '$path/${imageSize.toString().split(".").last}.$extension';
  }
}
