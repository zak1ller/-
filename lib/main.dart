import 'package:flutter/material.dart';
import 'package:flutter_test_1/ui_test/source/ui_test_home.dart';
import 'package:logging/logging.dart';

final log = Logger("Logger");

void main() {
  // Logger 설정
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  // runApp(const UITestApp());
  runApp(const PomodoroApp());
}

class UITestApp extends StatelessWidget {
  const UITestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UITestHome(),
    );
  }
}

class PomodoroApp extends StatefulWidget {
  const PomodoroApp({super.key});

  @override
  State<PomodoroApp> createState() => _PomorodoAppState();
}

class _PomorodoAppState extends State<PomodoroApp> {
  int counter = 0;

  void onClickCountButton() {
    setState(() {
      counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Click count'),
              Text('$counter'),
              IconButton(
                onPressed: onClickCountButton,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
