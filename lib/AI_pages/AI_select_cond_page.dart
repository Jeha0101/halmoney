import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/cond_search_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halmoney/get_user_info/user_Info.dart';

class AISelectCondPage extends StatefulWidget {
  final UserInfo userInfo;
  const AISelectCondPage({super.key, required this.userInfo});

  @override
  _AISelectCondPageState createState() => _AISelectCondPageState();
}

class _AISelectCondPageState extends State<AISelectCondPage> {
  int _currentStep = 0;
  final TextEditingController addressController = TextEditingController();
  List<String> selectedJobs = [];
  List<String> selectedPay = [];
  List<String> selectedTime = [];
  List<String> selectedLocations = [];

  Future<void> _AIrecommCondition(BuildContext context, String seladdress, List<String> selectedJobs, List<String> selectedPay, List<String> selectedTime) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final QuerySnapshot result = await firestore
          .collection('user')
          .where('id', isEqualTo: widget.userInfo.userId)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        //var addressParts = seladdress.split(',');
        //var selectedGugun = addressParts.length > 1 ? addressParts[1].trim() : '';

        await firestore
            .collection('user')
            .doc(docId)
            .collection('AIRecommendation')
            .doc('recomCondition')
            .set({
          'location': selectedLocations,
          'job_type': selectedJobs,
          'payment_type': selectedPay,
          'working_days': selectedTime,
        });

        Query jobQuery = firestore.collection('jobs');
        final QuerySnapshot jobResult = await jobQuery.get();
        final List<DocumentSnapshot> jobDocuments = jobResult.docs;

        final filteredJobs = jobDocuments.where((job) {
          final jobData = job.data() as Map<String, dynamic>;
          final address = jobData['address'] as String;
          final jobName = jobData['job_name'] as String;
          final wage = jobData['wage'] as String;
          final workTimeWeek = jobData['work_time_week'] as String;

          final addMatch = selectedLocations.any((selectedGugun) => address.contains(selectedGugun));
          final jobMatch = selectedJobs.isEmpty || selectedJobs.any((job) => jobName.contains(job));
          final payMatch = selectedPay.isEmpty || selectedPay.any((pay) => wage.contains(pay));
          final timeMatch = selectedTime.isEmpty || selectedTime.any((time) => workTimeWeek.contains(time));

          return addMatch && jobMatch && payMatch && timeMatch;
        }).toList();

        if (filteredJobs.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CondSearchResultPage(userInfo: widget.userInfo, jobs: filteredJobs)));
        } else {
          _showNoJobsDialog(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update interest place: $error")),
      );
    }
  }

  void _showNoJobsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('조건에 맞는 공고가 없습니다!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void removeLocation(String location) {
    setState(() {
      selectedLocations.remove(location);  // 선택된 지역 삭제
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(250, 51, 51, 255),
        title: Row(
          children: [
            Image.asset(
              'assets/images/img_logo.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              '할MONEY',
              style: TextStyle(fontFamily: 'NanumGothicFamily', fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep += 1);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep -= 1);
                }
              },
              steps: [
                Step(
                  title: const Text('지역 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  content: Column(
                    children: [
                      DropdownButtonExample(
                        onLocationAdded: (newLocation) {
                          setState(() {
                            if (!selectedLocations.contains(newLocation)) {
                              selectedLocations.add(newLocation);  // 구 이름만 추가
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        children: selectedLocations.map((location) {
                          return Chip(
                            label: Text(location),
                            onDeleted: () {
                              removeLocation(location);  // 구 삭제
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text('분야 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  content: ChooseJobButton(onSelectionChanged: (selection) {
                    selectedJobs = selection;
                  }),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text('급여형태 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  content: ChoosePayButton(onSelectionChanged: (selection) {
                    selectedPay = selection;
                  }),
                  isActive: _currentStep >= 2,
                ),
                Step(
                  title: const Text('근무시간 선택', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  content: ChooseTimeButton(onSelectionChanged: (selection) {
                    selectedTime = selection;
                  }),
                  isActive: _currentStep >= 3,
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(250, 51, 51, 255),
              minimumSize: const Size(360, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              final seladdress = addressController.text;
              _AIrecommCondition(context, seladdress, selectedJobs, selectedPay, selectedTime);
            },
            child: const Text(
              '결과보기',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  final Function(String) onLocationAdded;  // 지역 추가를 위한 콜백

  const DropdownButtonExample({
    Key? key,
    required this.onLocationAdded,  // 콜백 추가
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: selectedSido,
            onChanged: (value) {
              setState(() {
                selectedSido = value!;
                selectedGugun = gugun[0][0];
                //widget.addressController.text = '$selectedSido, $selectedGugun';
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
        Expanded(
          child: DropdownButton<String>(
            value: selectedGugun,
            onChanged: (value) {
              setState(() {
                selectedGugun = value!;
                //widget.addressController.text = '$selectedSido, $selectedGugun';
              });
            },
            items: gugun[cities.indexOf(selectedSido)].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            if (selectedSido != '-시/도-' && selectedGugun != '-시/군/구-') {
              widget.onLocationAdded(selectedGugun);  // 선택된 구만 추가
            }// 선택된 지역 추가 콜백 호출
          },
        ),
      ],
    );
  }
}

class ChooseJobButton extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  const ChooseJobButton({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  State<ChooseJobButton> createState() => _ChooseJobButtonState();
}

class _ChooseJobButtonState extends State<ChooseJobButton> {
  List<String> jobs = ['음료 조리','요양', '간병', '안내', '청소', '사무', '교사', '주방',
    '사회복지사', '디자이너', '조리사', '영업', '기획', '환경 미화','운전',
    'IT','생산','판매','배달','방송','안전'];
  List<String> selectedJobs = [];

  void toggleJob(String job) {
    setState(() {
      if (selectedJobs.contains(job)) {
        selectedJobs.remove(job);
      } else {
        selectedJobs.add(job);
      }
      widget.onSelectionChanged(selectedJobs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: jobs.map((job) {
        bool isSelected = selectedJobs.contains(job);
        return ChoiceChip(
          label: Text(job),
          selected: isSelected,
          onSelected: (selected) => toggleJob(job),
        );
      }).toList(),
    );
  }
}

class ChoosePayButton extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  const ChoosePayButton({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  State<ChoosePayButton> createState() => _ChoosePayButtonState();
}

class _ChoosePayButtonState extends State<ChoosePayButton> {
  List<String> paymentTypes = ['월급', '주급', '시급', '시간제', '기타'];
  List<String> selectedPay = [];

  void togglePay(String pay) {
    setState(() {
      if (selectedPay.contains(pay)) {
        selectedPay.remove(pay);
      } else {
        selectedPay.add(pay);
      }
      widget.onSelectionChanged(selectedPay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: paymentTypes.map((pay) {
        bool isSelected = selectedPay.contains(pay);
        return ChoiceChip(
          label: Text(pay),
          selected: isSelected,
          onSelected: (selected) => togglePay(pay),
        );
      }).toList(),
    );
  }
}

class ChooseTimeButton extends StatefulWidget {
  final Function(List<String>) onSelectionChanged;
  const ChooseTimeButton({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  State<ChooseTimeButton> createState() => _ChooseTimeButtonState();
}

class _ChooseTimeButtonState extends State<ChooseTimeButton> {
  List<String> workdays =['주6일', '주5일', '주4일', '주3일', '주2일', '주1일',
    '월~일', '월~토', '월~금', '주말(토,일)', '기타'];
  List<String> selectedTime = [];

  void toggleTime(String time) {
    setState(() {
      if (selectedTime.contains(time)) {
        selectedTime.remove(time);
      } else {
        selectedTime.add(time);
      }
      widget.onSelectionChanged(selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: workdays.map((time) {
        bool isSelected = selectedTime.contains(time);
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (selected) => toggleTime(time),
        );
      }).toList(),
    );
  }
}
