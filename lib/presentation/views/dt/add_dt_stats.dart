import 'package:carrermodetracker/domain/entities/manager.dart';
import 'package:carrermodetracker/domain/entities/manager_stat.dart';
import 'package:carrermodetracker/domain/entities/manager_tournament_stat.dart';
import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/presentation/providers/manager/managers_provider.dart';
import 'package:carrermodetracker/presentation/providers/seasons/seasons_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/stats/manager_tournament_stats_provider.dart';
import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDtStats extends StatelessWidget {
  final String managerId;
  const AddDtStats({super.key, required this.managerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddDtStats'),
      ),
      body: _ManagerStatsForm(
        managerId: managerId,
      ),
    );
  }
}

class _ManagerStatsForm extends ConsumerStatefulWidget {
  final String managerId;
  const _ManagerStatsForm({required this.managerId});

  @override
  ConsumerState<_ManagerStatsForm> createState() => _ManagerStatsFormState();
}

class _ManagerStatsFormState extends ConsumerState<_ManagerStatsForm> {
  final _formKey = GlobalKey<FormState>();
  int goals = 0;
  int playedMatches = 0;
  int winds = 0;
  int loses = 0;
  int draws = 0;
  int goalsScored = 0;
  int goalsConceded = 0;
  int? selectedSeasonID;
  int? selectedPlayerID;
  int? selectedTournamentID;
  Season? season;
  Tournament? tournament;
  Manager? manager;

  @override
  void initState() {
    super.initState();
    ref.read(managersProvider.notifier).getManager();
    ref.read(tournamentsProvider.notifier).loadNextPage();
    ref.read(seasonsProvider.notifier).getSeasons();
  }

  void saveStats(Managerstat managerStat) {
    ref.read(managerStatsProvider.notifier).addManagerStat(managerStat);
  }

  void saveTournamentStats(ManagerTournamentStat managerTournamentStat) {
    ref
        .read(managerTournamentStatsProvider.notifier)
        .addManagerTournamentStat(managerTournamentStat);
  }

  void updateStats(Managerstat managerStat, int id) {
    ref.read(managerStatsProvider.notifier).updateManagerStat(id, managerStat);
  }

  void updateTournamentStats(
      int id, ManagerTournamentStat managerTournamentStat) {
    ref
        .read(managerTournamentStatsProvider.notifier)
        .updateManagerTournamentStat(id, managerTournamentStat);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
