import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset('assets/images/img_logo.png'),
      )
    );
  }
}
