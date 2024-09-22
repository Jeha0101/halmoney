// 작성자 : 황제하
// 하나의 경력에 대한 정보를 저장하는 클래스

class Career {
  String workDuration = '';
  String workUnit = '';
  String workPlace = '';
  String workDescription = '';

  Map<String, dynamic> toMap() {
    return {
      'workYears': workDuration,
      'workMonths': workUnit,
      'workPlace': workPlace,
      'workDescription': workDescription,
    };
  }

  String getStringCareer() {
    return '근무기간: $workDuration$workUnit, 근무지:$workPlace, 근무내용:$workDescription';
  }

  Career clone() {
    return Career()
      ..workDuration = this.workDuration
      ..workUnit = this.workUnit
      ..workPlace = this.workPlace
      ..workDescription = this.workDescription;
  }
}
