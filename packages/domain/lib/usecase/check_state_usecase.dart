import 'game_state.dart';
import 'usecase.dart';

const maxAttempts = 3;

class ComparedNumbers {
  final int? guessNumber;
  final int? randomNumber;
  final int counter;

  ComparedNumbers({
    required this.guessNumber,
    required this.randomNumber,
    required this.counter,
  });
}

class CheckStateUseCase implements UseCaseParams<ComparedNumbers, GameState> {
  @override
  GameState call(ComparedNumbers params) {
    if (params.counter >= maxAttempts) {
      return OutOfAttempts();
    } else {
      if (params.guessNumber == params.randomNumber) {
        return YouWon();
      } else {
        return Wrong();
      }
    }
  }
}
