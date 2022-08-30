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
      _MainBlocImpl(
        checkStateUseCase,
        generateNumberUseCase,
      );

  TextEditingController get editController;

  void startNewGame();

  void checkNumber();
}

class _MainBlocImpl extends BlocImpl implements MainBloc {
  int randomNumber = 1;
  int number = 0;
  final _editController = TextEditingController();
  var _screenData = MainData.init();
  final CheckStateUseCase _checkStateUseCase;
  final GenerateNumberUseCase _generateNumberUseCase;

  @override
  TextEditingController get editController => _editController;

  _MainBlocImpl(
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
  void startNewGame() {
    _screenData = _screenData.copyWith(
      randomNumber: _generateNumberUseCase(),
      counter: 0,
      isDisabled: false,
    );
    _updateData();
  }

  @override
  void checkNumber() {
    number = int.tryParse(_editController.text) ?? 0;
    final params = ComparedNumbers(
      guessNumber: number,
      randomNumber: _screenData.randomNumber,
      counter: _screenData.counter,
    );
    final currentState = _checkStateUseCase(params);
    if (currentState is OutOfAttempts) {
      _showAlert('You Out Of Attempts \nPlease, start new game.');
      _screenData = _screenData.copyWith(
        counter: 0,
        isDisabled: true,
      );
      _updateData();
    } else if (currentState is YouWon) {
      _showAlert('You Won');
      _screenData = _screenData.copyWith(
        counter: 0,
        isDisabled: true,
      );
      _updateData();
    } else {
      _screenData = _screenData.copyWith(
        counter: _screenData.counter + 1,
      );
      _showAlert('Wrong. Attempt №${_screenData.counter}');
      _updateData();
    }
  }
}
