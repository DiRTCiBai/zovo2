import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zovo2/view/screens/afnemen_screen/search/afnemen_search_delegate.dart';

import '../../../provider/zwemmer_lijst_provider.dart';

class AfnemenScreen extends ConsumerWidget {
  const AfnemenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(zwemmerLijstProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (provider.mode) {
            context.pop();
          } else {
            context.go('/startScreen/AfnemenScreen/test/TestScreen');
          }
        },
        child: provider.mode ? const Text("Save") : const Text("Test"),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: AfnemenSearchDelegate(ref: ref));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  final groep = provider.groepen[index];

                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          provider.currentGroep == provider.groepen[index] ? Colors.green : Colors.blue),
                    ),
                    onPressed: () {
                      provider.changeGroep(groep);
                    },
                    child: Text(groep),
                  );
                },
                itemCount: provider.groepen.length,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final zwemmer = provider.afnemenZwemmers[index];
                return Container(
                  color: zwemmer.isSelected ? Colors.green : Colors.white,
                  child: ListTile(
                    onTap: () => provider.toggle(zwemmer.zwemmerId),
                    title: Text(zwemmer.naam),
                    trailing: Text("${zwemmer.niveau}"),
                  ),
                );
              },
              childCount: provider.afnemenZwemmers.length,
            ),
          ),
        ],
      ),
    );
  }
}
