import 'package:flutter/material.dart';
import 'package:marvel_mvvm/model/comic.dart';
import 'package:marvel_mvvm/model/image_size.dart';

class ComicItem extends StatelessWidget {
  final Comic comic;

  const ComicItem({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      height: (MediaQuery.of(context).size.width - 30) / 2 * 1.5,
      child: Column(
        children: [
          Image.network(
              comic.thumbnail?.getImageUrl(ImageSize.portrait_xlarge)),
          Text(comic.title!)
        ],
      ),
    );
  }
}
