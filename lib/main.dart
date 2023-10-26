import 'package:flutter/material.dart';
import 'package:flutter_test_1/pomodoro/views/pomodoro_home.dart';
import 'package:flutter_test_1/webtoon/views/home_view.dart';
// import 'package:flutter_test_1/ui_test/source/ui_test_home.dart';
import 'package:logging/logging.dart';

final log = Logger("Logger");

void main() {
  // Logger 설정
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  // runApp(const UITestHome());
  runApp(const WebtoonApp());
}

class WebtoonApp extends StatelessWidget {
  const WebtoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebtoonHomeView(),
    );
  }
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardColor: const Color(0xFFF4EDDB),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFe7626C),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
