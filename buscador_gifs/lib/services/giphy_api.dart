import 'dart:convert';

import 'package:buscador_gifs/app_config.dart';
import 'package:http/http.dart' as http;

class GiphyApi {
  AppConfig appConfig;

  GiphyApi(AppConfig this.appConfig);

  Future<Map> trends() async {
    final url = "${appConfig.apiBaseUrl}${appConfig.apiTrendsGifsPath}" +
        "?api_key=${appConfig.apiSecret}&limit=20&rating=g";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Future<Map> search(String term, int offset) async {
    final url = "${appConfig.apiBaseUrl}${appConfig.apiSearchGifsPath}" +
        "?api_key=${appConfig.apiSecret}&q=$term&limit=19&offset=$offset&rating=g&lang=en";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }
}
