import 'package:flutter/material.dart';
import 'package:presentation/my_app.dart';
import 'di/app_injector.dart';

void main()  async {
  await initAppInjector();
  runApp(const MyApp());
}
