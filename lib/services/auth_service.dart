import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String baseUrl = "http://localhost:3000/api";

  Future<bool> login(
      String username,
      String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "username": username,
        "password": password
      }),
    );

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      final prefs =
          await SharedPreferences.getInstance();

      await prefs.setString(
          "token",
          data["token"]);

      return true;
    }

    return false;
  }

  Future<bool> register(
      String username,
      String password) async {

    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "username": username,
        "password": password
      }),
    );

    return response.statusCode == 200;
  }

  Future<String?> getToken() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString("token");
  }

  Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();
  }
}