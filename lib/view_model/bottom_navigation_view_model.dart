import 'package:flutter/cupertino.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int newSelectedIndex) {
    if (newSelectedIndex != _selectedIndex) {
      _selectedIndex = newSelectedIndex;
      notifyListeners();
    }
  }
}
