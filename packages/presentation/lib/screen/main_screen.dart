import 'package:domain/usecase/check_state_usecase.dart';
import 'package:domain/usecase/generate_number_usecase.dart';
import 'package:flutter/material.dart';
import '../base/bloc_dialog.dart';
import '../base/bloc_screen.dart';
import '../base/bloc_tile.dart';
import 'main_my_bloc.dart';

class MainScreen extends BlocScreen {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends BlocScreenState<MainScreen, MainBloc> {
  _MainScreenState()
      : super(
          MainBloc(CheckStateUseCase(), GenerateNumberUseCase()),
        );

  @override
  void initState() {
    super.initState();
    bloc.dialogStream.listen((event) {
      if (event is GameDialog) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                event.message,
                style: const TextStyle(fontSize: 30),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final data = snapshot.data as BlocTile;
            final blocData = data.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Guess the Number'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Guess the number: ${blocData.randomNumber}',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                        child: TextField(
                          controller: bloc.editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Your guess',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: blocData.isDisabled
                                ? null
                                : () {
                                    bloc.checkNumber();
                                  },
                            child: const Text(
                              'Try',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            onPressed: () => bloc.generateRandomNumber(),
                            child: const Text(
                              'New Game',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
