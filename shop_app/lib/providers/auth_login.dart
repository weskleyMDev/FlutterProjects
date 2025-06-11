import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class AuthLogin with ChangeNotifier {
  static AuthLogin? _instance;

  AuthLogin._internal();

  static AuthLogin get instance {
    _instance ??= AuthLogin._internal();
    return _instance!;
  }

  final rawUrl = dotenv.get('auth_url', fallback: '');
  final apiKey = dotenv.get('api_auth_key', fallback: '');

  Future<void> _authenticate(
    String email,
    String password,
    String fragUrl,
  ) async {
    final url = '$rawUrl$fragUrl';
    final uri = Uri.parse(url).replace(queryParameters: {'key': apiKey});
    try {
      final response = await post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      if (response.statusCode >= 400) {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    _authenticate(email, password, 'signInWithPassword');
  }
}
