import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class audio extends StatefulWidget {
  const audio({super.key});

  @override
  State<audio> createState() => _audioState();
}

class _audioState extends State<audio> {
  Duration duration = Duration.zero; //총 시간
  Duration position = Duration.zero; //진행중인 시간

  //녹음에 필요한 것들
  final recorder = sound.FlutterSoundRecorder();
  bool isRecording = false; //녹음 상태
  String audioPath = ''; //녹음중단 시 경로 받아올 변수
  String playAudioPath = ''; //저장할때 받아올 변수 , 재생 시 필요

  //재생에 필요한 것들
  final AudioPlayer audioPlayer = AudioPlayer(); //오디오 파일을 재생하는 기능 제공
  bool isPlaying = false; //현재 재생중인지

  @override
  void initState() {
    super.initState();

    playAudio();
    //마이크 권한 요청, 녹음 초기화
    initRecorder();
    print("datetime now: ${DateTime.now()}");

    //재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
      print("헨들러 isplaying : $isPlaying");
    });

    //재생 파일의 전체 길이를 감지하는 이벤트 핸들러
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
      print('Current position: $position');
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying == PlayerState.playing) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
      }

      await audioPlayer.setSourceDeviceFile(playAudioPath);
      print("duration: $duration");
      await Future.delayed(Duration(seconds: 2));
      print("after wait duration: $duration");

      setState(() {
        duration = duration;
        isPlaying = true;
      });

      audioPlayer.play;

      print('오디오 재생 시작: $playAudioPath');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : $playAudioPath");
      print("오디오 재생 중 오류 발생 : $e");
    }
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();

    isRecording = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  //녹음 시작
  Future record() async {
    if (!isRecording) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  //저장함수
  Future<String> saveRecordingLocally() async {
    if (audioPath.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환

    final audioFile = File(audioPath);
    if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환
    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath =
      p.join(directory.path, 'recordings'); // recordings 디렉터리 생성
      final newFile = File(p.join(
          newPath, 'audio.mp3')); // 여기서 'audio.mp3'는 파일명을 나타냅니다. 필요에 따라 변경 가능
      if (!(await newFile.parent.exists())) {
        await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
      }

      await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사

      print('Complete Saving recording: ${newFile.path}');
      playAudioPath = newFile.path;

      return newFile.path; // 새로운 파일의 경로 반환
    } catch (e) {
      print('Error saving recording: $e');
      return ''; // 오류 발생 시 빈 문자열 반환
    }
  }

  // 녹음 중지 & 녹음된 파일의 경로를 가져옴 및 저장
  Future<void> stop() async {
    final path = await recorder.stopRecorder(); // 녹음 중지하고, 녹음된 오디오 파일의 경로를 얻음
    audioPath = path!;

    setState(() {
      isRecording = false;
    });

    final savedFilePath = await saveRecordingLocally(); // 녹음된 파일을 로컬에 저장
    print("savedFilePath: $savedFilePath");
  }

  String formatTime(Duration duration) {
    print("formatTime duration: $duration");

    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String result = '$minutes:${seconds.toString().padLeft(2, '0')}';

    print("formatTime result: $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '녹음',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        inactiveTrackColor: Colors.grey,
                      ),
                      child: Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          setState(() {
                            position = Duration(seconds: value.toInt());
                          });
                          await audioPlayer.seek(position);
                          //await audioPlayer.resume();
                        },
                        activeColor: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(position),
                            style: TextStyle(color: Colors.brown),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                              padding: EdgeInsets.only(bottom: 50),
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.brown,
                              ),
                              iconSize: 25,
                              onPressed: () async {
                                print("isplaying 전 : $isPlaying");

                                if (isPlaying) {
                                  //재생중이면
                                  await audioPlayer.pause(); //멈춤고
                                  setState(() {
                                    isPlaying = false; //상태변경하기..?
                                  });
                                } else {
                                  //멈춘 상태였으면
                                  await playAudio();
                                  await audioPlayer.resume(); // 녹음된 오디오 재생
                                }
                                print("isplaying 후 : $isPlaying");
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            formatTime(duration),
                            style: TextStyle(color: Colors.brown),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                child: IconButton(
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                    } else {
                      await record();
                    }
                    setState(() {});
                  },
                  icon: Icon(
                    recorder.isRecording ? Icons.stop : Icons.mic,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}