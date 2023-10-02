import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService{
  static const jwtToken = 'authorizationToken';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(jwtToken);
    return token;
  }

  static Future<bool> setToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(jwtToken, token ?? '');
    return true;
  }
}