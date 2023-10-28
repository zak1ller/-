import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_detail.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_episode.dart';
import 'package:flutter_test_1/webtoon/services/webtoon_api_service.dart';
import 'package:flutter_test_1/webtoon/widgets/webtoon_card.dart';

class DetailView extends StatefulWidget {
  const DetailView({
    super.key,
    required this.webtoon,
  });

  final Webtoon webtoon;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Future<WebtoonDetail> webtoonDetail;
  late Future<List<WebtoonEpisode>> webtoonEpisodes;

  @override
  void initState() {
    super.initState();
    webtoonDetail = WebtoonApiService.getToonById(widget.webtoon.id);
    webtoonEpisodes = WebtoonApiService.getEpisodesById(widget.webtoon.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
        title: Text(widget.webtoon.title),
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
                webtoon: widget.webtoon,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('...');
              }
            },
            future: webtoonDetail,
          )
        ],
      ),
    );
  }
}
