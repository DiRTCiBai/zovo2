import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/zwemmer_lijst_provider.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({Key? key}) : super(key: key);

  static const route = "/StartScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(zwemmerLijstProvider).setMode(true);
                context.go('/startScreen/AfnemenScreen');
              },
              child: const Text("Aanwezigheden"),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(zwemmerLijstProvider).setMode(false);
                context.go('/startScreen/AfnemenScreen');
              },
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
