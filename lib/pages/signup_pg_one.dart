import 'package:flutter/material.dart';

class SignupPgOne extends StatelessWidget {
  const SignupPgOne ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Padding(
          padding: const EdgeInsets.only(left:30.0, right:30.0, top:80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //타이틀
              const Text(
                '본인의 정보를 입력해주세요.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w600)),

              const SizedBox(height:20),

              //성별
              const Text(
                '성별',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                  fontFamily: 'NanumGothic',
                  fontWeight: FontWeight.w500)),

              ElevatedButton(
                onPressed: (){},
                style: ButtonStyle(
                  /*
                            * MaterialState
                            * hovered: 호버링 상태 (마우스 커서를 올려둠)
                            * focused: 포커스 되었을때 (텍스트필드)
                            * pressed: 눌렀을 때
                            * dragged: 드래그 했을 때
                            * selected: 선택되었을 때(라이도, 체크박스)
                            * disabled : 비활성화 되었을 때
                            * scrollUnder: 다른 컴포넌트 밑으로 스크롤링 되었을 때
                            * error : 에러 상태
                  */
                  //버튼 색
                  backgroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states){
                      if(states.contains(MaterialState.selected)){
                        return const Color.fromARGB(250, 51, 51, 255);
                      }
                      return Colors.grey;
                    },
                  ),
                  // //글자 색
                  foregroundColor:MaterialStateProperty.resolveWith(
                           (Set<MaterialState> states){
                         if(states.contains(MaterialState.selected)){
                           return Colors.white;
                         }
                         return null;
                       },
                ),
              ),
                child: const Text(
                    "남성"
                ),
              ),
            ],
          ),
        ),
    );
  }
}