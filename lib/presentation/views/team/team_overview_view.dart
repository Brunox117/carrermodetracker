import 'package:carrermodetracker/presentation/views/team/register_match_view.dart';
import 'package:carrermodetracker/presentation/views/team/team_overview.dart';
import 'package:flutter/material.dart';

class TeamOverviewView extends StatelessWidget {
  final String id;
  const TeamOverviewView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('General'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.summarize_outlined)),
              Tab(icon: Icon(Icons.add_circle_outline_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TeamOverview(id: id),
            RegisterMatchView(id: id),
          ],
        ),
      ),
    );
  }
}
