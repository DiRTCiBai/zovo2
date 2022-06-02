import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zovo2/models/database_models/database_models.dart';
import 'package:zovo2/provider/zwemmer_lijst_provider.dart';

import '../../../../controllers/zwemmers_controller/zwemmers_controller.dart';

class AfnemenSearchDelegate extends SearchDelegate {
  final _searchController = ZwemmersController();
  final WidgetRef ref;

  AfnemenSearchDelegate({required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = ref.read(zwemmerLijstProvider);
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Search term must be longer than 2 letters."),
          ),
        ],
      );
    }

    List<Zwemmer> zwemmers = provider.getSearchResults(query);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ZwemmerTile(
          zwemmer: zwemmers[index],
        );
      },
      itemCount: zwemmers.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = ref.read(zwemmerLijstProvider);
    List<Zwemmer> zwemmers = provider.getSearchResults(query);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ZwemmerTile(
          zwemmer: zwemmers[index],
        );
      },
      itemCount: zwemmers.length,
    );
  }
}

class ZwemmerTile extends ConsumerWidget {
  const ZwemmerTile({
    required this.zwemmer,
    Key? key,
  }) : super(key: key);
  final Zwemmer zwemmer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(zwemmerLijstProvider);
    return Container(
      color: zwemmer.isAanwezig ? Colors.green : Colors.white,
      child: ListTile(
        onTap: () {
          provider.setMode(true);
          provider.toggle(zwemmer.id);
        },
        title: Text(zwemmer.naam),
      ),
    );
  }
}
