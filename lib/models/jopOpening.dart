import 'dart:ffi';

class JopOpening{
  final String id;
  final String title;
  final String address_first;
  final String address_second;
  final String address_third;
  final String address_fourth;
  final String wage;
  bool scrap;
  bool ongoing;

  JopOpening({
    required this.id,
    required this.title,
    required this.address_first,
    required this.address_second,
    required this.address_third,
    required this.address_fourth,
    required this.wage,
    required this.scrap,
    required this.ongoing,
  });
}

List<JopOpening> jopOpenings =[
  JopOpening(
      id: '스타벅스',
      title: '함께 근무할 크루 모집합니다.',
      address_first: '서울시',
      address_second: '강동구',
      address_third: '강일동',
      address_fourth: '',
      wage: '9860',
      scrap: true,
      ongoing: true,),
  JopOpening(
      id: '쿠팡',
      title: '물류센터 재고 정리',
      address_first: '서울시',
      address_second: '강동구',
      address_third: '고덕1동',
      address_fourth: '',
      wage: '9860',
      scrap: false,
      ongoing: false,),
  JopOpening(
      id: '행복요양원',
      title: '어르신 산책 도우미',
      address_first: '서울시',
      address_second: '강동구',
      address_third: '강일동',
      address_fourth: '',
      wage: '9860',
      scrap: true,
      ongoing: false),
];