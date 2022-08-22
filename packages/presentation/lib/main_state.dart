abstract class MainState {}

class MainInitial extends MainState {
  final int counter = 0;
  final int randomNumber = 0;
  final bool isButtonDisabled = true;

  @override
  List<Object?> get props => [counter, randomNumber, isButtonDisabled];
}

class NewGameState extends MainState {
  final int counter = 0;

  @override
  List<Object?> get props => [counter];
}

class YouWonState extends MainState {
  final String result = 'You Won!';
  final bool isButtonDisabled = true;

  @override
  List<Object?> get props => [result, isButtonDisabled];
}

class WrongState extends MainState {
  final String result = 'Wrong!';

  @override
  List<Object?> get props => [result];
}

class OutOfAttemptsState extends MainState {
  final String result = 'You out of 3 free attempts. Please start a new game.';
  final bool isButtonDisabled = true;

  @override
  List<Object?> get props => [result, isButtonDisabled];
}