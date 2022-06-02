import 'package:flutter/material.dart';
import 'package:zovo2/models/database_models/database_models.dart';

import '../../../../controllers/zwemmers_controller/zwemmers_controller.dart';

class AfnemenSearchDelegate extends SearchDelegate {
  final _searchController = ZwemmersController();

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

    List<Zwemmer> zwemmers = _searchController.getSearchResults(query);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ZwemmerTile(
          zwemmer: zwemmers[index],
          zwemmersController: _searchController,
        );
      },
      itemCount: zwemmers.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Zwemmer> zwemmers = _searchController.getSearchResults(query);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return ZwemmerTile(
          zwemmer: zwemmers[index],
          zwemmersController: _searchController,
        );
      },
      itemCount: zwemmers.length,
    );
  }
}

class ZwemmerTile extends StatefulWidget {
  const ZwemmerTile({
    required this.zwemmersController,
    required this.zwemmer,
    Key? key,
  }) : super(key: key);
  final Zwemmer zwemmer;
  final ZwemmersController zwemmersController;

  @override
  _ZwemmerTileState createState() => _ZwemmerTileState();
}

class _ZwemmerTileState extends State<ZwemmerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.zwemmer.isAanwezig ? Colors.green : Colors.white,
      child: ListTile(
        onTap: () {
          setState(() {
            widget.zwemmersController.toggleAanwezighden(widget.zwemmer.id);
          });
        },
        title: Text(widget.zwemmer.naam),
      ),
    );
  }
}
