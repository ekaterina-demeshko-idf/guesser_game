import 'package:flutter/material.dart';

import 'bloc.dart';

abstract class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);
}

abstract class BlocScreenState<BS extends BlocScreen, B extends Bloc> extends State<BS> {
  BlocScreenState(Bloc this.bloc);
  @protected
  final bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
