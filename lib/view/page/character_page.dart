import 'package:flutter/material.dart';
import 'package:marvel_mvvm/util/common_utils.dart';
import 'package:marvel_mvvm/view/widget/character_item.dart';
import 'package:marvel_mvvm/view_model/character_view_model.dart';
import 'package:marvel_mvvm/view_model/comic_view_model.dart';
import 'package:provider/provider.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CharacterPageState();
  }
}

class _CharacterPageState extends State<CharacterPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 100) {
        Provider.of<CharacterViewModel>(context, listen: false).getCharacters();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marvel Characters"),
      ),
      body: Consumer<CharacterViewModel>(
        builder: (context, value, child) {
          if (value.isLoading && value.characters.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.characters.isNotEmpty) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(children: [
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2 / 3),
                    itemCount: value.characters.length,
                    itemBuilder: (context, index) {
                      return CharacterItem(character: value.characters[index]);
                    }),
                value.isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      )
                    : Container()
              ]),
            );
          } else {
            return const Center(
              child: Text("Error Loading Page"),
            );
          }
        },
      ),
    );
  }
}
