import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../exceptions/auth_exception.dart';

class AuthLogin with ChangeNotifier {
  static AuthLogin? _instance;

  AuthLogin._internal();

  static AuthLogin get instance {
    _instance ??= AuthLogin._internal();
    return _instance!;
  }

  final baseUrl = dotenv.get('firebase_url', fallback: '');
  final apiKey = dotenv.get('api_key', fallback: '');

  String? _token;
  String? _email;
  String? _uid;
  DateTime? _timeExpired;

  bool get isAuth {
    final isValid = _timeExpired?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String fragUrl,
  ) async {
    final uri = Uri.https(baseUrl, '/v1/accounts:$fragUrl', {'key': apiKey});
    try {
      final response = await post(
        uri,
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final body = jsonDecode(response.body);
      if (body['error'] != null) {
        throw AuthException(body['error']['message']);
      }
      _uid = body['localId'];
      _email = body['email'];
      _token = body['idToken'];
      _timeExpired = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async =>
      _authenticate(email, password, 'signUp');

  Future<void> signin(String email, String password) async =>
      _authenticate(email, password, 'signInWithPassword');
}
