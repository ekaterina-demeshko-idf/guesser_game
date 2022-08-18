import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Guess the number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();
  Random random = Random();
  int _randomNumber1 = 0;
  int _counter = 0;
  bool _isButtonDisabled = false;


  void _generateRandomNumber1() {
    setState(() {
      _randomNumber1 = random.nextInt(9) + 1;
    });
  }

  bool _checkAttempt(count) {
    if(int.parse(myController.text) == _randomNumber1) {
      setState(() => _isButtonDisabled = true);
    }
    if(count > 3) {
      setState(() {
        count = 0;
      });
      setState(() => _isButtonDisabled = true);
      return false;
      //disable try button

    }
    else {
      return true;
    }

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _generateRandomNumber1());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Guess the number: $_randomNumber1',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your guess',
                  ),
                  keyboardType: TextInputType.number,
                  // onChanged: (value) {
                  //   setState(() {
                  //     text = value;
                  //   });
                  // },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _isButtonDisabled ? null : () {
                        setState(() {
                          _counter++;
                        });
                        var result = '';
                        int input = int.parse(myController.text);
                        if(_checkAttempt(_counter)) {
                          input == _randomNumber1 ? result = 'You won!' : result = 'Wrong';
                        } else {
                          result = 'You out of 3 free attempts. Please start a new game.';
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(result, style: TextStyle(fontSize: 30)),
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
                        setState(() {
                          _generateRandomNumber1();
                          _counter = 0;
                          _isButtonDisabled = false;
                        });
                      },
                      child: Text('New Game', style: TextStyle(fontSize: 20))),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String input = myController.text;
                        String hint = '';
                        int.parse(myController.text) > _randomNumber1 ? hint = "bigger" : hint = "smaller";
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: int.parse(myController.text) == _randomNumber1 ? Text("Don't be afraid to try", style: TextStyle(fontSize: 30)) : Text('$input is $hint than the number you\'re looking for', style: TextStyle(fontSize: 30)),
                            );
                          },
                        );
                      },
                      child: Text('Hint', style: TextStyle(fontSize: 20))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
