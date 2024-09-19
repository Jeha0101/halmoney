import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halmoney/get_user_info/step1_welcome.dart';

final TextEditingController genderController = TextEditingController();
final TextEditingController dobController = TextEditingController();
final TextEditingController addressController = TextEditingController();

class SignupPgTwo extends StatelessWidget {
  final String id; //전달받은 id를 저장할 변수
  const SignupPgTwo({super.key, required this.id});

  //const SignupPgOne({super.key});

  void _onYearChanged(int year) {
    dobController.text = year.toString();
    print(year.toString());
  }

  void _saveData(BuildContext context) async {
    final gender = genderController.text;
    final dob = dobController.text;
    final address = addressController.text;

    // Debugging: Print the collected data
    print("Gender: $gender, DOB: $dob, Address: $address");

    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        await FirebaseFirestore.instance.collection('user').doc(docId).update({
          'gender': gender,
          'dob': dob,
          'address': address,
        });

        print("User updated successfully");

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User updated successfully")),
        );
      } else {
        print("User not found");
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
      }
    } catch (error) {
      print("Failed to update user: $error");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update user: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('본인의 정보를 입력해주세요.',
                style: TextStyle(
                    fontSize: 23.0,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 30),

            const Text('성별',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            Row(children: [
              Expanded(
                  child: MyButtonList(
                buttons: [
                  ButtonData(
                      text: '여성',
                      onPressed: () {
                        genderController.text = '여성';
                      }),
                  ButtonData(
                      text: '남성',
                      onPressed: () {
                        genderController.text = '남성';
                      }),
                ],
              ))
            ]),

            const SizedBox(height: 35),

            //생년월일
            const Text('태어난 년도',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            SizedBox(
              width: 400,
              height: 100,
              child: CupertinoPicker(
                // 수정한 부분
                itemExtent: 80, // 수정한 부분
                onSelectedItemChanged: (int index) {
                  _onYearChanged(1940 + index); // 수정한 부분
                },
                children: List<Widget>.generate(
                  DateTime.now().year - 1920 + 1,
                  (index) => Center(
                    child: Text(
                      (1920 + index).toString(),
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            //주소
            const Text('주소',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 20),

            Expanded(
                child: DropdownButtonExample(
                    addressController: addressController)),

            const SizedBox(height: 80),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //backgroundColor: _buttonActive ? const Color.fromARGB(250, 51, 51, 255) : Colors.grey,
                    backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                    minimumSize: const Size(360, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  _saveData(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StepWelcome(id: id)),
                  );
                },
                child: const Text(
                  '가입완료',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

//성별 버튼 색깔 변경 처리
class MyButtonList extends StatefulWidget {
  const MyButtonList({super.key, required this.buttons});

  final List<ButtonData> buttons;

  @override
  State<MyButtonList> createState() => _MyButtonListState();
}

class _MyButtonListState extends State<MyButtonList> {
  late List<bool> favoriateState;

  @override
  void initState() {
    favoriateState = List.generate(
        widget.buttons.length, (index) => widget.buttons[index].isFavorite);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < widget.buttons.length; i++)
          MyWidget(
            text: widget.buttons[i].text,
            onPressed: () {
              for (var j = 0; j < favoriateState.length; j++) {
                favoriateState[j] = false;
              }
              setState(() {
                favoriateState[i] = true;
                if (widget.buttons[i].onPressed != null) {
                  widget.buttons[i].onPressed!();
                }
              });
            },
            isFavourte: favoriateState[i],
          ),
      ],
    );
  }
}

class ButtonData {
  final String text;
  final Function()? onPressed;
  final bool isFavorite;

  ButtonData({required this.text, this.onPressed, this.isFavorite = false});
}

class MyWidget extends StatelessWidget {
  const MyWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isFavourte = false});

  final String text;
  final Function()? onPressed;
  final bool isFavourte;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: isFavourte
                ? const Color.fromARGB(250, 51, 51, 255)
                : Colors.grey,
            minimumSize: const Size(160, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 18)));
  }
}

//주소 선택 dropdown

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key, required this.addressController});

  final TextEditingController addressController;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  List<String> cities = ['-시/도-', '서울특별시', '경기도'];
  List<List<String>> gugun = [
    ['-시/군/구-'],
    [
      '-시/군/구-',
      '강남구',
      '강동구',
      '강북구',
      '강서구',
      '관악구',
      '광진구',
      '구로구',
      '금천구',
      '노원구',
      '도봉구',
      '동대문구',
      '동작구',
      '마포구',
      '서대문구',
      '서초구',
      '성동구',
      '성북구',
      '송파구',
      '양천구',
      '영등포구',
      '용산구',
      '은평구',
      '종로구',
      '중구',
      '중랑구'
    ],
    [
      '-시/군/구-',
      '가평구',
      '고양시',
      '과천시',
      '광명시',
      '광주시',
      '구리시',
      '군포시',
      '김포시',
      '남양주시',
      '동두천시',
      '부천시',
      '성남시',
      '수원시',
      '시흥시',
      '안산시',
      '안성시',
      '안성시',
      '안양시',
      '양주시',
      '여주시',
      '오산시',
      '용인시',
      '의왕시',
      '의정부시',
      '이천시',
      '파주시',
      '평택시',
      '포천시',
      '하남시',
      '화성시'
    ]
  ];

  String selectedSido = '-시/도-';
  String selectedGugun = '-시/군/구-';
  String selectedDong = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 180,
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton<String>(
                //itemHeight: null,
                itemHeight: 80,
                isExpanded: true,
                value: selectedSido.isNotEmpty ? selectedSido : null,
                onChanged: (value) {
                  setState(() {
                    selectedSido = value!;
                    selectedGugun = gugun[0][0];
                    addressController.text = '$selectedSido, $selectedGugun';
                  });
                },
                items: cities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            //시구군
            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 90,
              child: DropdownButton<String>(
                //itemHeight: null,
                itemHeight: 80,
                isExpanded: true,
                value: selectedGugun.isNotEmpty ? selectedGugun : null,
                onChanged: (value) {
                  setState(() {
                    selectedGugun = value!;
                    addressController.text = '$selectedSido, $selectedGugun';
                  });
                },
                items: selectedSido.isEmpty
                    ? []
                    : gugun[cities.indexOf(selectedSido)].map((String g) {
                        return DropdownMenuItem<String>(
                          value: g,
                          child: Text(g),
                        );
                      }).toList(),
              ),
            ),

            //SizedBox(height:20),
            // Text(
            //   '당신이 선택한 주소는: ',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // Text('$selectedSido $selectedGugun')
          ],
        ));
  }
}
