import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {

  static String get baseUrl {

    if (kIsWeb) {
      return "http://localhost:3000/api";
    }

    return "http://10.0.2.2:3000/api";
  }

  static Future<http.Response> get(
      String endpoint,
      String token) {

    return http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Authorization": "Bearer $token"
      },
    );
  }

  static Future<http.Response> post(
      String endpoint,
      Map<String, dynamic> body,
      String token) {

    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: body,
    );
  }
}