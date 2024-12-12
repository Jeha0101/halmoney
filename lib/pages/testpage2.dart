import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class AudioRecorderPage extends StatefulWidget {
  @override
  _AudioRecorderPageState createState() => _AudioRecorderPageState();
}

class _AudioRecorderPageState extends State<AudioRecorderPage> {
  final Record _record = Record();
  bool _isRecording = false;
  String? _filePath;
  String? _transcribedText;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (await Permission.microphone.isDenied) {
      await Permission.microphone.request();
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<Directory> getPublicDirectory() async {
    Directory directory = Directory('/storage/emulated/0/Documents');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<void> _startRecording() async {
    if (await _record.hasPermission()) {
      Directory directory = await getPublicDirectory();
      String path = "${directory.path}/recorded_audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

      await _record.start(
        path: path,
        bitRate: 96000,
        samplingRate: 16000, // STT API 요구사항에 따라 샘플링 레이트 설정
      );
      setState(() {
        _isRecording = true;
        _filePath = path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied for microphone')),
      );
    }
  }

  Future<void> _stopRecording() async {
    final path = await _record.stop();
    setState(() {
      _isRecording = false;
    });
    if (path != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Recording saved to: $path')),
      );
    }
  }

  Future<void> _sendToClovaSTT() async {
    if (_filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No recording found to send')),
      );
      return;
    }

    try {
      // 파일 읽기
      File audioFile = File(_filePath!);
      List<int> fileBytes = await audioFile.readAsBytes();

      // Clova Speech Recognition API 호출
      String url = 'https://naveropenapi.apigw.ntruss.com/recog/v1/stt';
      Map<String, String> headers = {
        'Content-Type': 'application/octet-stream',
        'X-NCP-APIGW-API-KEY-ID': 'nfwi4elwoa', // 네이버 클라우드 Client ID
        'X-NCP-APIGW-API-KEY': 'UnJS8nFZbjhxtvnCgvFxDx2VttHC7QZnb2iNQkXI', // 네이버 클라우드 Client Secret
      };

      // 언어 파라미터 추가
      Uri uri = Uri.parse('$url?lang=Kor'); // 언어 파라미터를 추가합니다.

      final response = await http.post(uri, headers: headers, body: fileBytes);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _transcribedText = responseData['text']; // 변환된 텍스트 저장
        });
      } else {
        setState(() {
          _transcribedText = 'Error: ${response.statusCode} - ${response.body}';
        });
        print('Error: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _transcribedText = 'Error: $e';
      });
      print('Exception: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder with Clova STT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? null : _startRecording,
              child: Text('Start Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : null,
              child: Text('Stop Recording'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendToClovaSTT,
              child: Text('Send to Clova STT'),
            ),
            if (_transcribedText != null) ...[
              SizedBox(height: 20),
              Text('Transcribed Text:'),
              Text(_transcribedText!),
            ],
          ],
        ),
      ),
    );
  }
}
