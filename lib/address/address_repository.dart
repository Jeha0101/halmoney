import 'dart:convert';
import 'package:halmoney/address/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppAddressRepository {
  static final AppAddressRepository instance = AppAddressRepository._internal();

  factory AppAddressRepository() => instance;

  AppAddressRepository._internal();

  //AccessToken 받아오기
  Future<String?> getSgisApiAccessToken() async {
    try {
      final String key = dotenv.get('ADDRESS_API_KEY');
      final String secret = dotenv.get('ADDRESS_API_SECRET');
      http.Response response = await http.get(
        Uri.parse(
            "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?consumer_key=$key&consumer_secret=$secret"),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;
        String accessToken = body["result"]["accessToken"];
        return accessToken;
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
      String? code0 = code == null ? "" : "&cd=$code";
      http.Response response = await http.get(Uri.parse(
          "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?accessToken=$token$code0"));
      if (response.statusCode == 200) {
        Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;
        List<dynamic> result = body["result"];
        List<AddressDepthServerModel> model =
        result.map((e) => AddressDepthServerModel.fromJson(e)).toList();

        // "서울특별시"와 "경기도"만 필터링
        if (code == null){
          model = model.where((item) => item.name == "서울특별시" || item.name == "경기도").toList();
        }
        return model;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
