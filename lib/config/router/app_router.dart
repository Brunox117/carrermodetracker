import 'package:carrermodetracker/presentation/screens/home/home_screen.dart';
import 'package:carrermodetracker/presentation/views/add/add_all_stat_view.dart';
import 'package:carrermodetracker/presentation/views/config/config_view.dart';
import 'package:carrermodetracker/presentation/views/dt/add_dt_stats.dart';
import 'package:carrermodetracker/presentation/views/dt/add_dt_view.dart';
import 'package:carrermodetracker/presentation/views/dt/dt_general_view.dart';
import 'package:carrermodetracker/presentation/views/dt/dt_individual_stats.dart';
import 'package:carrermodetracker/presentation/views/home/add_team_view.dart';
import 'package:carrermodetracker/presentation/views/home/home_view.dart';
import 'package:carrermodetracker/presentation/views/player/add_player_view.dart';
import 'package:carrermodetracker/presentation/views/player/player_individual_stats.dart';
import 'package:carrermodetracker/presentation/views/player/player_view.dart';
import 'package:carrermodetracker/presentation/views/seasons/add_season_view.dart';
import 'package:carrermodetracker/presentation/views/stats/add_stat_view.dart';
import 'package:carrermodetracker/presentation/views/team/team_overview_view.dart';
import 'package:carrermodetracker/presentation/views/tournaments/add_tournament_view.dart';
import 'package:carrermodetracker/presentation/views/tournaments/tournament_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/dtview', routes: [
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
                  routes: [
                    GoRoute(
                      path: '/addplayerview',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '';
                        return AddPlayerView(teamId: id);
                      },
                    ),
                    GoRoute(
                      path: '/addtournamentview',
                      builder: (context, state) {
                        // final id = state.pathParameters['id'] ?? '';
                        return const AddTournamentView();
                      },
                    ),
                    GoRoute(
                      path: '/addstatview',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '';
                        final seasonId = state.uri.queryParameters['seasonId'];
                        final playerId = state.uri.queryParameters['playerId'];
                        final tournamentId =
                            state.uri.queryParameters['tournamentId'];
                        return AddStatView(
                          teamId: id,
                          seasonId: seasonId,
                          playerId: playerId,
                          tournamentId: tournamentId,
                        );
                      },
                    ),
                    GoRoute(
                      path: '/addseasonview',
                      builder: (context, state) {
                        // final id = state.pathParameters['id'] ?? '';
                        return const AddSeasonView();
                      },
                    ),
                  ],
                  path: '/teamoverview/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    return TeamOverviewView(id: id);
                  },
                ),
                GoRoute(
                  path: '/editteam/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return AddTeamView(teamid: id);
                  },
                ),
                GoRoute(
                  path: '/editplayer/:playerId',
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    final playerId = state.pathParameters['playerId'];
                    return AddPlayerView(
                      teamId: id,
                      playerId: playerId,
                    );
                  },
                ),
                GoRoute(
                  path: '/playerindividualstats/:playerId',
                  builder: (context, state) {
                    final id = state.pathParameters['id'] ?? '';
                    final playerId = state.pathParameters['playerId'] ?? '';
                    return PlayerIndividualStats(
                      teamId: id,
                      playerId: playerId,
                    );
                  },
                ),
                GoRoute(
                  path: '/edittournament/:tournamentId',
                  builder: (context, state) {
                    final tournamentId = state.pathParameters['tournamentId'];
                    return AddTournamentView(
                      tournamentId: tournamentId,
                    );
                  },
                ),
                GoRoute(
                  path: '/playerview/:playerID',
                  builder: (context, state) {
                    final playerID = state.pathParameters['playerID'];
                    return PlayerView(
                      playerID: playerID ?? '',
                    );
                  },
                ),
                GoRoute(
                  path: '/tournamentview/:tournamentID',
                  builder: (context, state) {
                    final tournamentID = state.pathParameters['tournamentID'];
                    return TournamentView(
                      tournamentID: tournamentID ?? '',
                    );
                  },
                ),
                GoRoute(
                  path: '/addteam',
                  builder: (context, state) {
                    return const AddTeamView();
                  },
                ),
              ])
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/dtview',
              builder: (context, state) {
                return const DtGeneralView();
              },
              routes: [
                GoRoute(
                  path: '/addDt',
                  builder: (context, state) {
                    return const AddDtView();
                  },
                ),
                GoRoute(
                  path: '/editdt/:dtId',
                  builder: (context, state) {
                    final dtId = state.pathParameters['dtId'];
                    return AddDtView(
                      managerId: dtId,
                    );
                  },
                ),
                GoRoute(
                  path: '/dtindividualstats/:dtId',
                  builder: (context, state) {
                    final dtId = state.pathParameters['dtId'];
                    return DtIndividualStats(
                      managerId: dtId,
                    );
                  },
                ),
                GoRoute(
                  path: '/adddtstats/:dtId',
                  builder: (context, state) {
                    final dtId = state.pathParameters['dtId'];
                    return AddDtStats(
                      managerId: dtId ?? '',
                    );
                  },
                ),
              ]),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/add-all-stat-view',
            builder: (context, state) {
              return const AddAllStatView(
                id: '1',
              );
            },
          ),
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
