class MainData {
  MainData(
    this.randomNumber,
    this.guessNumber,
    this.counter,
    this.isDisabled,
  );

  int randomNumber;
  int guessNumber;
  int counter;
  bool isDisabled;

  factory MainData.init() => MainData(
        1,
        0,
        1,
        true,
      );

  MainData copy() => MainData(
        randomNumber,
        guessNumber,
        counter,
        isDisabled,
      );
}
