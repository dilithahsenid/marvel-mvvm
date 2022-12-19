import 'package:flutter/material.dart';
import 'package:marvel_mvvm/view_model/bottom_navigation_view_model.dart';
import 'package:provider/provider.dart';

class CommonBottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommonBottomNavigationState();
  }
}

class _CommonBottomNavigationState extends State<CommonBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationViewModel>(
        builder: (context, viewModel, child) {
      return BottomNavigationBar(
        currentIndex: viewModel.selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Comics'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Characters')
        ],
        onTap: (value) {
          viewModel.setSelectedIndex(value);
        },
      );
    });
  }
}
