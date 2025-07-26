import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import 'iapi_service.dart';

class ApiService implements IApiService {
  final _url = dotenv.get('base_url');
  final _apiKey = dotenv.get('api_key');

  @override
  Future<Map<String, dynamic>> getData({String? query}) async {
    try {
      final search = (query == null || query.isEmpty) ? null : query;
      final dataUri = (search == null)
          ? Uri.https(_url, '/v1/gifs/trending', {
              'api_key': _apiKey,
              'limit': '10',
              'offset': '10',
              'rating': 'g',
              'bundle': 'messaging_non_clips',
            })
          : Uri.https(_url, '/v1/gifs/search', {
              'api_key': _apiKey,
              'q': search,
              'limit': '10',
              'offset': '10',
              'rating': 'g',
              'lang': 'en',
              'bundle': 'messaging_non_clips',
            });
      final response = await get(dataUri);
      if (response.statusCode >= 400) {
        throw Exception('Erro: ${response.statusCode}');
      } else {
        final data = json.decode(response.body);
        return Map.from(data);
      }
    } catch (e) {
      throw Exception('Erro ao acessar a API: $e!');
    }
  }
}
