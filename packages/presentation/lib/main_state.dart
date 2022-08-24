abstract class MainState {}

class MainInitial extends MainState {
  final int counter = 0;

  List<Object?> get props => [counter];
}

class YouWonState extends MainState {
  final String result = 'You Won!';
  final bool isButtonDisabled = true;

  List<Object?> get props => [result, isButtonDisabled];
}

class WrongState extends MainState {
  final String result = 'Wrong!';

  List<Object?> get props => [result];
}

class OutOfAttemptsState extends MainState {
  final String result = 'You out of 3 free attempts. Please start a new game.';
  final bool isButtonDisabled = true;

  List<Object?> get props => [result, isButtonDisabled];
}
