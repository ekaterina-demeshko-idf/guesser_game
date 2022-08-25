import 'package:domain/usecase/game_state.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:domain/usecase/check_state_usecase.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'base/bloc_dialog.dart';
import 'main_tile.dart';

abstract class MainBloc extends Bloc {
  factory MainBloc(CheckStateUseCase checkStateUseCase,
          GenerateNumberUseCase generateNumberUseCase) =>
      MainBlocImpl(checkStateUseCase, generateNumberUseCase);

  void generateRandomNumber();

  TextEditingController get editController;
}

class MainBlocImpl extends BlocImpl implements MainBloc {
  final _tile = MainTile.init();
  final _editController = TextEditingController();
  final CheckStateUseCase _checkStateUseCase;
  final GenerateNumberUseCase _generateNumberUseCase;
  int randomNumber = 1;
  int number = 0;
  int counter = 0;

  MainBlocImpl(this._checkStateUseCase, this._generateNumberUseCase);

  @override
  void initState() {
    super.initState();
    _updateData(data: _tile);
  }

  _updateData({MainTile? data}) {
    handleData(
      data: data,
    );
  }

  _showAlert(String message) {
    showAlert(event: GameDialog(message));
  }

  @override
  void generateRandomNumber() {
    _tile.randomNumber = _generateNumberUseCase();
    _tile.isDisabled = false;
    _updateData(
      data: _tile,
    );
  }

  void checkNumber() {
    number = int.tryParse(_editController.text)!;
    final params = ComparedNumbers(
      guessNumber: number,
      randomNumber: _tile.randomNumber,
      counter: _tile.counter,
    );
    final currentState = _checkStateUseCase(params);
    if (currentState is OutOfAttempts) {
      _showAlert(
          'Wrong. Attempt №${_tile.counter}. \nYou Out Of Attempts \nPlease, start new game.');
      _tile.counter = 1;
      _tile.isDisabled = true;
      _updateData(
        data: _tile,
      );
    } else if (currentState is YouWon) {
      _showAlert('You Won');
      _tile.counter = 1;
      _tile.isDisabled = true;
      _updateData(
        data: _tile,
      );
    } else {
      _showAlert('Wrong.Attempt №${_tile.counter}');
      _tile.counter++;
      _updateData(
        data: _tile,
      );
    }
  }

  @override
  TextEditingController get editController => _editController;
}
