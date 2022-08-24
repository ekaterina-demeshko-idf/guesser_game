import 'package:bloc/bloc.dart';
import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import 'main_state.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  static const maxAttempts = 3;
  final CheckNumberUseCase checkNumberUseCase;
  final GenerateNumberUsecase generateNumberUseCase;
  final myTextController = TextEditingController();
  bool? isGuessed;
  bool isButtonDisabled = true;
  int number = 1;
  int randomNumber = 1;
  int counter = 0;


  MainBloc({required this.checkNumberUseCase, required this.generateNumberUseCase})
      : super(MainInitial()) {
    on<CheckNumberEvent>((event, emit) {
      emit(_checkNumber());
    });
    on<NewGameEvent>((event, emit) {
      emit(_newGame());
    });
  }

  void generateRandomNumber() {
    randomNumber = generateNumberUseCase();
  }

  MainState _checkNumber() {
    number = int.tryParse(myTextController.text)!;
    final params = ComparedNumbers(
      guessNumber: number,
      randomNumber: randomNumber,
    );
    final isGuessed = checkNumberUseCase(params);
    counter++;
    if (counter > maxAttempts) {
      return OutOfAttemptsState();
    } else {
      if (isGuessed) {
        return YouWonState();
      } else {
        return WrongState();
      }
    }
  }

  MainState _newGame() {
    generateRandomNumber();
    counter = 0;
    isButtonDisabled = false;
    return MainInitial();
  }
}
