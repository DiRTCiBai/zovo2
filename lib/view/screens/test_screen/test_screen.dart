import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zovo2/provider/zwemmer_lijst_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(zwemmerLijstProvider);

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Text("Test 1"),
                Divider(),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final zwemmer = provider.oefening1()[index];
                return Container(
                  color: zwemmer.statusOef ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () => provider.toggleTest(zwemmer.zwemmerId, 1),
                    leading: Text(zwemmer.naam),
                    title: Text(zwemmer.oef),
                    trailing: Icon(zwemmer.statusOef ? Icons.check : Icons.add),
                  ),
                );
              },
              childCount: provider.oefening1().length,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Text("Test 2"),
                Divider(),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final zwemmer = provider.oefening2()[index];
                return Container(
                  color: zwemmer.statusOef ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () => provider.toggleTest(zwemmer.zwemmerId, 2),
                    leading: Text(zwemmer.naam),
                    title: Text(zwemmer.oef),
                    trailing: Icon(zwemmer.statusOef ? Icons.check : Icons.add),
                  ),
                );
              },
              childCount: provider.oefening2().length,
            ),
          ),
        ],
      ),
    );
  }
}
