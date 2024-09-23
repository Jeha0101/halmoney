// 작성자 : 황제하
// 사용자 기본 정보를 불러오고 수정하는 클래스

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halmoney/get_user_info/career.dart';

class UserInfo {
  late String userName='';
  late String userId;
  late String userPhone;
  late String userGender;
  late String userDob;
  late String userAddress;
  List<Career> careers=[];
  List<String> selectedFields=[];
  List<String> preferredWorkTime=[];
  List<String> preferredWorkPlace=[];

  UserInfo(String userId) {
    _fetchUserInfo(userId);
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
        userPhone = data['userPhone'] ?? '';
        userGender = data['userGender'] ?? '';
        userDob = data['userDob'] ?? '';
        userAddress = data['userAddress'] ?? '';
      }
    } catch (error) {
      print('Failed to fetch user info: $error');
    }
  }



  String getId() {
    return userId;
  }
  String getUserName() {
    return userName;
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
}
