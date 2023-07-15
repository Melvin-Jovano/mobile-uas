import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
  String _unit = "°C";
  List<Map> _locations = [];
  List<Map> _favouriteLocations = [];
  Map _selectedLocation = {};

  String get unit => _unit;
  List<Map> get locations => _locations;
  List<Map> get favouriteLocations => _favouriteLocations;
  Map get selectedLocation => _selectedLocation;

  set setFavouriteLocations(val) {
    _favouriteLocations = val;
    notifyListeners();
  }

  set setUnit(val){
    _unit = val;
    notifyListeners();
  }

  set setLocations(val) {
    _locations = val;
    notifyListeners();
  }

  set setSelectedLocation(val) {
    _selectedLocation = val;
    notifyListeners();
  }
}