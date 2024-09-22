import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halmoney/get_user_info/user_Info.dart';
import 'package:halmoney/myAppPage.dart';

class SelectPlace extends StatefulWidget {
  final UserInfo userInfo;
  const SelectPlace({super.key, required this.userInfo});

  @override
  _SelectPlaceState createState() => _SelectPlaceState();
}

class _SelectPlaceState extends State<SelectPlace> {
  String selectedAddress = '';
  String originalAddress = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    originalAddress = widget.userInfo.userAddress;
    print(originalAddress);
    //_fetchUserAddress();
  }

  // 원래 주소 Firebase에서 가져오기
  // Future<void> _fetchUserAddress() async {
  //   try {
  //     final QuerySnapshot result = await _firestore
  //         .collection('user')
  //         .where('id', isEqualTo: widget.userInfo.userId)
  //         .get();
  //
  //     final List<DocumentSnapshot> documents = result.docs;
  //
  //     if (documents.isNotEmpty) {
  //       final String docId = documents.first.id;
  //
  //       await _firestore
  //           .collection('user')
  //           .doc(docId)
  //           .get().then((DocumentSnapshot ds){
  //             final data = ds.data() as Map<String, dynamic>;
  //             setState(() { //업데이트 된 정보를 화면에 자동 반영
  //               originalAddress = data["address"];
  //             });
  //       });
  //
  //       /*await _firestore
  //           .collection('user')
  //           .doc(docId)
  //           .collection('Interest')
  //           .doc('interest_place')
  //           .set({'inter_place': data['address']});*/
  //     }
  //   } catch (error) {
  //     print("Failed to update interests: $error");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Failed to update interests: $error")),
  //     );
  //   }
  // }

  // Interest 컬렉션에 업데이트하기
  Future<void> _updateInterest(String address) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('user')
          .where('id', isEqualTo: widget.userInfo.userId)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        await _firestore
            .collection('user')
            .doc(docId)
            .collection('Interest')
            .doc('interest_place')
            .set({'inter_place': address});

        print("Interest place updated successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Interest place updated successfully")),
        );
      } else {
        print("User not found");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
      }
    } catch (error) {
      print("Failed to update interest place: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update interest place: $error")),
      );
    }
  }

  // 내 주소 선택 버튼 눌렀을 때
  void _onSelectAddressButtonPressed() async {
    print('originalAdress on button pressed: $originalAddress');
    setState(() {
      selectedAddress='';
    });
    await _updateInterest(originalAddress);
  }
  // 다른 주소 선택 버튼 눌렀을 때
  void _onAddressSelected(String address) {
    setState(() {
      selectedAddress = address;
    });
  }

  // 선택 완료 버튼 눌렀을 때
  void _onSaveButtonPressed() async {
    if (selectedAddress.isEmpty) {
      // 다른 주소를 선택하지 않았다면, 기존 주소를 사용
      await _updateInterest(originalAddress);
    } else {
      // 다른 주소를 선택했다면, 선택된 주소를 사용
      await _updateInterest(selectedAddress);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 30.0, top: 100.0),
            child: Column(
              //왼쪽 맞춤 정렬
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '관심 지역을 선택해주세요',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    '선택한 관심 지역의 모집공고를 확인할 수 있습니다.',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 30),

                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    '내 주소 선택하기',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'NanumGothic',
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        //일단 임의
                        originalAddress,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'NanumGothic',
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            _onSelectAddressButtonPressed();
                            },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(130, 40), // 너비 200, 높이 60
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16), // 좌우 패딩 16
                          ),
                          child: const Text(
                              '선택', style: TextStyle(color: Colors.white))),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    '다른 주소 선택하기',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(child: DropdownButtonExample(
                      onAddressSelected: _onAddressSelected)),

                  const SizedBox(height: 10),

                  Text(
                    selectedAddress,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'NanumGothic',
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(250, 51, 51, 255),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: _buttonActive ? const Color.fromARGB(250, 51, 51, 255) : Colors.grey,
                        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                        minimumSize: const Size(360, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                    onPressed: () {
                      _onSaveButtonPressed();
                      widget.userInfo.updateUserInfo();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyAppPage(id: widget.userInfo.userId)),
                      );
                    },
                    child: const Text(
                      '선택 완료', style: TextStyle(color: Colors.white),),
                  ),


                  const SizedBox(height: 20),
                ]
            )
        )
    );
  }
}

class DropdownButtonExample extends StatefulWidget{
  final Function(String) onAddressSelected;

  const DropdownButtonExample({super.key, required this.onAddressSelected});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample>{
  List<String> cities = ['서울특별시', '경기도'];
  Map<String, List<String>> gugun = {
    '서울특별시': [
      '강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구',
      '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구',
      '용산구', '은평구', '종로구', '중구', '중랑구'
    ],
    '경기도': [
      '가평구', '고양시', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시',
      '남양주시', '동두천시', '부천시', '성남시', '수원시', '시흥시', '안산시', '안성시',
      '안양시', '양주시', '여주시', '오산시', '용인시', '의왕시', '의정부시', '이천시', '파주시', '평택시',
      '포천시', '하남시', '화성시'
    ]
  };

  String selectedSido = '서울';
  String selectedGugun = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(cities[index]),
                      selected: cities[index] == selectedSido,
                      onTap: (){
                        setState(() {
                          selectedSido = cities[index];
                          selectedGugun = '';
                        });
                      },
                    );
                  },
              ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: gugun[selectedSido]?.length ?? 0,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(gugun[selectedSido]![index]),
                    onTap: (){
                      setState((){
                       selectedGugun = gugun[selectedSido]![index];
                      });
                      widget.onAddressSelected('$selectedSido > $selectedGugun');
                    },
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}