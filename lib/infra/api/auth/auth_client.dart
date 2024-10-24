import 'dart:convert';

import 'package:http/http.dart';
import 'package:iespik_attendance_station/commons/auth.dart';
import 'package:iespik_attendance_station/commons/response.dart';

const String authUrl = 'https://api.brightfellow.net/app';

class AuthData {
  String? token;

  AuthData.withToken(this.token);

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData.withToken(json['token']);
  }

  AuthData();
}

class _Auth {
  Future<AuthData> login(String email, String password) async {
    var body =
        jsonEncode(<String, String>{'email': email, 'password': password});
    return post(Uri.parse('$authUrl/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body)
        .then((response) {
      Map<String, dynamic> x =
          jsonDecode(response.body) as Map<String, dynamic>;
      APIResponse<AuthData> apiResponse =
          APIResponse<AuthData>.fromJson(x, AuthData.fromJson);
      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }
      String token = apiResponse.data?.token ?? "";
      setToken(token);
      return AuthData.withToken(token);
    });
  }
}

var authApiClient = _Auth();
