import 'package:shared_preferences/shared_preferences.dart';

const String tokenKey = 'token';
const String tokenExpiredAtKey = 'tokenExpiredAt';

Future<String> getToken() async {
  var pref = await SharedPreferences.getInstance();
  String token = pref.getString(tokenKey) ?? "";
  int tokenExpiredAt = pref.getInt(tokenExpiredAtKey) ?? 0;

  if (token.isNotEmpty && tokenExpiredAt < DateTime.now().second) {
    pref.remove(tokenKey);
    pref.remove(tokenExpiredAtKey);
    return "";
  }

  return token;
}

Future<void> setToken(String token) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString(tokenKey, token);

  int tokenExpiredAt = DateTime.now().second + 7 * 24 * 60 * 60;
  pref.setInt('tokenExpiredAt', tokenExpiredAt);
}

Future<void> removeToken() async {
  var pref = await SharedPreferences.getInstance();
  pref.remove(tokenKey);
  pref.remove(tokenExpiredAtKey);
}

Future<bool> isLoggedIn() async {
  var token = await getToken();
  return token.isNotEmpty;
}

