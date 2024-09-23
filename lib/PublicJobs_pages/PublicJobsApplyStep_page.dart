import 'package:flutter/material.dart';
import 'PublicJobsCheckQuestion.dart';
import 'PublicJobsDescribe.main.dart';

class PublicJobsApplyPage extends StatefulWidget {
  final String id;
  final String applystep;

  PublicJobsApplyPage({
    required this.id,
    required this.applystep,
    Key? key,
  }) : super(key: key);

  void initState(){
    print(applystep);
  }

  @override
  _PublicJobsApplyPageState createState() => _PublicJobsApplyPageState();
}

class _PublicJobsApplyPageState extends State<PublicJobsApplyPage> {
  late Future<List<String>> _questionsFuture;
  int _currentStep = 0;
  List<bool> _isChecked = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('지원절차 확인하기'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}