import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/models/webtoon_episode.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoon,
  });

  final WebtoonEpisode episode;
  final Webtoon webtoon;

  _onEpisodeTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=${webtoon.id}&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onEpisodeTap,
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
  }
}
