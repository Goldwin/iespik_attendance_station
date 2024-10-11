import 'package:shared_preferences/shared_preferences.dart';

const String tokenKey = 'token';

Future<String> getToken() async {
  var pref = await SharedPreferences.getInstance();
  return pref.getString(tokenKey)!;
}

Future<bool> isLoggedIn() async {
  var pref = await SharedPreferences.getInstance();
  return pref.containsKey(tokenKey);
}

