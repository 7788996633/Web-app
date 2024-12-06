// import 'package:shared_preferences/shared_preferences.dart';

// class PreferencesHelper {
//   static const String _tokenKey = "TOKEN_KEY";

//   static Future<void> saveToken(String token) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }
// }
