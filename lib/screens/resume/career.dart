class Career {
  String startYear = '';
  String startMonth = '';
  String endYear = '';
  String endMonth = '';
  String place = '';
  String description = '';

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'startYear': startYear,
      'startMonth': startMonth,
      'endYear': endYear,
      'endMonth': endMonth,
      'description': description,
    };
  }

  String getStringCareer() {
    return '근무시작:$startYear년-$startMonth, 근무종료:$endYear년-$endMonth, 근무지:$place, 근무내용:$description';
  }
}
