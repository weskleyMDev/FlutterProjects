import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../data/store_session.dart';
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
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _timeExpired?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token => isAuth ? _token : null;

  String? get email => isAuth ? _email : null;

  String? get uid => isAuth ? _uid : null;

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
      StoreSession.saveMap('userData', {
        'token': _token,
        'email': _email,
        'uid': _uid,
        'timeExpired': _timeExpired?.toIso8601String(),
      });
      _autoLogout();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async =>
      _authenticate(email, password, 'signUp');

  Future<void> signin(String email, String password) async =>
      _authenticate(email, password, 'signInWithPassword');

  Future<void> tryAutoLogin() async {
    if (isAuth) return;
    final userData = await StoreSession.getMap('userData');
    if (userData.isEmpty) return;
    final expiryTime = DateTime.parse(userData['timeExpired']);
    if (expiryTime.isBefore(DateTime.now())) return;
    _uid = userData['uid'];
    _email = userData['email'];
    _token = userData['token'];
    _timeExpired = expiryTime;

    _autoLogout();
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _email = null;
    _uid = null;
    _timeExpired = null;
    _clearAutoLogout();
    await StoreSession.remove('userData');
    notifyListeners();
  }

  void _clearAutoLogout() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearAutoLogout();
    final timer = _timeExpired?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timer ?? 0), logout);
  }
}
