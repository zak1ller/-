import 'package:flutter/material.dart';
import 'package:flutter_test_1/webtoon/models/webtoon.dart';
import 'package:flutter_test_1/webtoon/services/webtoon_api_service.dart';

class WebtoonHomeView extends StatelessWidget {
  WebtoonHomeView({super.key});

  final Future<List<Webtoon>> webtoons = WebtoonApiService.getTodaysToons();

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
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final webtoon = snapshot.data![index];
                      return Column(
                        children: [
                          Container(
                            width: 250,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  offset: const Offset(
                                    10,
                                    10,
                                  ),
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Image.network(
                              webtoon.thumb,
                              headers: const {
                                "User-Agent":
                                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            webtoon.title,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
