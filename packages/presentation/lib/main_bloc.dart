import 'package:bloc/bloc.dart';
import 'package:domain/usecase/game_state.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:domain/usecase/check_state_usecase.dart';
import 'package:flutter/material.dart';
import 'main_state.dart';
import 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GenerateNumberUseCase generateNumberUseCase;
  final CheckStateUseCase checkStateUseCase;
  final myTextController = TextEditingController();
  bool? isGuessed;
  int number = 1;
  int randomNumber = 1;
  int counter = 0;

  MainBloc(
      {required this.generateNumberUseCase, required this.checkStateUseCase})
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
      counter: counter++,
    );
    final currentState = checkStateUseCase(params);
    if (currentState is OutOfAttempts) {
      return OutOfAttemptsState();
    }
    else if (currentState is YouWon) {
      return YouWonState();
    } else {
      return WrongState();
    }
  }

  MainState _newGame() {
    generateRandomNumber();
    counter = 0;
    return MainInitial();
  }
}
