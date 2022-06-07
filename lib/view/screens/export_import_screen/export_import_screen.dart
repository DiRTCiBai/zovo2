import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zovo2/provider/zwemmer_lijst_provider.dart';

import '../../../controllers/database/csv_data.dart';

class ExportImportScreen extends ConsumerWidget {
  ExportImportScreen({Key? key}) : super(key: key);

  final csvDatabase = CSVData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => ref.read(zwemmerLijstProvider).importZwemmerData(),
            child: const Text("import"),
          ),
          ElevatedButton(
            onPressed: () => ref.read(zwemmerLijstProvider).exportZwemmerData(),
            child: const Text("export"),
          ),
        ],
      ),
    );
  }
}
