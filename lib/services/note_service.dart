import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/note.dart';
import 'auth_service.dart';

class NoteService {

  static const String baseUrl = "http://localhost:3000/api";

  Future<List<Note>> getNotes() async {

    final token =
        await AuthService().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/notes"),
      headers: {
        "Authorization":
            "Bearer $token"
      },
    );

    if (response.statusCode == 200) {

      final List data =
          jsonDecode(response.body);

      return data
          .map((e) => Note.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<void> addNote(
    String title,
    String content,
  ) async {

    final token =
        await AuthService().getToken();

    await http.post(
      Uri.parse("$baseUrl/notes"),
      headers: {
        "Content-Type":
        "application/json",
        "Authorization":
        "Bearer $token"
      },
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );
  }

  Future<void> editNote(
    int id,
    String title,
    String content,
  ) async {

    final token =
        await AuthService().getToken();

    await http.put(
      Uri.parse("$baseUrl/notes/$id"),
      headers: {
        "Content-Type":
        "application/json",
        "Authorization":
        "Bearer $token"
      },
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );
  }

  Future<void> deleteNote(
      int id) async {

    final token =
        await AuthService().getToken();

    await http.delete(
      Uri.parse("$baseUrl/notes/$id"),
      headers: {
        "Authorization":
            "Bearer $token"
      },
    );
  }
}