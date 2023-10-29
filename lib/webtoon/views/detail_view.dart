import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_detail.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_episode.dart';
import 'package:flutter_test_1/webtoon/services/webtoon_api_service.dart';
import 'package:flutter_test_1/webtoon/widgets/webtoon_card.dart';
import 'package:flutter_test_1/webtoon/widgets/webtoon_episode.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences prefs;
  bool isLiked = false;
  List<String>? likedToons;

  @override
  void initState() {
    super.initState();
    webtoonDetail = WebtoonApiService.getToonById(widget.webtoon.id);
    webtoonEpisodes = WebtoonApiService.getEpisodesById(widget.webtoon.id);
    initPrefs();
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons!.contains(widget.webtoon.id)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList(
        'likedToons',
        [],
      );
    }
  }

  onLikeButtonTap() async {
    if (likedToons != null) {
      if (isLiked) {
        likedToons!.remove(widget.webtoon.id);
      } else {
        likedToons!.add(widget.webtoon.id);
      }
      await prefs.setStringList('likedToons', likedToons!);
    }
    setState(() {
      isLiked = !isLiked;
    });
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
        actions: [
          IconButton(
              onPressed: onLikeButtonTap,
              icon: isLiked
                  ? const Icon(Icons.favorite_rounded)
                  : const Icon(Icons.favorite_outline_rounded)),
        ],
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
                        child: Episode(
                          episode: episode,
                          webtoon: widget.webtoon,
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
