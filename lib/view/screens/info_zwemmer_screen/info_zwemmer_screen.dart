import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zovo2/provider/zwemmer_lijst_provider.dart';

class InfoZwemmerScreen extends ConsumerStatefulWidget {
  InfoZwemmerScreen({
    required this.zwemmerId,
    Key? key,
  }) : super(key: key);
  final String zwemmerId;

  @override
  _InfoZwemmerScreenState createState() => _InfoZwemmerScreenState();
}

class _InfoZwemmerScreenState extends ConsumerState<InfoZwemmerScreen> {
  String dropdownvalue = '';

  List<String> items = [];

  @override
  void initState() {
    items = ref.read(zwemmerLijstProvider).groepen;
    dropdownvalue =
        ref.read(zwemmerLijstProvider).zwemmerCurrentGroep(widget.zwemmerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final zwemmer =
        ref.read(zwemmerLijstProvider).zwemmerById(widget.zwemmerId);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.zwemmerId),
      ),
      body: Column(
        children: [
          const SizedBox(width: double.infinity),
          SizedBox(
            width: width,
            child: AspectRatio(
              aspectRatio: 3,
              child: Container(
                margin: const EdgeInsets.all(20),
                color: Colors.blue,
                child: const Center(child: Text("NAAM")),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  /// NIVEAU
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  color: Colors.blue,
                ),

                /// GROEP
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Text("Test oefeningen"),
          Container(
            color: Colors.blue,
            margin: const EdgeInsets.all(20),
            child: Column(
              children: const [
                ListTile(
                  title: Text("Oef 1"),
                ),
                ListTile(
                  title: Text("Oef 2"),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: width,
            margin: const EdgeInsets.all(20),
            height: 50,
            child: ElevatedButton(onPressed: () {}, child: Text("Opslaan")),
          )
        ],
      ),
    );
  }
}
