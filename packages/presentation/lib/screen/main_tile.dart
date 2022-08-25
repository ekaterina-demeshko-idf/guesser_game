class MainTile {
  MainTile(
    this.randomNumber,
    this.guessNumber,
    this.counter,
    this.isDisabled,
  );

  int randomNumber;
  int guessNumber;
  int counter;
  bool isDisabled;

  factory MainTile.init() => MainTile(
        1,
        0,
        1,
        true,
      );

  MainTile copy() => MainTile(
        randomNumber,
        guessNumber,
        counter,
        isDisabled,
      );
}
