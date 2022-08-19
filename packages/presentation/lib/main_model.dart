import 'dart:math';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  bool? isGuessed;
  final myController = TextEditingController();
  Random random = Random();
  int randomNumber1 = 0;
  int counter = 0;
  bool isButtonDisabled = true;

  void generateRandomNumber1() {
    Random random = Random();
    randomNumber1 = random.nextInt(9) + 1;
    notifyListeners();
  }

  bool checkAttempt(count) {
    if(checkNumber()) {
      isButtonDisabled = true;
      notifyListeners();
    }
    if(count > 4) {
      count = 0;
      isButtonDisabled = true;
      notifyListeners();
      return false;
    }
    else {
      return true;
    }
  }

  bool checkNumber() {
    final input = int.parse(myController.text);
    counter++;
    return input == randomNumber1;
  }

  void newGame() {
    generateRandomNumber1();
    counter = 0;
    isButtonDisabled = false;
  }
}