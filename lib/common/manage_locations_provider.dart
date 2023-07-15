import 'package:flutter/material.dart';

class ManageLocationsProvider extends ChangeNotifier{
  List<String> _manageLocationIds = [];
  bool _isEditMode = false;

  List<String> get manageLocationIds => _manageLocationIds;
  bool get isEditMode => _isEditMode;

  set setManageLocationIds(val) {
    _manageLocationIds = val;
    notifyListeners();
  }

  set addManageLocationIds(val) {
    _manageLocationIds.add(val);
    notifyListeners();
  }

  set removeManageLocationIds(val) {
    _manageLocationIds.remove(val);
    notifyListeners();
  }

  set setIsEditMode(val) {
    _isEditMode = val;
    notifyListeners();
  }
}