abstract class DialogEvent {}

class GameDialog implements DialogEvent {
  String message;

  GameDialog(this.message);
}
