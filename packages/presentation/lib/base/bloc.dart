import 'dart:async';
import 'package:flutter/material.dart';
import 'bloc_tile.dart';

abstract class Bloc {
  Stream<BlocTile> get dataStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocTile>();
  final _blocTile = BlocTile.init();

  @override
  Stream<BlocTile> get dataStream => _data.stream;

  @protected
  void handleData({dynamic data}) {
    _blocTile.updateParams(data);
    _data.add(_blocTile.copy());
  }

  @override
  void initState() {}
}
