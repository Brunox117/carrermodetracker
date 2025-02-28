import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/repositories/team_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/teams_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamsProvider =
    StateNotifierProvider<StorageTeamsNotifier, Map<int, Team>>(
  (ref) {
    final teamStorageRepository = ref.watch(teamsStorageProvider);
    return StorageTeamsNotifier(teamStorageRepository: teamStorageRepository);
  },
);

class StorageTeamsNotifier extends StateNotifier<Map<int, Team>> {
  int page = 0;
  final TeamRepository teamStorageRepository;

  StorageTeamsNotifier({required this.teamStorageRepository}) : super({});

  Future<List<Team>> loadNextPage() async {
    final teams =
        await teamStorageRepository.getTeams(offset: page * 10, limit: 10);
    page++;
    final tempTeamsMap = <int, Team>{};
    for (final team in teams) {
      tempTeamsMap[team.id] = team;
    }
    state = {...state, ...tempTeamsMap};
    return teams;
  }

  Future<void> addTeam(Team team) async {
    await teamStorageRepository.saveTeam(team);
    state = {...state, team.id: team};
  }

  Future<Team> getTeam(int id) async {
    Team team = await teamStorageRepository.getTeam(id);
    return team;
  }
}
