import 'package:flutter/material.dart';

import 'bloc.dart';

abstract class BlocScreenState<S extends StatefulWidget, B extends Bloc> extends State {
  BlocScreenState(Bloc this.bloc);

  @protected
  final dynamic bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
