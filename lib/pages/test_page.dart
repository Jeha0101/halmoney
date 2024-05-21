import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.blue[800],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyButtonList(
            buttons: [
              ButtonData(text: 'Test'),
              ButtonData(text: 'Test'),
              ButtonData(text: 'Test'),
              ButtonData(text: 'Test'),
              ButtonData(text: 'Test'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButtonList extends StatefulWidget {
  const MyButtonList({super.key, required this.buttons});

  final List<ButtonData> buttons;

  @override
  State<MyButtonList> createState() => _MyButtonListState();
}

class _MyButtonListState extends State<MyButtonList> {
  late List<bool> favoriateState;

  @override
  void initState() {
    favoriateState = List.generate(
        widget.buttons.length, (index) => widget.buttons[index].isFavorite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.buttons.length; i++)
          MyWidget(
            text: widget.buttons[i].text,
            onPressed: () {
              for (var j = 0; j < favoriateState.length; j++) {
                favoriateState[j] = false;
              }
              setState(() {
                favoriateState[i] = true;
                if (widget.buttons[i].onPressed != null) {
                  widget.buttons[i].onPressed!();
                }
              });
            },
            isFavourte: favoriateState[i],
          ),
      ],
    );
  }
}

class ButtonData {
  final String text;
  final Function()? onPressed;
  final bool isFavorite;

  ButtonData({required this.text, this.onPressed, this.isFavorite = false});
}

class MyWidget extends StatelessWidget {
  const MyWidget(
      {super.key,
        required this.text,
        required this.onPressed,
        this.isFavourte = false});

  final String text;
  final Function()? onPressed;
  final bool isFavourte;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isFavourte ? Colors.red : Colors.green,
        ),
        onPressed: onPressed,
        child: Text(text));
  }
}