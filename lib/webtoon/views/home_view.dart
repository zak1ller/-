import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/services/webtoon_api_service.dart';

class WebtoonHomeView extends StatelessWidget {
  WebtoonHomeView({super.key});

  Future<List<Webtoon>> webtoons = WebtoonApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
        title: const Text("Today's toons"),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("There is data!");
          } else {
            return const Text("Loading...");
          }
        },
      ),
    );
  }
}
