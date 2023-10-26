import 'package:flutter/material.dart';

class WebtoonHomeView extends StatelessWidget {
  const WebtoonHomeView({super.key});

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
