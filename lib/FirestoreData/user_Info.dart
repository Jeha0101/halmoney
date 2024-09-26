// 작성자 : 황제하
// 사용자 기본 정보를 불러오고 수정하는 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halmoney/get_user_info/career.dart';

class UserInfo {
  late String userName;
  late String userId;
  late String userPhone;
  late String userGender;
  late String userAgeGroup;
  late String userAddress;
  late List<Career> careers;
  late List<String> selectedFields;
  late List<String> preferredWorkTime;
  late List<String> preferredWorkPlace;

  UserInfo._create(this.userId);

  static Future<UserInfo> create(String userId) async{
    UserInfo userInfo = UserInfo._create(userId);
    await userInfo._fetchUserInfo(userId);
    return userInfo;
  }

  //사용자 기본 정보 불러오기
  Future<void> _fetchUserInfo(String userId) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: userId)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if (documents.isNotEmpty) {
        final String docId = documents.first.id;

        final DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection('user').doc(docId).get();

        final data = ds.data() as Map<String, dynamic>;

        userName = data['name'] ?? '';
        this.userId = userId;
        userPhone = data['phone'] ?? '';
        userGender = data['gender'] ?? '';
        userAgeGroup = data['ageGroup'] ?? '';
        userAddress = data['address'] ?? '';
        selectedFields = data['selectedFields'] != null ? List<String>.from(data['selectedFields']) : []; //수정한 부분
        preferredWorkTime = data['preferredWorkTime'] != null ? List<String>.from(data['preferredWorkTime']) : []; //수정한 부분
        preferredWorkPlace = data['preferredWorkPlace'] != null ? List<String>.from(data['preferredWorkPlace']) : []; //수정한 부분

        if (data['careers'] != null && data['careers'] is List) {
          careers = (data['careers'] as List)
              .map((careerData) => Career.fromMap(careerData as Map<String, dynamic>))
              .toList();
        } else {
          careers = [];
        }

      }
    } catch (error) {
      print('Failed to fetch user info: $error');
    }
  }

  // 사용자 정보 업데이트 메소드
  Future<void> updateUserInfo() async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userId)
          .update({
        'name': userName,
        'phone': userPhone,
        'gender': userGender,
        'ageGroup': userAgeGroup,
        'address': userAddress,
        'careers': careers.map((career) => career.toMap()).toList(),
        'selectedFields': selectedFields,
        'preferredWorkTime': preferredWorkTime,
        'preferredWorkPlace': preferredWorkPlace,
      });
      print('User info updated successfully.');
    } catch (error) {
      print('Failed to update user info: $error');
    }
  }

  String getId() {
    return userId;
  }
  String getUserName() {
    return userName;
  }
  String getUserAddress(){
    return userAddress;
  }
  String gerUserPhone(){
    return userPhone;
  }
  String getUserGender(){
    return userGender;
  }
  String getUserAgeGroup(){
    return userAgeGroup;
  }

  // 지원 분야 메소드
  void editSelectedFields(List<String> selectedFields) {
    this.selectedFields = selectedFields;
  }
  List<String> getSelectedFields() {
    return selectedFields;
  }

  // 경력 메소드
  void editCareers(List<Career> careers) {
    this.careers = careers;
  }
  List<Career> getCareers() {
    return careers;
  }

  //userInfo 디버깅
  void printUserInfo(){
    print("사용자 이름 : $userName");
    print("사용자 번호 : $userPhone");
    print("사용자 성별 : $userGender");
    print("사용자 나이 : $userAgeGroup");
    print("사용자 주소 : $userAddress");
  }
}