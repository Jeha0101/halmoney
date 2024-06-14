import 'package:flutter/material.dart';
import 'package:halmoney/pages/select_place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SelectInterest extends StatelessWidget {
  final String id;
  const SelectInterest({super.key, required this.id});

  void _saveData(BuildContext context, List<String> selectedInterests) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        for (String interest in selectedInterests) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(docId)
              .collection('Interest')
              .doc('interests_work')
              .set({'int_work': selectedInterests});
        }

        print("Interests updated successfully");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Interests updated successfully")),
        );
      } else {
        print("User not found");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
      }
    } catch (error) {
      print("Failed to update interests: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update interests: $error")),
      );
    }
  }


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
      body: Padding(
        padding: const EdgeInsets.only(left:25.0, right:30.0, top:50.0),
        child: Column(
          //왼쪽 맞춤 정렬
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '관심사를 모두 선택해주세요!',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            const Text(
              '선택한 관심사를 기반으로 모집공고를 추천드립니다.',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(child: InterestButton(id:id)),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //backgroundColor: _buttonActive ? const Color.fromARGB(250, 51, 51, 255) : Colors.grey,
                  backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                  minimumSize: const Size(360,50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),
              onPressed: () {
                final selectedInterests = InterestButton.selectedInterests;
                _saveData(context, selectedInterests);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectPlace(id: id))
                );
              },
              child: const Text('선택 완료',style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}

class InterestButton extends StatefulWidget{
  final String id;
  const InterestButton({super.key, required this.id});

  static List<String> selectedInterests=[];

  @override
  State<InterestButton> createState() => _InterestButton();
}


class _InterestButton extends State<InterestButton>{
  //출력할 스킬 목록
  var interests =['음료 조리','요양', '간병', '안내', '청소', '사무', '교사', '주방',
    '사회복지사', '디자이너', '조리사', '영업', '기획', '환경 미화','운전',
    'IT','생산','판매','배달','방송','안전'];
  //선택한 스킬을 담을 LIST
  //List<String> skillList = List<String>();


  void toggleInterest(String interest){
    setState(() {
      if(InterestButton.selectedInterests.contains(interest)){
        InterestButton.selectedInterests.remove(interest);
      }else{
        InterestButton.selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    const double itemHeight = 100;
    final double itemWidth = size.width/2;

    return GridView.builder(

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount : 3,
          crossAxisSpacing : 16.0,
          mainAxisSpacing : 16.0,
          childAspectRatio: (itemWidth/itemHeight)
      ),
      itemCount: interests.length,
      itemBuilder: (context, index){
        final interest = interests[index];
        final isSelected = InterestButton.selectedInterests.contains(interest);

        return ButtonTheme(
            minWidth: 100.0,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.blue : Colors.white70,
                  foregroundColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))
              ),
              onPressed: () => toggleInterest(interest),
              child: Text(interest, style: const TextStyle(fontWeight: FontWeight.w600),),
            )
        );
      },
    );
  }
}
/*void main(){
  runApp(const MaterialApp(home:SelectInterest()));
}*/
