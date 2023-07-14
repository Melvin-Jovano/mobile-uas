import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
  String _unit = "°C";
  List<Map> _locations = [];

  String get unit => _unit;
  List<Map> get locations => _locations;

  set setUnit(val){
    _unit = val;
    notifyListeners();
  }

  set setLocations(val) {
    _locations = val;
    notifyListeners();
  }
}