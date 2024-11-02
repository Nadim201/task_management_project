import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_project/data/model/user_data.dart';

class AuthController {
  static String? authToken;
  static UserModel? userData;
  static const String _tokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    authToken = token;
  }

  static Future<void> saveUserData(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }
  static Future<UserModel?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataEncode = prefs.getString(_userDataKey);
    if (userDataEncode == null) {
      return null;
    }
    userData = UserModel.fromJson(jsonDecode(userDataEncode));
    return userData;
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    authToken = token;
    return authToken;
  }

  static Future<void> clearAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    authToken = null;
  }

  static Future<bool> isSignedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString(_tokenKey);
    return authToken != null;
  }
}
