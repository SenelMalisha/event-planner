import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardProvider extends ChangeNotifier {
  int? _currentTab;

  int get currentTab => _currentTab ?? 0;

  set currentTab(int data) {
    _currentTab = data;
    notifyListeners();
  }

  int? _reportsCurrentTab;

  int get reportsCurrentTab => _reportsCurrentTab ?? 0;

  set reportsCurrentTab(int data) {
    _reportsCurrentTab = data;
    notifyListeners();
  }

  int? _complaintsListCurrentTab;

  int get complaintsListCurrentTab => _complaintsListCurrentTab ??0 ;

  set complaintsListCurrentTab(int data) {
    _complaintsListCurrentTab = data;
    notifyListeners();
  }














}