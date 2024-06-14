import 'package:flutter/material.dart';
import 'package:halmoney/AI_pages/cond_search_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AISelectCondPage extends StatefulWidget {
  final String id;
  const AISelectCondPage({super.key, required this.id});

  @override
  _AISelectCondPage createState() => _AISelectCondPage();
}

class _AISelectCondPage extends State<AISelectCondPage> {
  final TextEditingController addressController = TextEditingController();

  Future<void> _AIrecommCondition(BuildContext context, List<String> selectedJobs,
      List<String> selectedPay, List<String> selectedTime) async {
    final seladdress = addressController.text;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      //사용자의 구인공고 필터링 조건을 Firestore에 저장
      final QuerySnapshot result = await firestore
          .collection('user')
          .where('id', isEqualTo: widget.id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        var addressParts = seladdress.split(',');
        var selectedGugun = addressParts.length > 1 ? addressParts[1].trim(): '';

        await firestore
            .collection('user')
            .doc(docId)
            .collection('AIRecommendation')
            .doc('recomCondition')
            .set({
          'location': seladdress,
          'job_type': selectedJobs,
          'payment_type': selectedPay,
          'working_days': selectedTime,
        });

        //구인 공고 필터링
        Query jobQuery = firestore.collection('jobs');


        final QuerySnapshot jobResult = await jobQuery.get();
        final List<DocumentSnapshot> jobDocuments = jobResult.docs;

        //공고 필터링
        final filteredJobs = jobDocuments.where((job){
          final jobData = job.data() as Map<String, dynamic>;

          final address = jobData['address'] as String;
          final jobName = jobData['job_name'] as String;
          final wage = jobData['wage'] as String;
          final workTimeWeek = jobData['work_time_week'] as String;

          final addMatch =  selectedGugun.isEmpty || address.contains(selectedGugun);
          final jobMatch = selectedJobs.isEmpty || selectedJobs.any((job) => jobName.contains(job));
          final payMatch = selectedPay.isEmpty || selectedPay.any((pay) => wage.contains(pay));
          final timeMatch = selectedTime.isEmpty || selectedTime.any((time) => workTimeWeek.contains(time));

          return addMatch && jobMatch && payMatch && timeMatch;
        }).toList();

        print('Filtered jobs count:${filteredJobs.length}');
        if(filteredJobs.isNotEmpty){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CondSearchResultPage(jobs: filteredJobs))
          );
        } else {
          print('No matching jobs found');
          _showNoJobsDialog(context);
        }

        print("Interest place updated successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("관심 지역이 성공적으로 업데이트 되었습니다.")),
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

  //조건에 맞는 공고 없을 시 팝업
  void _showNoJobsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('조건에 맞는 공고가 없습니다!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }


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
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 30.0, top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '이런 조건을 원해요!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                '근무지역',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonExample(addressController: addressController),

              const SizedBox(height: 40),

              const Text(
                '업직종',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const SizedBox(
                height: 330,
                child: ChooseJobButton(),
              ),

              const SizedBox(height: 40),

              const Text(
                '급여형태',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const SizedBox(
                height: 130,
                child: ChoosePayButton(),
              ),

              const SizedBox(height: 40),

              const Text(
                '근무시간',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const SizedBox(
                height: 260,
                child: ChooseTimeButton(),
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
                onPressed: () {
                  final selectedJobs = ChooseJobButton.selectedJobs;
                  final selectedPay = ChoosePayButton.selectedPay;
                  final selectedTime = ChooseTimeButton.selectedTime;
                  _AIrecommCondition(context, selectedJobs, selectedPay, selectedTime);
                },
                child: const Text(
                  '결과보기',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

//근무시간
class ChooseTimeButton extends StatefulWidget {
  const ChooseTimeButton({super.key});

  static List<String> selectedTime = [];
  @override
  State<ChooseTimeButton> createState() => _ChooseTimeButton();
}

class _ChooseTimeButton extends State<ChooseTimeButton> {
  var workdays = ['주6일', '주5일', '주4일', '주3일', '주2일', '주1일',
  '월~일', '월~토', '월~금', '주말(토,일)', '기타'];


  void toggleSkill(String time) {
    setState(() {
      if (ChooseTimeButton.selectedTime.contains(time)) {
        ChooseTimeButton.selectedTime.remove(time);
      } else {
        ChooseTimeButton.selectedTime.add(time);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = 100;
    final double itemWidth = size.width / 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: (itemWidth / itemHeight)),
      itemCount: workdays.length,
      itemBuilder: (context, index) {
        final time = workdays[index];
        final isSelected = ChooseTimeButton.selectedTime.contains(time);

        return ButtonTheme(
            minWidth: 70.0,
            height: 30.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isSelected ? Colors.blue : const Color.fromARGB(250, 255, 255, 250),
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () => toggleSkill(time),
              child: Text(
                time,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
            ));
      },
    );
  }
}

//급여지급 형태
class ChoosePayButton extends StatefulWidget {
  const ChoosePayButton({super.key});

  static List<String> selectedPay = [];

  @override
  State<ChoosePayButton> createState() => _ChoosePayButton();
}

class _ChoosePayButton extends State<ChoosePayButton> {
  var payment = ['월급', '주급', '시급', '시간제', '기타'];

  void toggleSkill(String pay) {
    setState(() {
      if (ChoosePayButton.selectedPay.contains(pay)) {
        ChoosePayButton.selectedPay.remove(pay);
      } else {
        ChoosePayButton.selectedPay.add(pay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = 100;
    final double itemWidth = size.width / 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: (itemWidth / itemHeight)),
      itemCount: payment.length,
      itemBuilder: (context, index) {
        final pay = payment[index];
        final isSelected = ChoosePayButton.selectedPay.contains(pay);

        return ButtonTheme(
            minWidth: 70.0,
            height: 30.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isSelected ? Colors.blue : const Color.fromARGB(250, 255, 255, 250),
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () => toggleSkill(pay),
              child: Text(
                pay,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
            ));
      },
    );
  }
}

class ChooseJobButton extends StatefulWidget {
  const ChooseJobButton({super.key});

  static List<String> selectedJobs = [];
  @override
  State<ChooseJobButton> createState() => _ChooseJobButton();
}

class _ChooseJobButton extends State<ChooseJobButton> {
  var jobs = ['음료 조리','요양', '간병', '안내', '청소', '사무', '교사', '주방',
    '사회복지사', '디자이너', '조리사', '영업', '기획', '환경 미화','운전',
    'IT','생산','판매','배달','방송','안전'];

  void toggleSkill(String job) {
    setState(() {
      if (ChooseJobButton.selectedJobs.contains(job)) {
        ChooseJobButton.selectedJobs.remove(job);
      } else {
        ChooseJobButton.selectedJobs.add(job);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = 100;
    final double itemWidth = size.width / 2;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: (itemWidth / itemHeight)),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        final isSelected = ChooseJobButton.selectedJobs.contains(job);

        return ButtonTheme(
            minWidth: 70.0,
            height: 30.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isSelected ? Colors.blue : const Color.fromARGB(250, 255, 255, 250),
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () => toggleSkill(job),
              child: Text(
                job,
                style: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
            ));
      },
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 180,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton<String>(
                itemHeight: 60,
                isExpanded: true,
                value: selectedSido.isNotEmpty ? selectedSido : null,
                onChanged: (value) {
                  setState(() {
                    selectedSido = value!;
                    selectedGugun = gugun[0][0];
                    widget.addressController.text = '$selectedSido, $selectedGugun';
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

            Container(
              width: 180,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 60,
              child: DropdownButton<String>(
                itemHeight: 60,
                isExpanded: true,
                value: selectedGugun.isNotEmpty ? selectedGugun : null,
                onChanged: (value) {
                  setState(() {
                    selectedGugun = value!;
                    widget.addressController.text = '$selectedSido, $selectedGugun';
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
          ],
        ));
  }
}
