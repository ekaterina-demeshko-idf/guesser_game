abstract class DialogEvent {
  DialogEvent copy();
}

class GameDialog implements DialogEvent {
  String message;

  GameDialog(this.message);

  @override
  GameDialog copy({message}) => GameDialog(message ?? this.message);
}

GameDialog event = GameDialog('');

GameDialog eventCopy = event.copy(message: '');
