import 'dart:collection';

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _switchValue = false;
  Queue<String> _pressedArrowsQueue = Queue<String>();

  bool get switchValue => _switchValue;

  set switchValue(bool value) {
    _switchValue = value;
    print('Switch Value: $_switchValue');
    notifyListeners();
  }

  Queue<String> get pressedArrowsQueue => _pressedArrowsQueue;

  void addPressedArrow(String arrow) {
    _pressedArrowsQueue.add(arrow);
    print('Pressed Arrows: $_pressedArrowsQueue');
    notifyListeners();
  }
}
