import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zovo2/view/screens/test_screen/state/test_screen_cubit.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _cubit = TestScreenCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initCubit();
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
      child: const TestScreenWrapped(),
    );
  }
}

class TestScreenWrapped extends StatelessWidget {
  const TestScreenWrapped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TestScreenCubit>(context),
      builder: (context, state) {
        if (state is TestScreenDisplay) {
          final _cubit = BlocProvider.of<TestScreenCubit>(context);
          return Scaffold(
            appBar: AppBar(),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      Text("Test 1"),
                      Divider(),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final zwemmer = state.zwemmerLijstOef1[index];
                      return Container(
                        child: ListTile(
                          onTap: () => _cubit.toggle(zwemmer.zwemmerId, 1),
                          leading: Text(zwemmer.naam),
                          title: Text(zwemmer.oef),
                          trailing: Icon(zwemmer.statusOef ? Icons.check : Icons.add),
                        ),
                      );
                    },
                    childCount: state.zwemmerLijstOef1.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: const [
                      Text("Test 2"),
                      Divider(),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final zwemmer = state.zwemmerLijstOef2[index];
                      return Container(
                        child: ListTile(
                          onTap: () => _cubit.toggle(zwemmer.zwemmerId, 2),
                          leading: Text(zwemmer.naam),
                          title: Text(zwemmer.oef),
                          trailing: Icon(zwemmer.statusOef ? Icons.check : Icons.add),
                        ),
                      );
                    },
                    childCount: state.zwemmerLijstOef2.length,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
