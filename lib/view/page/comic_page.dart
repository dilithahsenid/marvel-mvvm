import 'package:flutter/material.dart';
import 'package:marvel_mvvm/view/widget/comic_item.dart';
import 'package:marvel_mvvm/view_model/comic_view_model.dart';
import 'package:provider/provider.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ComicPageState();
  }
}

class _ComicPageState extends State<ComicPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 100) {
        Provider.of<ComicViewModel>(context, listen: false).getComics();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marvel Comics"),
      ),
      body: Consumer<ComicViewModel>(
        builder: (context, value, child) {
          if (value.isLoading && value.comics.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.comics.isNotEmpty) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2 / 3),
                      itemCount: value.comics.length,
                      itemBuilder: (context, index) {
                        return ComicItem(comic: value.comics[index]);
                      }),
                  value.isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [CircularProgressIndicator()],
                        )
                      : Container()
                ],
              ),
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
