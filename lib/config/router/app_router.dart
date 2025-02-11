import 'package:carrermodetracker/presentation/screens/home/home_screen.dart';
import 'package:carrermodetracker/presentation/views/config/config_view.dart';
import 'package:carrermodetracker/presentation/views/home/home_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(currentChild: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/configuration',
            builder: (context, state) {
              return const ConfigView();
            },
          ),
        ]),
      ])
]);
