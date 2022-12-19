import 'package:flutter/material.dart';
import 'package:marvel_mvvm/view/page/character_page.dart';
import 'package:marvel_mvvm/view/page/comic_page.dart';
import 'package:marvel_mvvm/view/page/not_found_page.dart';
import 'package:marvel_mvvm/view/widget/common_bottom_navigation.dart';
import 'package:marvel_mvvm/view_model/bottom_navigation_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late int selectedCategory;

  @override
  void initState() {
    selectedCategory = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNavigation(),
      body: Consumer<BottomNavigationViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.selectedIndex) {
            case 0:
              return ComicPage();
            case 1:
              return CharacterPage();
            default:
              return NotFoundPage();
          }
        },
      ),
    );
  }
}
