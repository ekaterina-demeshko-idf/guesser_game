import 'dart:math';
import 'usecase.dart';

class SetUpRandomNumberOptions {
  static const int maxNumber = 9;
  static const int startNumber = 1;
}

class GenerateNumberUsecase implements UseCase<int> {
  Random random = Random();

  @override
  int call() {
    return random.nextInt(SetUpRandomNumberOptions.maxNumber) +
        SetUpRandomNumberOptions.startNumber;
  }
}
