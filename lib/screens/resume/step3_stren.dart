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
  Set<String> abilities = {};
  List<String> finalAbilities = [];

  final TextEditingController _abilityController = TextEditingController(); // 사용자가 입력할 텍스트 컨트롤러

  @override
  void initState(){
    super.initState();
    _fetchCoverLetterAndExtractAbilities();
  }

  //Firebase에서 자소서 데이터를 가져와 Flask 서버에 요청
  Future<void> _fetchCoverLetterAndExtractAbilities() async {
    try{
      // selectedFields 리스트에서 직무 카테고리 가져오기
      // 첫 번째 선택된 필드를 직무 카테고리로 사용한다고 가정
      if (widget.userPromptFactor.selectedFields.isEmpty) {
        print('직무 카테고리가 선택되지 않았습니다.');
        return;
      }

      String jobCategory = widget.userPromptFactor.selectedFields[0]; // 첫 번째 선택된 항목이 직무 카테고리라고 가정

      //Firebase에서 직무에 맞는 자소서 데이터 가져오기
      final jobDoc = await FirebaseFirestore.instance
          .collection('coverLetter')
          .doc(jobCategory)
          .collection('company')
          .get();

      List<String> coverLetterTexts = [];

      // 각 회사의 a1, a2 필드를 합쳐서 커버레터 텍스트로 사용
      for (var companyDoc in jobDoc.docs) {
        String a1 = companyDoc['a1'] ?? '';
        String a2 = companyDoc.data().containsKey('a2') ? companyDoc['a2'] : '';
        coverLetterTexts.add('$a1 $a2');
      }

      // 각 커버레터 텍스트에 대해 Flask 서버에 NER 요청
      for (String coverLetterText in coverLetterTexts) {
        final response = await http.post(
          Uri.parse('http://192.168.25.180:5000/ability_extraction'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'text': coverLetterText,
            'jobCategory' : jobCategory,
            'labels': ['Ability','Skill','Competency','Achievement','Specialization','Knowledge'], // Ability만 추출
          }),
        );

        if (response.statusCode == 200) {
          final entities = jsonDecode(response.body);
          print('Extracted Abilities: $entities'); // 디버깅용 출력

          // 추출된 abilities 리스트에 저장
          setState(() {
            for (var entity in entities){
              if (entity is String) {
                abilities.add(entity); // 문자열만 추가
              } else if (entity is Map<String, dynamic>) {
                if (entity.containsKey('text') && entity['text'] is String) {
                  abilities.add(entity['text']); // 'text' 필드가 문자열인 경우 추가
                }
              }
            }
          });
        } else {
          print('Failed to extract abilities. Status Code: ${response.statusCode}');
        }
      }
      _finalizeAbilities();
    }catch(e){
      print('Error occured: $e');
    }
  }


  //LLM 필터링
  Future<void> _finalizeAbilities() async {
    try{
      final response = await http.post(
        Uri.parse('http://192.168.25.180:5000/finalize_abilities'),  // flask 서버의 finalizeAbilities 엔드포인트 호출
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'jobCategory': widget.userPromptFactor.selectedFields[0],  // 직무 카테고리 전달
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Final Abilities: $result');  // 최종 필터링된 키워드 확인

        //필터링된 abilities 리스트 어벧이트
        setState(() {
          finalAbilities = List<String>.from(result);
        });
      } else {
        print('Failed to finalize abilities. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occured during finalization: $e');
    }
  }

  // 선택된 ability들을 업데이트하는 함수
  void updateSelectedAbilities(List<String> updatedAbilities) {
    setState(() {
      selectedStrens = updatedAbilities;
    });
  }

  // 사용자가 직접 역량을 추가하는 함수
  void _addCustomAbility() {
    if (_abilityController.text.isNotEmpty) {
      setState(() {
        finalAbilities.add(_abilityController.text); // 입력한 역량을 리스트에 추가
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
                  abilities: finalAbilities.toList(),
                  selectedAbilities: selectedStrens,
                  onSelectedAbilitiesChanged: updateSelectedAbilities,
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
