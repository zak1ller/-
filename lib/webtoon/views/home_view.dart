import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/services/webtoon_api_service.dart';

class WebtoonHomeView extends StatefulWidget {
  const WebtoonHomeView({super.key});

  @override
  State<WebtoonHomeView> createState() => _WebtoonHomeViewState();
}

class _WebtoonHomeViewState extends State<WebtoonHomeView> {
  List<Webtoon> webtoons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
    setState(() {});
  }

  void waitForWebtoons() async {
    webtoons = await WebtoonApiService.getTodaysToons();
    isLoading = false;
  }

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
    );
  }
}
