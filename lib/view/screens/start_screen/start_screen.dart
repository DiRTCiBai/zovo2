import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/zwemmer_lijst_provider.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(zwemmerLijstProvider).init();
  }

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
              onPressed: () {
                ref.read(zwemmerLijstProvider).setAfnemenMode(true);
                context.go('/startScreen/AfnemenScreen');
              },
              child: const Text("Aanwezigheden"),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(zwemmerLijstProvider).setAfnemenMode(false);
                context.go('/startScreen/AfnemenScreen');
              },
              child: const Text("Testen"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/startScreen/ZwemmersScreen'),
              child: const Text("Zwemmers"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/startScreen/ExportImportScreen'),
              child: const Text("Export"),
            ),
          ],
        ),
      ),
    );
  }
}
