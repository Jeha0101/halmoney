import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:typed_data';
import 'dart:io';

class ExtraResumePage extends StatelessWidget {
  final String id;
  const ExtraResumePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
        elevation: 1.0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/img_logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                '할MONEY',
                style: TextStyle(
                  fontFamily: 'NanumGothicFamily',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$id 님의 이력서를 첨부해주세요!',
              style: const TextStyle(
                fontSize: 18.0,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            Container(child: FilePickerTest(id: id)),
            const SizedBox(height: 50),
            const Text(
              '추가하고 싶은 내용이 있다면 작성해주세요!',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: const TextField(
                decoration: InputDecoration(labelText: '(선택사항)'),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                minimumSize: const Size(360, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {},
              child: const Text(
                '저장하기!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilePickerTest extends StatefulWidget {
  final String id; // ExtraResumePage에서 전달받은 id 값을 받습니다.
  const FilePickerTest({super.key, required this.id});

  @override
  FilePickerTestState createState() => FilePickerTestState();
}

class FilePickerTestState extends State<FilePickerTest> {
  String showFileName = "";
  bool _dragging = false;

  Color defaultColor = Colors.black38;
  Color uploadingColor = Colors.blue[100]!;

  Uint8List? selectedFileBytes;
  String? selectedFileName;

  Future<Uint8List?> _getFileBytes(String path) async {
    try {
      File file = File(path);
      return await file.readAsBytes();
    } catch (e) {
      debugPrint('Error reading file: $e');
      return null;
    }
  }

  Future<void> _uploadFileToFirebase(Uint8List fileBytes, String fileName) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
      await storageRef.putData(fileBytes);
      final downloadUrl = await storageRef.getDownloadURL();
      debugPrint('File uploaded successfully! Download URL: $downloadUrl');

      // Firestore에 다운로드 URL 저장
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final QuerySnapshot result = await firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        await firestore
            .collection('user')
            .doc(docId)
        .set({'user_resume':downloadUrl});
        debugPrint('Firestore updated with resume_picture URL!');
      } else {
        debugPrint('User document not found');
      }
    } catch (e) {
      debugPrint('Error uploading file: $e');
    }
  }

  Container makeFilePicker() {
    Color color = _dragging ? uploadingColor : defaultColor;
    return Container(
      height: 200,
      width: 340,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: color,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "드래그하여 파일 업로드\n",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'png', 'jpg', 'csv'],
              );
              if (result != null && result.files.isNotEmpty) {
                String fileName = result.files.first.name;
                String? filePath = result.files.first.path;
                if (filePath != null) {
                  Uint8List? fileBytes = await _getFileBytes(filePath);
                  if (fileBytes != null) {
                    setState(() {
                      showFileName = "Now File Name: $fileName";
                      selectedFileBytes = fileBytes;
                      selectedFileName = fileName;
                    });
                  } else {
                    debugPrint("File bytes are null");
                  }
                } else {
                  debugPrint("File path is null");
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "or ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "파일을 찾아 업로드하기",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: defaultColor,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.upload_rounded,
                  color: defaultColor,
                ),
              ],
            ),
          ),
          Text(
            "(*.pdf/png/jpg/csv)",
            style: TextStyle(
              color: defaultColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            showFileName,
            style: TextStyle(
              color: defaultColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropTarget(
          onDragDone: (detail) async {
            debugPrint('onDragDone');
            if (detail.files.isNotEmpty) {
              String fileName = detail.files.first.name;
              String? filePath = detail.files.first.path;
              Uint8List? fileBytes = await _getFileBytes(filePath);
              if (fileBytes != null) {
                setState(() {
                  showFileName = "Now File Name: $fileName";
                  selectedFileBytes = fileBytes;
                  selectedFileName = fileName;
                });
              } else {
                debugPrint("File bytes are null");
              }
                        }
          },
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
            });
          },
          child: makeFilePicker(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            if (selectedFileBytes != null && selectedFileName != null) {
              await _uploadFileToFirebase(selectedFileBytes!, selectedFileName!);
            } else {
              debugPrint('No file selected for upload');
            }
          },
          child: const Text('Upload to Firebase'),
        ),
      ],
    );
  }
}
