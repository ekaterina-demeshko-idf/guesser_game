import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:presentation/main_model.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ChangeNotifierProvider(
          create: (_) => MainModel(),
          child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Number'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Guess the number: ${model.randomNumber1}',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                child: TextField(
                  controller: model.myController,
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
                      onPressed: model.isButtonDisabled
                          ? null
                          : () {
                        String result = '';
                        if (model.checkAttempt(model.counter)) {
                          model.checkNumber()
                              ? result = 'You won!'
                              : result = 'Wrong';
                        } else {
                          result =
                          'You out of 3 free attempts. Please start a new game.';
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(result,
                                  style: TextStyle(fontSize: 30)),
                            );
                          },
                        );
                      },
                      child: Text('Try', style: TextStyle(fontSize: 20))),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        model.generateRandomNumber1();
                        model.counter = 0;
                        model.isButtonDisabled = false;
                      },
                      child: Text('New Game', style: TextStyle(fontSize: 20))),
                 ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}