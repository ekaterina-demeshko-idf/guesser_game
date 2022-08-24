abstract class MainState {}

class MainInitial extends MainState {
  final int counter = 0;

  List<Object?> get props => [counter];
}

class YouWonState extends MainState {
  final String result = 'You Won!';

  List<Object?> get props => [result];
}

class WrongState extends MainState {
  final String result = 'Wrong!';
  late int counter;

  List<Object?> get props => [result, counter];
}

class OutOfAttemptsState extends MainState {
  final String result = 'You out of 3 free attempts. Please start a new game.';

  List<Object?> get props => [result];
}
