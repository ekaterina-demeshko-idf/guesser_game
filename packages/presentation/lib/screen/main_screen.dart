import 'package:flutter/material.dart';
import '../base/bloc_dialog.dart';
import '../base/bloc_screen.dart';
import '../base/bloc_data.dart';
import 'main_my_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends BlocScreenState<MainScreen, MainBloc> {

  @override
  void initState() {
    super.initState();
    bloc.dialogStream.listen((event) {
      if (event is GameDialog) {
        showResultDialog(event);
      }
    });
  }

  void showResultDialog(event) {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 90),
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
                            onPressed:
                                blocData.isDisabled ? null : bloc.checkNumber,
                            child: const Text(
                              'Try',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                            onPressed: bloc.startNewGame,
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
