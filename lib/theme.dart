import 'package:flutter/material.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
    //앱에서 사용하는 기본 색상 primarySwatch: Colors.indigoAccent, //-flutter3에서 더이상 지원x
    fontFamily: 'NanumGothic',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    appBarTheme: const AppBarTheme(elevation: 0),
    useMaterial3: false,
  );
}