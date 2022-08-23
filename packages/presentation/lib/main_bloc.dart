import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import 'main_state.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final checkNumberUseCase = CheckNumberUseCase();
  final generateNumberUseCase = GenerateNumberUsecase();
  bool? isGuessed;
  final myTextController = TextEditingController();
  int number = 1;
  int randomNumber = 0;
  int counter = 0;
  bool isButtonDisabled = true;
  static const maxAttempts = 3;

  MainBloc({required checkNumberUseCase, required generateNumberUseCase})
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
    return NewGameState();
  }
}
