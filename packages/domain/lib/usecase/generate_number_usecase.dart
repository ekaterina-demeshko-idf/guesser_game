import 'dart:math';
import 'usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateNumberUseCase implements UseCase<int> {
  Random random = Random();
  static const int maxNumber = 9;
  static const int startNumber = 1;

  @override
  int call() {
    return random.nextInt(maxNumber) + startNumber;
  }
}
