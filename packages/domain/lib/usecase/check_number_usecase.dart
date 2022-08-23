import 'usecase.dart';

class ComparedNumbers {
  final int guessNumber;
  final int randomNumber;

  ComparedNumbers({
    required this.guessNumber,
    required this.randomNumber,
  });
}

class CheckNumberUseCase implements UseCaseParams<ComparedNumbers, bool> {
  @override
  bool call(ComparedNumbers params) {
    return params.guessNumber == params.randomNumber;
  }
}
