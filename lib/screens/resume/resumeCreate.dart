import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ResumeCreate extends StatelessWidget {
const ResumeCreate({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'GPT API Example',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: const MyHomePage(),
);
}
}

class MyHomePage extends StatefulWidget {
const MyHomePage({super.key});

@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String _response = "";

Future<void> _fetchGPTResponse() async {
final apiKey = dotenv.get('GPT_API_KEY');
const endpoint = 'https://api.openai.com/v1/chat/completions';
const requestsTimeOut = Duration(seconds: 60);
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
return Scaffold(
appBar: AppBar(
title: const Text('GPT API Example'),
),
body: Center(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: ListView(
children: [
Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
ElevatedButton(
onPressed: _fetchGPTResponse,
child: const Text('Fetch GPT Response'),
),
const SizedBox(height: 20),
Text(
_response,
textAlign: TextAlign.center,
),
],
),
]
),
),
),
);
}
}