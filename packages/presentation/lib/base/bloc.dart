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
  final _blocData = BlocData.init();

  @override
  Stream<BlocData> get dataStream => _data.stream;

  @override
  Stream<DialogEvent> get dialogStream => _dialog.stream;

  @protected
  void handleData({dynamic data}) {
    _blocData.updateParams(data);
    _data.add(_blocData.copy());
  }

  void showAlert({eventCopy}) {
    _dialog.add(eventCopy);
  }

  @override
  void initState() {}
}
