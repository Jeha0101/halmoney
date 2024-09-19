import 'package:flutter/material.dart';
import 'package:halmoney/screens/resume/step5_quantity.dart';
import 'package:halmoney/get_user_info/career.dart';
import 'package:halmoney/get_user_info/user_Info.dart';

class StepCareerPage extends StatefulWidget {
  final UserInfo userInput;

  StepCareerPage({
    super.key,
    required this.userInput,
  });

  @override
  State<StepCareerPage> createState() => _StepCareerPageState();
}

class _StepCareerPageState extends State<StepCareerPage> {
  List<Career> careers = [];

  //경력 추가하기
  void addCareer() {
    showDialog(
      context: context,
      builder: (context) {
        return CareerDialog(
          onSave: (newCareer) {
            setState(() {
              careers.add(newCareer);
            });
          },
        );
      },
    );
  }

  //경력 수정하기
  void editCareer(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CareerDialog(
          career: careers[index],
          onSave: (updatedCareer) {
            setState(() {
              careers[index] = updatedCareer;
            });
          },
        );
      },
    );
  }

  //경력 제거하기
  void removeCareer(int index) {
    setState(() {
      careers.removeAt(index);
    });
  }

  //경력 입력시 공란 여부 확인
  bool areAllFieldsFilled() {
    for (var career in careers) {
      if (career.workDuration.isEmpty ||
          career.workUnit.isEmpty ||
          career.workPlace.isEmpty ||
          career.workDescription.isEmpty) {
        return false;
      }
    }
    return true;
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
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 이전 페이지로 이동
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

                //다음 페이지로 이동
                GestureDetector(
                  onTap: () {
                    widget.userInput.editCareers(careers);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StepQuantityPage(userInput: widget.userInput)),
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
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('이력사항을 입력해주세요!',
                    style: TextStyle(
                      fontFamily: 'NanumGothicFamily',
                      fontWeight: FontWeight.w500,
                      fontSize: 28.0,
                      color: Colors.black,
                    )),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: careers.length + 1,
                itemBuilder: (context, index) {
                  if (index == careers.length) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: addCareer,
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.blue),
                                SizedBox(width: 10),
                                Text('경력 추가',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CareerDisplay(
                        career: careers[index],
                        onEdit: () => editCareer(index),
                        onRemove: () => removeCareer(index),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CareerDisplay extends StatelessWidget {
  final Career career;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const CareerDisplay({
    super.key,
    required this.career,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 20, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                career.workPlace,
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onEdit,
                    child:
                        const Text('편집', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: onRemove,
                    child:
                        const Text('삭제', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '근무 기간     ',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '근무 내용      ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${career.workDuration}년 ${career.workUnit}개월',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    career.workDescription,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CareerDialog extends StatefulWidget {
  final Career? career;
  final void Function(Career) onSave;

  const CareerDialog({
    super.key,
    this.career,
    required this.onSave,
  });

  @override
  _CareerDialogState createState() => _CareerDialogState();
}

class _CareerDialogState extends State<CareerDialog> {
  TextEditingController workDurationController = TextEditingController();
  TextEditingController workUnitController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController workDescriptionController = TextEditingController();

  bool isSaveEnabled = false;

  @override
  void initState() {
    super.initState();

    if (widget.career != null) {
      workDurationController.text = widget.career!.workDuration;
      workUnitController.text = widget.career!.workUnit;
      workPlaceController.text = widget.career!.workPlace;
      workDescriptionController.text = widget.career!.workDescription;
    }
  }

  @override
  void dispose() {
    workDurationController.dispose();
    workUnitController.dispose();
    workPlaceController.dispose();
    workDescriptionController.dispose();
    super.dispose();
  }

  // void _checkIfAllFieldsFilled() {
  //   setState(() {
  //     isSaveEnabled = workDurationController.text.isNotEmpty &&
  //         workUnitController.text.isNotEmpty &&
  //         workPlaceController.text.isNotEmpty &&
  //         workDescriptionController.text.isNotEmpty;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('경력'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("근무기간"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 70,
                  child: TextField(
                    decoration: InputDecoration(labelText: '기간'),
                    keyboardType: TextInputType.number,
                    controller: workDurationController,
                  ),
                ),
                // Container(
                //   width: 70,
                //   child: DropdownButtonFormField<String>(
                //     decoration: const InputDecoration(labelText: ''),
                //     value: workYearsController.text.isNotEmpty
                //         ? workYearsController.text
                //         : null,
                //     items: years.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     onChanged: (newValue) {
                //       setState(() {
                //         workYearsController.text = newValue ?? '';
                //       });
                //     },
                //   ),
                // ),

                SizedBox(
                  width: 70,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: '단위'),
                    value: workUnitController.text.isNotEmpty ? workUnitController.text : null,
                    items: ['주', '개월', '년'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        workUnitController.text = newValue ?? '';
                      });
                    },
                  ),
                ),

                // Text("년"),
                // Container(
                //     width: 70,
                //     child: DropdownButtonFormField<String>(
                //       decoration: const InputDecoration(labelText: ''),
                //       value: workMonthsController.text.isNotEmpty
                //           ? workMonthsController.text
                //           : null,
                //       items: months.map((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //       onChanged: (newValue) {
                //         setState(() {
                //           workMonthsController.text = newValue ?? '';
                //         });
                //       },
                //     ),
                // ),
                // Text("개월"),
              ],
            ),

            TextField(
              decoration: const InputDecoration(labelText: '근무지'),
              controller: workPlaceController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: '근무 내용'),
              controller: workDescriptionController,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: isSaveEnabled
              ? () {
                  final newExperience = Career()
                    ..workDuration = workDurationController.text
                    ..workUnit = workUnitController.text
                    ..workPlace = workPlaceController.text
                    ..workDescription = workDescriptionController.text;
                  widget.onSave(newExperience);
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('완료'),
        ),
      ],
    );
  }
}