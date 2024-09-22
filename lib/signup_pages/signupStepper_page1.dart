import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class SignupStepperOne extends StatefulWidget {
  const SignupStepperOne({super.key});

  @override
  _SignupStepperOneState createState() => _SignupStepperOneState();
}

class _SignupStepperOneState extends State<SignupStepperOne> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Input 데이터 관리
  String _name = '';
  String _id = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber = '';

  // Stepper가 이동할 때 호출되는 함수
  void _continue() {
    // 현재 단계의 폼이 유효한지 확인
    if (_formKey.currentState!.validate()) {
      // 유효하면 폼의 값을 저장
      _formKey.currentState!.save();

      setState(() {
        if (_currentStep < 4) {
          _currentStep++;
        } else {
          // 마지막 단계일 경우 완료 처리
          print('회원가입 완료');
        }
      });
    }
  }

  void _cancel() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("회원가입")),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: _continue,
          onStepCancel: _cancel,
          steps: [
            Step(
              title: Text("성명"),
              content: TextFormField(
                decoration: InputDecoration(labelText: '성명을 입력하세요!!'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '성명을 입력해주세요';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
            ),
            Step(
              title: Text("아이디"),
              content: TextFormField(
                decoration: InputDecoration(labelText: '아이디를 입력하세요'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력해주세요';
                  }
                  return null;
                },
                onSaved: (value) => _id = value!,
              ),
            ),
            Step(
              title: Text("비밀번호"),
              content: TextFormField(
                decoration: InputDecoration(labelText: '비밀번호를 입력하세요'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 6자 이상이어야 합니다';
                  }
                  return null;
                },
                onChanged: (value) {
                  // 비밀번호가 변경될 때마다 저장
                  setState(() {
                    _password = value;
                  });
                },
                onSaved: (value) => _password = value!,
              ),
            ),
            Step(
              title: Text("비밀번호 확인"),
              content: TextFormField(
                decoration: InputDecoration(labelText: '비밀번호를 다시 입력하세요'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호 확인을 입력해주세요';
                  }
                  if (value != _password) {
                    return '비밀번호가 일치하지 않습니다';
                  }
                  return null;
                },
                onSaved: (value) => _confirmPassword = value!,
              ),
            ),
            Step(
              title: Text("전화번호"),
              content: TextFormField(
                decoration: InputDecoration(labelText: '전화번호를 입력하세요'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '전화번호를 입력해주세요!';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}