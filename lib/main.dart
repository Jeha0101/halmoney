import 'package:flutter/material.dart';
import 'package:halmoney/FirestoreData/JobProvider.dart';
import 'package:halmoney/pages/login_page.dart';
import 'package:halmoney/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider( //provider를 최상위로 만들어야함
      providers:[
        ChangeNotifierProvider(create: (_) => JobsProvider()..fetchJobs()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
        Locale('ko', ''), //Korean, no country code
      ],
      debugShowCheckedModeBanner:  false,

      home: LoginPage(),
    );
  }
}