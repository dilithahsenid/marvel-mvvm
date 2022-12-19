import 'package:flutter/material.dart';
import 'package:marvel_mvvm/model/character.dart';
import 'package:marvel_mvvm/model/image_size.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30) / 2,
      height: (MediaQuery.of(context).size.width - 30) / 2 * 1.5,
      child: Column(
        children: [
          Image.network(
              character.thumbnail?.getImageUrl(ImageSize.portrait_xlarge)),
          Text(character.name!)
        ],
      ),
    );
  }
}
