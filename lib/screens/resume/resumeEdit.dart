import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/resumeCreate.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ResumeEdit extends StatefulWidget {
  final String id;

  const ResumeEdit({super.key, required this.id});

  @override
  _ResumeEdit createState() => _ResumeEdit();
}

class _ResumeEdit extends State<ResumeEdit>{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name = '';
  String dob = '';
  String gender = '';
  String address = '';
  String phone = '';

  String _response = '';

  @override
  void initState(){
    super.initState();
    userInfo();
  }

  Future<void> userInfo() async{
    try {
      //id 일치 여부 확인
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        //사용자 정보 가져오기
        await _firestore
            .collection('user')
            .doc(docId)
            .get().then((DocumentSnapshot ds){
          final data = ds.data() as Map<String, dynamic>;
          setState(() {
            name = data['name'];
            dob = data['dob'].substring(0,4);
            gender = data['gender'];
            address = data['address'];
            phone = data['phone'];
          });
        });
      }
    }catch (error) {
      print("Failed to bring the user info: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to bring the user info: $error")),
      );
    }
  }

  Future<void> _fetchGPTResponse() async {
    final apiKey = dotenv.get('GPT_API_KEY');
    const endpoint = 'https://api.openai.com/v1/chat/completions';
    const requestsTimeOut = const Duration(seconds: 60);
    const prompt = '서울이 어떤 곳인지 설명해줘';

    try{
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': prompt},
          ],
          'max_tokens': 200,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));

        // Check if 'choices' array exists and is not empty
        if (responseBody.containsKey('choices') && responseBody['choices'] is List && responseBody['choices'].isNotEmpty) {
          final text = responseBody['choices'][0]['message']['content'];
          setState(() {
            _response = text;
          });
        } else {
          setState(() {
            _response = 'Failed to fetch response: Invalid response format';
          });
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        setState(() {
          _response = 'Failed to fetch response: ${response.statusCode} - ${response.body}';
        });
      }
    }catch (e){
      print('Exception: $e');
      setState(() {
        _response = 'Failed to fetch response: $e';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            title : const Text('이력서 작성'),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.only(left : 30.0, right: 30.0),
            child: ListView(
              children: [
                const SizedBox(height: 30,),
                //개인정보란
                Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color : Colors.grey,
                            spreadRadius:2.5,
                            blurRadius: 10.0,
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 60,
                      ),
                    ),
                    const SizedBox(width: 35,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text(
                          name,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          gender,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          dob+'년생',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40,),

                //주소, 전화번호란
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('주소',
                          style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Text('전화번호',
                          style: TextStyle(fontSize: 18),),
                      ],
                    ),
                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address,
                          style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        Text(phone,
                          style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ],
                ),
                Divider(),
                ElevatedButton(
                  onPressed: _fetchGPTResponse,
                  child: Text('Fetch GPT Response'),
                ),
                Text(
                  _response,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
