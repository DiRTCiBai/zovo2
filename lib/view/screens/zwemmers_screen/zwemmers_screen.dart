import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/zwemmer_lijst_provider.dart';

class ZwemmersScreen extends ConsumerWidget {
  const ZwemmersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zwemmers = ref.watch(zwemmerLijstProvider).zwemmers;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final zwemmer = zwemmers[index];
          return Container(
            color: zwemmer.isAanwezig ? Colors.green : Colors.white,
            child: ListTile(
              onTap: () => ref.read(zwemmerLijstProvider).toggle(zwemmer.id),
              title: Text(zwemmer.naam),
            ),
          );
        },
        itemCount: zwemmers.length,
      ),
    );
  }
}
