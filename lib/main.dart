import 'package:flutter/material.dart';
import 'package:flutter_test_1/pomodoro/source/pomodoro_home.dart';
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
  runApp(const PomodoroHome());
}
