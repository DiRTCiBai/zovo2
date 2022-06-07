import 'package:hive/hive.dart';

part 'zwemmer.g.dart';

@HiveType(typeId: 1)
class ZwemmerData {
  @HiveField(0)
  String naam;
  @HiveField(1)
  String id;
  @HiveField(2)
  String groep;
  @HiveField(3)
  bool statusOef1;
  @HiveField(4)
  bool statusOef2;
  @HiveField(5)
  String niveauId;
  @HiveField(6)
  String opmerking;
  @HiveField(7)
  bool isAanwezig;
  @HiveField(8)
  bool isSelected;

  ZwemmerData({
    required this.id,
    required this.opmerking,
    required this.naam,
    required this.groep,
    required this.isAanwezig,
    required this.isSelected,
    required this.niveauId,
    required this.statusOef1,
    required this.statusOef2,
  });
}
