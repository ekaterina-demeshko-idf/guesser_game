import 'dart:math';
import 'usecase.dart';

class GenerateNumberUsecase implements UseCase<int> {
  Random random = Random();

  @override
  int call() {
    return random.nextInt(9) + 1;
  }
}
