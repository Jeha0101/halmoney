import 'dart:convert';
import 'package:http/http.dart';
import 'package:halmoney/address/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class AppAddressRepository {
  static final AppAddressRepository instance = AppAddressRepository._internal();

  factory AppAddressRepository() => instance;

  AppAddressRepository._internal();

  //AccessToken 받아오기
  Future<String?> getSgisApiAccessToken() async {
    try {
      const String _key = "d2ec0e8d0a054d4eaf42";
      const String _secret = "1410af31ca234fe8b355";
      http.Response _response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?consumer_key=$_key&consumer_secret=$_secret"),
      );
      if (_response.statusCode == 200) {
        Map<String, dynamic> _body =
            json.decode(_response.body) as Map<String, dynamic>;
        String _accessToken = _body["result"]["accessToken"];
        return _accessToken;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<AddressDepthServerModel>> depthAddressInformation({
    required String token,
    String? code,
  }) async {
    try {
      String? _code = code == null ? "" : "&cd=$code";
      http.Response _response = await http.get(Uri.parse(
          "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$token$_code"));
      if (_response.statusCode == 200) {
        Map<String, dynamic> _body =
            json.decode(_response.body) as Map<String, dynamic>;
        List<dynamic> _result = _body["result"];
        List<AddressDepthServerModel> _model =
            _result.map((e) => AddressDepthServerModel.fromJson(e)).toList();

        // "서울특별시"와 "경기도"만 필터링
        if (code == null){
          _model = _model.where((item) => item.name == "서울특별시" || item.name == "경기도").toList();
        }
        return _model;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
