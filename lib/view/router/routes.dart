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
          path: 'AfnemenScreen',
          builder: (ctx, state) => AfnemenScreen(),
          routes: [
            GoRoute(
              path: 'TestScreen',
              builder: (ctx, state) => const TestScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'ZwemmersScreen',
          builder: (ctx, state) => const ZwemmersScreen(),
        ),
      ],
    ),
  ],
);
