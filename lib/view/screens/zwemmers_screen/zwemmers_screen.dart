import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../provider/zwemmer_lijst_provider.dart';

class ZwemmersScreen extends ConsumerWidget {
  const ZwemmersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(zwemmerLijstProvider);

    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    String filter = provider.filters[index];
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            provider.currentGroep == filter
                                ? Colors.green
                                : Colors.blue),
                      ),
                      onPressed: () {
                        provider.setFilter(filter);
                      },
                      child: Text(filter),
                    );
                  },
                  itemCount: provider.filters.length, //provider.groepen.length,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final zwemmer = provider.filterZwemmerLijst[index];
                  return Container(
                    child: ListTile(
                      onTap: () => context.go(
                          '/startScreen/ZwemmersScreen/InfoZwemmerScreen/${zwemmer.id}'),
                      leading: Text(zwemmer.naam),
                      title: Text('${zwemmer.statusOef2}'),
                      trailing:
                          Icon(zwemmer.statusOef2 ? Icons.check : Icons.add),
                    ),
                  );
                },
                childCount: provider.filterZwemmerLijst.length,
              ),
            ),
          ],
        ));
  }
}
