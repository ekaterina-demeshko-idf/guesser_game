class MainData {
  final int? randomNumber;
  final int? guessNumber;
  final int counter;
  final bool? isDisabled;

  MainData({
    this.randomNumber,
    this.guessNumber,
    required this.counter,
    this.isDisabled,
  });

  factory MainData.init({
    int? randomNumber,
    int? guessNumber,
    required int counter,
    bool? isDisabled,
  }) =>
      MainData(
        randomNumber: 1,
        guessNumber: 0,
        counter: 1,
        isDisabled: true,
      );

  MainData copy({
    randomNumber,
    guessNumber,
    counter,
    isDisabled,
  }) =>
      MainData(
        randomNumber: randomNumber,
        guessNumber: guessNumber,
        counter: counter,
        isDisabled: isDisabled,
      );

  MainData copyWith({int? randomNumber, int? guessNumber, required int counter, bool? isDisabled}) =>
      MainData(
        randomNumber: randomNumber ?? this.randomNumber,
        guessNumber: guessNumber ?? this.guessNumber,
        counter: counter,
        isDisabled: isDisabled ?? this.isDisabled,
      );
}
