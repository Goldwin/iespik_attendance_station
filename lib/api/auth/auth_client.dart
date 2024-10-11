import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String authUrl = 'https://api.brightfellow.net/app';

class AuthData {}

class _Auth {
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    var body =
        jsonEncode(<String, String>{'email': email, 'password': password});
    return post(Uri.parse('$authUrl/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body)
        .then((response) {
      if (response.statusCode != 200) {
        Map<String, dynamic> errBody =
            jsonDecode(response.body) as Map<String, dynamic>;
        return false;
      }
      Map<String, dynamic> respBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      String token = respBody['data']['token'];
      prefs.setString('token', token);
      return true;
    }).onError((e, s) {
      return false;
    });
  }
}

var authApiClient = _Auth();
