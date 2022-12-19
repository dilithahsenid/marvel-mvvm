import 'package:flutter/material.dart';
import 'package:marvel_mvvm/view/page/HomePage.dart';
import 'package:marvel_mvvm/view_model/bottom_navigation_view_model.dart';
import 'package:marvel_mvvm/view_model/character_view_model.dart';
import 'package:marvel_mvvm/view_model/comic_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => ComicViewModel()),
        ChangeNotifierProvider(create: (_) => CharacterViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
