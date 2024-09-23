import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'signupStepper_page2.dart';

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
  String? _errorMessage;

  // Stepper가 이동할 때 호출되는 함수
  void _continue() async {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
      print('현재 단계: $_currentStep');
    } else {
      // 비밀번호가 일치하는지 다시 한 번 확인
      if (_password != _confirmPassword) {
        setState(() {
          _errorMessage = '비밀번호가 일치하지 않습니다.';
        });
        return;
      }

      // 비밀번호 해쉬화
      final bytes = utf8.encode(_password);
      final hashedPassword = sha256.convert(bytes).toString();

      try {
        // Firestore에서 ID 중복 체크
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('user')
            .where('id', isEqualTo: _id)
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isNotEmpty) {
          setState(() {
            _errorMessage = '중복된 ID입니다.';
          });
        } else {
          // Firestore에 회원정보 저장
          await FirebaseFirestore.instance.collection('user').add({
            'name': _name,
            'id': _id,
            'password': hashedPassword,
            'phone': _phoneNumber,
          });

          // 회원가입 완료 알림
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('회원가입 완료'),
                content: Text('회원가입이 성공적으로 완료되었습니다!',
                style: TextStyle(fontSize: 15),),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPgTwoStepper(id: _id)),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        setState(() {
          _errorMessage = '오류가 발생했습니다: $e';
        });
      }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원가입",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                currentStep: _currentStep,
                onStepContinue: _continue,
                onStepCancel: _cancel,
                steps: [
                  Step(
                    title: Text("성명"),
                    content: TextFormField(
                      decoration: InputDecoration(labelText: '성명을 입력하세요'),
                      validator: (value) {
                        if (_currentStep == 0) {
                          if (value == null || value.trim().isEmpty) {
                            return '성명을 입력해주세요';
                          }
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
                        if (_currentStep == 1) {
                          if (value == null || value.trim().isEmpty) {
                            return '아이디를 입력해주세요';
                          }
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
                        if (_currentStep == 2) {
                          if (value == null || value.trim().isEmpty) {
                            return '비밀번호를 입력해주세요';
                          }
                          if (value.length < 6) {
                            return '비밀번호는 6자 이상이어야 합니다';
                          }
                        }
                        return null;
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
                        if (_currentStep == 3) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 확인을 입력해주세요';
                          }
                          if (value != _password) {
                            return '비밀번호가 일치하지 않습니다';
                          }
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
                        if (_currentStep == 4) {
                          if (value == null || value.trim().isEmpty) {
                            return '전화번호를 입력해주세요!';
                          }
                        }
                        return null;
                      },
                      onSaved: (value) => _phoneNumber = value!,
                    ),
                  ),
                ],
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}