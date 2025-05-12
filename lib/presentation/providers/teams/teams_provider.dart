import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/team.dart';
import 'package:carrermodetracker/domain/repositories/team_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/teams_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/painting.dart';

final teamsProvider =
    StateNotifierProvider<StorageTeamsNotifier, Map<int, Team>>(
  (ref) {
    final teamStorageRepository = ref.watch(teamsStorageProvider);
    return StorageTeamsNotifier(teamStorageRepository: teamStorageRepository);
  },
);

final teamProvider =
    FutureProvider.autoDispose.family<Team, int>((ref, id) async {
  final teamsMap = ref.watch(teamsProvider);
  if (teamsMap.containsKey(id)) {
    return teamsMap[id]!;
  }
  return ref.read(teamsProvider.notifier).getTeam(id);
});

class StorageTeamsNotifier extends StateNotifier<Map<int, Team>> {
  int page = 0;
  bool isLoadingNextPage = false;
  final TeamRepository teamStorageRepository;

  StorageTeamsNotifier({required this.teamStorageRepository}) : super({});

  Future<void> initialize() async {
    page = 0;
    state = {};
    await loadNextPage();
  }

  Future<List<Team>> loadNextPage() async {
    if (isLoadingNextPage) return [];
    isLoadingNextPage = true;
    final teams =
        await teamStorageRepository.getTeams(offset: page * 10, limit: 10);
    page++;
    final tempTeamsMap = <int, Team>{};
    for (final team in teams) {
      tempTeamsMap[team.id] = team;
    }
    state = {...state, ...tempTeamsMap};
    isLoadingNextPage = false;
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
    Team oldTeam = await teamStorageRepository.getTeam(id);
    team.id = oldTeam.id;
    if (imageFile != null) {
      if (oldTeam.logoURL.isNotEmpty) {
        PaintingBinding.instance.imageCache
            .evict(FileImage(File(oldTeam.logoURL)));
        await deleteImage(oldTeam.logoURL);
      }
      team.logoURL =
          await saveImageInLocalStorage(imageFile, 'teams', id.toString());
    }
    await teamStorageRepository.updateTeam(id, team);
    state = {...state, id: team};
  }

  Future<void> deleteTeam(int id) async {
    Future.delayed(
      const Duration(milliseconds: 350),
      () async {
        Team? team = state[id];
        if (team != null && team.logoURL != "") {
          await deleteImage(team.logoURL);
        }
        await teamStorageRepository.deleteTeam(id);
        state = {...state}..remove(id);
      },
    );
  }
}
