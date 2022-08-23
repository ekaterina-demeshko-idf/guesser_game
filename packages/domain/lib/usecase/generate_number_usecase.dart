import 'dart:math';
import 'usecase.dart';

class GenerateNumberUsecase implements UseCase<int> {
  Random random = Random();
  static const int maxNumber = 9;
  static const int startNumber = 1;

  @override
  int call() {
    return random.nextInt(maxNumber) + startNumber;
  }
}
