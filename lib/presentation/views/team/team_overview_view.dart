import 'package:carrermodetracker/presentation/providers/players/players_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/stats_provider.dart';
import 'package:carrermodetracker/presentation/views/team/team_players_overview.dart';
import 'package:carrermodetracker/presentation/views/team/team_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamOverviewView extends ConsumerStatefulWidget {
  final String id;
  const TeamOverviewView({super.key, required this.id});

  @override
  ConsumerState<TeamOverviewView> createState() => _TeamOverviewViewState();
}

class _TeamOverviewViewState extends ConsumerState<TeamOverviewView> {
  @override
  void initState() {
    super.initState();
    // TODO: This is a hack to get the players by team to stay up to date, but it is not the best way to do it
    ref.read(playersProvider.notifier).getPlayersByTeam(int.parse(widget.id));
    ref.read(statsProvider.notifier).getStatsByTeam(id: int.parse(widget.id));
    ref
        .read(managerTournamentStatsProvider.notifier)
        .getManagerTournamentStatByTeam(teamId: int.parse(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('General'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.summarize_outlined)),
              Tab(
                icon: Icon(Icons.auto_stories_sharp),
              ),
              //Tab(icon: Icon(Icons.add_circle_outline_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TeamPlayersOverview(id: widget.id),
            TeamView(id: widget.id),
            //RegisterMatchView(id: widget.id),
          ],
        ),
      ),
    );
  }
}
