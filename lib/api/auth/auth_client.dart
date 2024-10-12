import 'dart:convert';

import 'package:http/http.dart';
import 'package:iespik_attendance_station/commons/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authUrl = 'https://api.brightfellow.net/app';

class AuthData {
  String? token;

  AuthData.withToken(this.token);

  AuthData();
}

class _Auth {
  Future<AuthData> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
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
      APIResponse<AuthData> apiResponse = APIResponse<AuthData>.fromJson(x);
      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }
      Map<String, dynamic> respBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      String token = respBody['data']['token'];
      prefs.setString('token', token);
      int tokenExpiredAt = DateTime.now().second + 7 * 24 * 60 * 60;
      prefs.setInt('tokenExpiredAt', tokenExpiredAt);
      return AuthData.withToken(token);
    });
  }
}

var authApiClient = _Auth();
