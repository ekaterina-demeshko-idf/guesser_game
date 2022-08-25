import 'dart:async';
import 'package:flutter/material.dart';
import 'bloc_dialog.dart';
import 'bloc_tile.dart';

abstract class Bloc {
  Stream<BlocTile> get dataStream;

  Stream<DialogEvent> get dialogStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocTile>();
  final _dialog = StreamController<DialogEvent>();
  final _blocTile = BlocTile.init();

  @override
  Stream<BlocTile> get dataStream => _data.stream;

  @override
  Stream<DialogEvent> get dialogStream => _dialog.stream;

  @protected
  void handleData({dynamic data}) {
    _blocTile.updateParams(data);
    _data.add(_blocTile.copy());
  }

  void showAlert({required DialogEvent event}) {
    _dialog.add(event);
  }

  @override
  void initState() {}
}
