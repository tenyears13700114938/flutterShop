import 'package:flutter/material.dart';

// 1. Create a ChangeNotifier to hold lifecycle state
class AppLifecycleService with ChangeNotifier, WidgetsBindingObserver {
  AppLifecycleState _currentState =
      AppLifecycleState.resumed; // Initial assumption
  AppLifecycleState get currentState => _currentState;

  AppLifecycleService() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    if (state == AppLifecycleState.resumed) {
      print("myDebug app resumed");
    } else if (state == AppLifecycleState.inactive) {
      print("myDebug app inactive");
    }
    notifyListeners(); // Notify listening widgets
  }

  @override
  void dispose() {
    // Ensure you have a way to call this if the service is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
