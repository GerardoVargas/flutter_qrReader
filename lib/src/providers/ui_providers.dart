import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  //getter
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt( int i) {
    _selectedMenuOpt = i;
    notifyListeners();
  }

}