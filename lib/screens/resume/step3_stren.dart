import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/step4_career.dart';
import 'package:halmoney/get_user_info/user_Info.dart';
import 'package:halmoney/screens/resume/user_prompt_factor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StepStrenPage extends StatefulWidget {
  final UserInfo userInfo;
  final UserPromptFactor userPromptFactor;

  StepStrenPage({
    super.key,
    required this.userInfo,
    required this.userPromptFactor,
  });

  @override
  State<StepStrenPage> createState() => _StepStrenPageState();
}

class _StepStrenPageState extends State<StepStrenPage> {
  List<String> selectedStrens = [];
  List<String> abilities = [];

  final TextEditingController _abilityController = TextEditingController(); // 사용자가 입력할 텍스트 컨트롤러

  @override
  void initState(){
    super.initState();
    _fetchCoverLetterAndExtractAbilities();
  }

  //Firebase에서 역량 키워드 가져오기
  Future<void> _fetchCoverLetterAndExtractAbilities() async {
    try {
      // selectedFields 리스트에서 직무 카테고리 가져오기
      // 첫 번째 선택된 필드를 직무 카테고리로 사용한다고 가정
      if (widget.userPromptFactor.selectedFields.isEmpty) {
        print('직무 카테고리가 선택되지 않았습니다.');
        return;
      }

      String jobCategory = widget.userPromptFactor.selectedFields[0]; // 첫 번째 선택된 항목이 직무 카테고리라고 가정

      // Firebase에서 직무에 맞는 역량 키워드 가져오기
      final jobDoc = await FirebaseFirestore.instance
          .collection('coverLetter')
          .doc(jobCategory)
          .get();

      // jobDoc에서 'Ability' 필드가 있는지 확인
      if (jobDoc.exists && jobDoc.data()!.containsKey('Ability')) {
        List<dynamic> abilitiesArray = jobDoc.data()!['Ability'];

        // 배열을 문자열 리스트로 변환
        setState(() {
          abilities = abilitiesArray.cast<String>().toList(); // 상태에 저장
        });

        print('Abilities: $abilities');
      } else {
        print('Ability 필드가 존재하지 않습니다.');
      }

    } catch (e) {
      print('Error occurred: $e');
    }
  }


  // 사용자가 직접 역량을 추가하는 함수
  void _addCustomAbility() {
    if (_abilityController.text.isNotEmpty) {
      setState(() {
        abilities.add(_abilityController.text); // 입력한 역량을 리스트에 추가
        _abilityController.clear(); // 텍스트 필드를 비움
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 30,
                      ),
                      Text('이전',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.userPromptFactor.editSelectedStrens(selectedStrens);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StepCareerPage(
                            userInfo: widget.userInfo,
                            userPromptFactor: widget.userPromptFactor,
                          )),
                    );
                  },
                  child: const Row(
                    children: [
                      Text('다음',
                          style: TextStyle(
                            fontFamily: 'NanumGothicFamily',
                            fontSize: 20.0,
                            color: Colors.black,
                          )),
                      Icon(
                        Icons.chevron_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '자신의 장점은 무엇이라고 생각하나요?',
              style: TextStyle(
                fontFamily: 'NanumGothicFamily',
                fontWeight: FontWeight.w500,
                fontSize: 28.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            // 역량 입력 필드와 추가 버튼
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _abilityController,
                    decoration: const InputDecoration(
                      hintText: '직접 역량을 입력하세요',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addCustomAbility, // 버튼 클릭 시 직접 입력한 역량 추가
                ),
              ],
            ),

            const SizedBox(height: 15),


            Expanded(
              child: SingleChildScrollView(
                child: AbilitiesChooseWidget(
                  abilities: abilities,
                  selectedAbilities: selectedStrens,
                  onSelectedAbilitiesChanged: (List<String> updatedSelectedAbilities) {
                    // 선택한 역량 업데이트
                    setState(() {
                      selectedStrens = updatedSelectedAbilities;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AbilitiesChooseWidget extends StatelessWidget {
  final List<String> abilities;
  final List<String> selectedAbilities;
  final ValueChanged<List<String>> onSelectedAbilitiesChanged;

  const AbilitiesChooseWidget({
    super.key,
    required this.abilities,
    required this.selectedAbilities,
    required this.onSelectedAbilitiesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: abilities.map((ability) {
            final isSelected = selectedAbilities.contains(ability);
            return GestureDetector(
              onTap: () {
                List<String> updatedAbilities = List.from(selectedAbilities); // 기존 선택된 항목 복사
                if (isSelected) {
                  updatedAbilities.remove(ability); // 선택 해제
                } else {
                  updatedAbilities.add(ability); //선택 추가
                }
                onSelectedAbilitiesChanged(updatedAbilities); // 변경된 리스트 전달
              },
              child: Chip(
                label: Text(ability),
                backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class NextPage extends StatelessWidget {
  final List<String> selectedAbilities;

  const NextPage({super.key, required this.selectedAbilities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Next Page')),
      body: Center(
        child: Text('Selected Abilities: ${selectedAbilities.join(", ")}'),
      ),
    );
  }
}
