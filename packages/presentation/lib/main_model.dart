import 'dart:math';
import 'package:domain/usecase/check_number_usecase.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  final checkNumberUseCase = CheckNumberUseCase();
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
    if (checkNumber()) {
      isButtonDisabled = true;
      notifyListeners();
    }
    if (count > 4) {
      count = 0;
      isButtonDisabled = true;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  bool checkNumber() {
    final input = int.parse(myController.text);
    final params = Params( guessNumber: input, randomNumber: randomNumber1);
    final isGuessed = checkNumberUseCase(params);
    counter++;
    return isGuessed;
  }

  void newGame() {
    generateRandomNumber1();
    counter = 0;
    isButtonDisabled = false;
  }
}
