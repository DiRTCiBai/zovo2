import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CSVData {
  Future<List<dynamic>> impotZwemmerData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    String path = result!.files.first.path!;

    File f = File(path);
    final input = f.openRead();
    final fields = await input.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    return fields;
  }

  Future exportZwemmerData(List<List<dynamic>> zwemmerData) async {
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final path = "$directory/zwemmer-data.csv";

    String csvData = const ListToCsvConverter().convert(zwemmerData);
    final File file = File(path);
    await file.writeAsString(csvData);

    Share.shareFiles([path]);
  }
}
