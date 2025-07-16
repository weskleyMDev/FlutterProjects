import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../api_interface.dart';

class ApiImplementation implements ApiInterface {
  @override
  Future<Map> loadData() async {
    final String url = dotenv.get('base_url');
    final String key = dotenv.get('api_key');
    final Uri uri = Uri.https(url, '/finance', {
      'format': 'json-cors',
      'key': key,
    });
    final Response response = await get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    final Map data = json.decode(response.body);
    return data;
  }
}
