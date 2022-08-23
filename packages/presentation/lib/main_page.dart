// ignore_for_file: prefer_const_constructors

import 'package:domain/usecase/check_number_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (_) => MainBloc(
        checkNumberUseCase: CheckNumberUseCase(),
        generateNumberUseCase: GenerateNumberUsecase(),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Number'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (state is YouWonState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        (state).result,
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  },
                );
              }
              if (state is WrongState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        (state).result,
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  },
                );
              }
              if (state is OutOfAttemptsState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        (state).result,
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  },
                );
              }
            },
            builder: (context, state) {
              final bloc = context.watch<MainBloc>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Guess the number: ${bloc.randomNumber}',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                    child: TextField(
                      controller: bloc.myTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your guess',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: state is YouWonState ||
                                state is MainInitial ||
                                state is OutOfAttemptsState
                            ? null
                            : () {
                                context
                                    .read<MainBloc>()
                                    .add(CheckNumberEvent());
                              },
                        child: Text(
                          'Try',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<MainBloc>().add(NewGameEvent());
                        },
                        child: Text(
                          'New Game',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
