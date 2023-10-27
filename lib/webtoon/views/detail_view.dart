import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/widgets/webtoon_card.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    super.key,
    required this.webtoon,
  });

  final Webtoon webtoon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
        title: Text(webtoon.title),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WebtoonCard(
                webtoon: webtoon,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
