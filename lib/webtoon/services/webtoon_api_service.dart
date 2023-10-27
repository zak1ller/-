import 'dart:convert';

import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:http/http.dart' as http;

class WebtoonApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const today = "today";

  static Future<List<Webtoon>> getTodaysToons() async {
    List<Webtoon> resultList = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        resultList.add(Webtoon.fromJason(webtoon));
      }
      return resultList;
    } else {
      throw Error();
    }
  }
}
