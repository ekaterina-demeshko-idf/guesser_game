import 'package:domain/usecase/game_state.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:domain/usecase/check_state_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import '../base/bloc_dialog.dart';
import 'main_data.dart';

abstract class MainBloc extends Bloc {
  factory MainBloc(
    CheckStateUseCase checkStateUseCase,
    GenerateNumberUseCase generateNumberUseCase,
  ) =>
      MainBlocImpl(
        checkStateUseCase,
        generateNumberUseCase,
      );

  TextEditingController get editController;

  void generateRandomNumber();
}

class MainBlocImpl extends BlocImpl implements MainBloc {
  int randomNumber = 1;
  int number = 0;
  int counter = 0;
  final _editController = TextEditingController();
  final _screenData = MainData.init();
  final CheckStateUseCase _checkStateUseCase;
  final GenerateNumberUseCase _generateNumberUseCase;

  @override
  TextEditingController get editController => _editController;

  MainBlocImpl(
    this._checkStateUseCase,
    this._generateNumberUseCase,
  );

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  _updateData() {
    handleData(
      data: _screenData,
    );
  }

  _showAlert(String message) {
    showAlert(eventCopy: GameDialog(message));
  }

  @override
  void generateRandomNumber() {
    _screenData.randomNumber = _generateNumberUseCase();
    _screenData.isDisabled = false;
    _updateData();
  }

  void checkNumber() {
    number = int.tryParse(_editController.text)!;
    final params = ComparedNumbers(
      guessNumber: number,
      randomNumber: _screenData.randomNumber,
      counter: _screenData.counter,
    );
    final currentState = _checkStateUseCase(params);
    if (currentState is OutOfAttempts) {
      _showAlert(
          'You Out Of Attempts \nPlease, start new game.');
      _screenData.counter = 1;
      _screenData.isDisabled = true;
      _updateData();
    } else if (currentState is YouWon) {
      _showAlert('You Won');
      _screenData.counter = 1;
      _screenData.isDisabled = true;
      _updateData();
    } else {
      _showAlert('Wrong. Attempt №${_screenData.counter}');
      _screenData.counter++;
      _updateData();
    }
  }
}
