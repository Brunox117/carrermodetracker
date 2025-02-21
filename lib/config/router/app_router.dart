import 'package:carrermodetracker/presentation/screens/home/home_screen.dart';
import 'package:carrermodetracker/presentation/views/config/config_view.dart';
import 'package:carrermodetracker/presentation/views/home/add_team_view.dart';
import 'package:carrermodetracker/presentation/views/home/home_view.dart';
import 'package:carrermodetracker/presentation/views/team/team_overview_view.dart';
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
              routes: [
                GoRoute(
                  path: '/teamoverview/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    return TeamOverviewView(id: id);
                  },
                ),
                GoRoute(
                  path: '/addteam',
                  builder: (context, state) {
                    return const AddTeamView();
                  },
                )
              ])
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
