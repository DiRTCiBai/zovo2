import 'package:go_router/go_router.dart';
import 'package:zovo2/view/screens/screens.dart';

final router = GoRouter(
  initialLocation: StartScreen.route,
  routes: [
    GoRoute(
      path: '/startScreen',
      builder: (ctx, state) => const StartScreen(),
      routes: [
        GoRoute(
            path: 'AfnemenScreen/:isAfnemen',
            builder: (ctx, state) => AfnemenScreen(isAfnemen: state.params["isAfnemen"]!),
            routes: [
              GoRoute(
                path: 'TestScreen',
                builder: (ctx, state) => const TestScreen(),
              ),
            ]),
      ],
    ),
  ],
);
