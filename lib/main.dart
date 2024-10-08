import 'package:flutter/material.dart';
import 'package:halmoney/get_user_info/step1_welcome.dart';
import 'package:halmoney/pages/login_page.dart';
import 'package:halmoney/pages/search_engine.dart';
import 'package:halmoney/screens/myPage/myPage.dart';
import 'package:halmoney/screens/resume/step1_hello.dart';
import 'package:halmoney/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
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

  //final String id ='sumin1234';

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


      home: LoginPage(),
      // 아래는 테스트용으로 원하는 페이지 연결용
      // git에 올릴때 반드시 수정
      // home: StepWelcome(id: "silver1234"),

    );
  }
}