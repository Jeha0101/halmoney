import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/AI_select_cond_page.dart';
import 'package:halmoney/myAppPage.dart';
import 'package:halmoney/pages/login_page.dart';
import 'package:halmoney/pages/select_skill_page.dart';
import 'package:halmoney/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'JobSearch_pages/JobSearch_main_page.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String id ="sum1234";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ko', 'KR'),

      title: 'Flutter Demo',
      theme: theme(context),
      //datepicker 날짜 한국어 변환
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        //Locale('en', ''), //English, no country code
        Locale('ko', ''), //Korean, no country code
      ],
      debugShowCheckedModeBanner:  false,
      home: MyAppPage(id: id),
      //home: LoginPage(),

      /*home: Scaffold(
        appBar: AppBar(
          title: Text('할MONEY'),

        ),
        body: Center(
          child: Text(
            '할MONEY',
            style: TextStyle(
              fontSize: 50,
              color: Colors.indigo,
            ),
          )
        ),
      ),*/
    );
  }
}