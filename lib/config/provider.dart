import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
  String _unit = "°C";

  String get unit => _unit;

  set setUnit(val){
    _unit = val;
    notifyListeners();
  }
}