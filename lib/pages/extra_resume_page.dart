import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'dart:typed_data';

class ExtraResumePage extends StatelessWidget {
  const ExtraResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    style : TextStyle(
                      fontFamily: 'NanumGothicFamily',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: Colors.black,
                      //Color.fromARGB(250, 51, 51, 255),
                    ),)
              ),
            ],
          ),
        ),
        body: Padding (
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top:50.0),
            child: Column(
              //왼쪽 맞춤 정렬
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '추가할 이력사항이 있다면 첨부해주세요!',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 30),

                  Container(child: const FilePickerTest()),

                  const SizedBox(height: 50),

                  const Text(
                    '추가하고 싶은 내용이 있다면 작성해주세요!',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 20),

                  Container(child: const TextField(
                    decoration: InputDecoration(
                        labelText: '(선택사항)'
                    ),
                  ),
                  ),

                  const SizedBox(height: 70),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: _buttonActive ? const Color.fromARGB(250, 51, 51, 255) : Colors.grey,
                        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                        minimumSize: const Size(360,50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                    onPressed: () {},
                    child: const Text('AI로 이력서 만들기',style: TextStyle(color: Colors.white),),
                  ),
                ]
            )
        )
    );
  }
}

class FilePickerTest extends StatefulWidget{
  const FilePickerTest({super.key});

  @override
  FilePickerTestState createState() => FilePickerTestState();
}

class FilePickerTestState extends State<FilePickerTest> {
  //final List<XFile> _list = [];

  String showFileName = "";
  bool _dragging = false;

  Color defaultColor = Colors.black38;
  Color uploadingColor = Colors.blue[100]!;

  Container makeFilePicker(){
    Color color = _dragging ? uploadingColor : defaultColor;
    return Container(
      height: 200,
      width: 340,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: color,),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //drag and drop 부분
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("드래그하여 파일 업로드\n", style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20))
            ],
          ),
          //picker 부분
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'png', 'jpg', 'csv'],
              );
              if( result != null && result.files.isNotEmpty ){
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  showFileName = "Now File Name: $fileName";
                });
                /*
                do jobs
                 */
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("or ", style: TextStyle(fontWeight: FontWeight.bold,color:defaultColor, fontSize:20 ),),
                Text("파일을 찾아 업로드하기", style: TextStyle(fontWeight: FontWeight.bold, color: defaultColor, fontSize: 20,),),
                Icon(Icons.upload_rounded, color: defaultColor,),
              ],
            ),
          ),
          Text("(*.pdf/png/jpg/csv)", style: TextStyle(color: defaultColor,),),
          const SizedBox(height: 10,),
          Text(showFileName, style: TextStyle(color: defaultColor,),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //makeFilePicker -> makedropzone
    return DropTarget(
      onDragDone: (detail) async {
        debugPrint('onDragDone');
        if (detail.files.isNotEmpty) {
          String fileName = detail.files.first.name;
          Uint8List fileBytes = await detail.files.first.readAsBytes();
          debugPrint(fileName);
          setState(() {
            showFileName = "Now File Name: $fileName";
          });
        }
      },
      onDragEntered: (detail){
        setState(() {
          debugPrint('onDragEntered');
          _dragging=true;
        });
      },
      onDragExited: (detail){
        debugPrint('onDragExited');
        setState(() {
          _dragging=false;
        });
      },
      child: makeFilePicker(),
    );
  }
}
