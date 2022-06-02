import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zovo2/view/screens/afnemen_screen/search/afnemen_search_delegate.dart';

import 'state/afnemen_screen_cubit.dart';

class AfnemenScreen extends StatefulWidget {
  AfnemenScreen({
    required this.isAfnemen,
    Key? key,
  }) : super(key: key);

  final String isAfnemen;
  static const route = "/StartScreen/AfnemenScreen";

  @override
  State<AfnemenScreen> createState() => _AfnemenScreenState();
}

class _AfnemenScreenState extends State<AfnemenScreen> {
  final _cubit = AfnemenScreenCubit();

  @override
  void initState() {
    _cubit.initCubit(widget.isAfnemen);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: AfnemenScreenWrapped(),
    );
  }
}

class AfnemenScreenWrapped extends StatefulWidget {
  AfnemenScreenWrapped({Key? key}) : super(key: key);

  @override
  State<AfnemenScreenWrapped> createState() => _AfnemenScreenWrappedState();
}

class _AfnemenScreenWrappedState extends State<AfnemenScreenWrapped> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AfnemenScreenCubit>(context),
      builder: (context, state) {
        if (state is AfnemenScreenDisplay) {
          final _cubit = BlocProvider.of<AfnemenScreenCubit>(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (state.mode) {
                  context.pop();
                } else {
                  context.go('/startScreen/AfnemenScreen/test/TestScreen');
                }
              },
              child: state.mode ? const Text("Save") : const Text("Test"),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: AfnemenSearchDelegate());
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
                        final groep = state.groepen[index];

                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                state.currentGroep == state.groepen[index] ? Colors.green : Colors.blue),
                          ),
                          onPressed: () {
                            _cubit.changeGroep(groep);
                          },
                          child: Text(groep),
                        );
                      },
                      itemCount: state.groepen.length,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final zwemmer = state.zwemmerLijst[index];
                      return Container(
                        color: zwemmer.isSelected ? Colors.green : Colors.white,
                        child: ListTile(
                          onTap: () => _cubit.toggle(zwemmer.zwemmerId),
                          title: Text(zwemmer.naam),
                          trailing: Text("${zwemmer.niveau}"),
                        ),
                      );
                    },
                    childCount: state.zwemmerLijst.length,
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
