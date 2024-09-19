import 'package:halmoney/get_user_info/career.dart';

class UserInfo {
  String userId = '';
  List<String> selectedFields = [];
  List<String> selectedStrens = [];
  List<Career> careers = [];
  int quantity = 0;

  UserInfo(String id) {
    userId = id;
    selectedFields = [];
    selectedStrens = [];
    careers = [];
    quantity = 0;
  }

  String getId() {
    return userId;
  }

  // 지원 분야 메소드
  void editSelectedFields(List<String> selectedFields) {
    this.selectedFields = selectedFields;
  }
  List<String> getSelctedFields() {
    return selectedFields;
  }

  // 역량 메소드
  void editSelectedStrens(List<String> selectedStrens) {
    this.selectedStrens = selectedStrens;
  }
  List<String> getSelctedStrens() {
    return selectedStrens;
  }

  // 경력 메소드
  void editCareers(List<Career> careers) {
    this.careers = careers;
  }
  List<Career> getCareers() {
    return careers;
  }

  // 분량 메소드
  void editQuantity(int quantity) {
    this.quantity = quantity;
  }
  int getQuantity() {
    return quantity;
  }
}
