import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/repositories/team_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/teams_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> addTeam(Team team, XFile? imageFile) async {
    Team teamWId = await teamStorageRepository.saveTeam(team);
    if (imageFile != null) {
      teamWId.logoURL = await saveImageInLocalStorage(
          imageFile, 'teams', teamWId.id.toString());
      await teamStorageRepository.updateTeam(teamWId.id, teamWId);
    }
    state = {...state, teamWId.id: teamWId};
  }

  Future<Team> getTeam(int id) async {
    if (state.containsKey(id)) {
      return state[id]!;
    }
    Team team = await teamStorageRepository.getTeam(id);
    state = {...state, team.id: team};
    return team;
  }

  Future<void> updateTeam(int id, Team team, XFile? imageFile) async {
    await teamStorageRepository.updateTeam(id, team);
    Team oldTeam = await teamStorageRepository.getTeam(id);
    if (imageFile != null) {
      if (oldTeam.logoURL.isNotEmpty) {
        await deleteImage(oldTeam.logoURL);
      }
      team.logoURL =
          await saveImageInLocalStorage(imageFile, 'teams', id.toString());
    }
    state = {...state, id: team};
  }
}
