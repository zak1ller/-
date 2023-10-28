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
            future: webtoonDetail,
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
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder(
            future: webtoonEpisodes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final episode = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  episode.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
