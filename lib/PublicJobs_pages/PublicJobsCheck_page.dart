import 'package:flutter/material.dart';
import 'PublicJobsCheckQuestion.dart';
import 'PublicJobsDescribe.main.dart';
class PublicJobsCheckPage extends StatefulWidget {
  final String id;
  final String title;
  final String region;
  final String career;
  final String requirementsText;

  PublicJobsCheckPage({
    required this.id,
    required this.title,
    required this.region,
    required this.career,
    required this.requirementsText,
    Key? key,
  }) : super(key: key);

  @override
  _PublicJobsCheckPageState createState() => _PublicJobsCheckPageState();
}

class _PublicJobsCheckPageState extends State<PublicJobsCheckPage> {
  late Future<List<String>> _questionsFuture;
  List<bool> _isChecked = []; // To store checkbox state for each question

  @override
  void initState() {
    super.initState();
    // Generate questions based on the job details passed to this page
    _questionsFuture = QuestionGeneratorService().generateQuestionsFromText(
      title: widget.title,
      hireregion: widget.region,
      applypersoncareer: widget.career,
      text: widget.requirementsText,
    );

    // Initialize the checkbox list with false (unchecked)
    _questionsFuture.then((questions) {
      setState(() {
        _isChecked = List<bool>.filled(questions.length, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자격요건 확인하기'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Add components before the list
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '아래 자격요건을 확인하고 체크해 보세요!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '지역: ${widget.region}, 경력유무: ${widget.career}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          // Use Expanded with ListView.builder to make it scrollable
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _questionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No questions available.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(snapshot.data![index]),
                        value: _isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked[index] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, // Checkbox on the leading edge (left)
                      );
                    },
                  );
                }
              },
            ),
          ),
          // Add components after the list
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>PublicJobsDescribe(id:widget.id))
                );
              },
              child: const Text('제출하기'),
            ),
          ),
        ],
      ),
    );
  }
}