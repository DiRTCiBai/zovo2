import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  static const route = "/StartScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/startScreen/AfnemenScreen/afnemen'),
              child: const Text("Aanwezigheden"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/startScreen/AfnemenScreen/testen'),
              child: const Text("Testen"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/startScreen/ZwemmersScreen'),
              child: const Text("Zwemmers"),
            ),
          ],
        ),
      ),
    );
  }
}
