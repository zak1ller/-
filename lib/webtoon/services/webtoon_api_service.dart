import 'dart:convert';

import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_detail.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_episode.dart';
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

  static Future<WebtoonDetail> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetail.fromJson(webtoon);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisode>> getEpisodesById(String id) async {
    List<WebtoonEpisode> results = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (final episode in episodes) {
        results.add(WebtoonEpisode.fromJson(episode));
      }
      return results;
    } else {
      throw Error();
    }
  }
}
