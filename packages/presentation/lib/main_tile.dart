class MainTile {
  MainTile(this.randomNumber, this.guessNumber, this.counter, this.result, this.isDisabled);
  int randomNumber;
  int guessNumber;
  int counter;
  String result = '';
  bool isDisabled;

  factory MainTile.init() => MainTile(1, 0, 0, '', true);

  MainTile copy() => MainTile(randomNumber, guessNumber, counter, result, isDisabled);
}
