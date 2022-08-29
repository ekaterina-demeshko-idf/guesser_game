import 'dart:async';
import 'package:flutter/material.dart';
import 'bloc_dialog.dart';
import 'bloc_data.dart';

abstract class Bloc {
  Stream<BlocData> get dataStream;

  Stream<DialogEvent> get dialogStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocData>();
  final _dialog = StreamController<DialogEvent>();
  final _blocTile = BlocData.init();

  @override
  Stream<BlocData> get dataStream => _data.stream;

  @override
  Stream<DialogEvent> get dialogStream => _dialog.stream;

  @protected
  void handleData({dynamic data}) {
    _blocTile.updateParams(data);
    _data.add(_blocTile.copy());
  }

  void showAlert({required GameDialog event}) {
    _dialog.add(event);
  }

  @override
  void initState() {}
}
