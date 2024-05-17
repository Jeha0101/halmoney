import 'package:flutter/material.dart';

class SelectStrenPage extends StatelessWidget {
  const SelectStrenPage({super.key});

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
          children: [
            const Text(
              '이력서에 추가할 본인의 장점을 선택해주세요!',
              style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 30),

            const Expanded(child: StrenChooseButton()),

            const SizedBox(height: 30),

            const TextField(
              decoration: InputDecoration(
                  labelText: '기타 장점을 작성해주세요'
              ),
            ),

            const SizedBox(height:30),

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
              child: const Text('다음 페이지로 이동',style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}

class StrenChooseButton extends StatefulWidget{
  const StrenChooseButton({super.key});

  @override
  State<StrenChooseButton> createState() => _StrenChooseButton();
}

class _StrenChooseButton extends State<StrenChooseButton>{
  //출력할 스킬 목록
  var strength =['빠른 손','대처능력','성실함','사교성','포용성','의사소통',
  '꼼꼼함','정확성','전문성','문제해결','행동력','책임감','판단력',
  '창의력','습득력','도전정신','결정력','신중함','자제력','이해심','리더십'];
  //선택한 스킬을 담을 LIST
  //List<String> skillList = List<String>();

  final List<String> selectedStren=[];

  void toggleSkill(String skill){
    setState(() {
      if(selectedStren.contains(skill)){
        selectedStren.remove(skill);
      }else{
        selectedStren.add(skill);
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
      itemCount: strength.length,
      itemBuilder: (context, index){
        final skill = strength[index];
        final isSelected = selectedStren.contains(skill);

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
              onPressed: () => toggleSkill(skill),
              child: Text(skill, style: const TextStyle(fontWeight: FontWeight.w600),),
            )
        );
      },
    );
  }
}
void main(){
  runApp(const MaterialApp(home:SelectStrenPage()));
}

