import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zovo2/view/screens/zwemmers_screen/state/zwemmers_screen_cubit.dart';

class ZwemmersScreen extends StatefulWidget {
  const ZwemmersScreen({Key? key}) : super(key: key);

  @override
  _ZwemmersScreenState createState() => _ZwemmersScreenState();
}

class _ZwemmersScreenState extends State<ZwemmersScreen> {
  final _cubit = ZwemmersScreenCubit();

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
      child: ZwemmersScreenWrapped(),
    );
  }
}

class ZwemmersScreenWrapped extends StatelessWidget {
  const ZwemmersScreenWrapped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ZwemmersScreenCubit>(context),
      builder: (context, state) {
        if (state is ZwemmersScreenDisplay) {
          return Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
              itemBuilder: (ctx, index) {
                return Container();
              },
              itemCount: 5,
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
