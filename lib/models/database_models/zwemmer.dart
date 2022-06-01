class Zwemmer {
  String naam;
  String id;
  String groep;
  bool statusOef1;
  bool statusOef2;
  String niveauId;
  String opmerking;
  bool isAanwezig;
  bool isSelected;

  Zwemmer({
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

  @override
  String toString() {
    return "$id - $naam - $opmerking - $groep - $niveauId";
  }
}
