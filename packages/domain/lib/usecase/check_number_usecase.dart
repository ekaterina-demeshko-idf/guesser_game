import 'usecase.dart';

class Params {
  final int guessNumber;
  final int randomNumber;

  Params({required this.guessNumber, required this.randomNumber});
}

class CheckNumberUseCase implements UseCaseParams<Params, bool> {
  @override
  bool call(Params params) {
    return params.guessNumber == params.randomNumber;
  }
}
