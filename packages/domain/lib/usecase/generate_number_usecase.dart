import 'dart:math';
import 'usecase.dart';
const int maxNumber = 9;
const int startNumber = 1;

class GenerateNumberUsecase implements UseCase<int> {
  Random random = Random();


  @override
  int call() {
    return random.nextInt(maxNumber) + startNumber;
  }
}
