import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/repositories/season_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/seasons_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final seasonsProvider =
    StateNotifierProvider<SeasonStorageNotifier, Map<int, Season>>(
  (ref) {
    final seasonsStorageRepository = ref.watch(seasonsStorageProvider);
    return SeasonStorageNotifier(
        seasonsStorageRepository: seasonsStorageRepository);
  },
);

class SeasonStorageNotifier extends StateNotifier<Map<int, Season>> {
  int page = 0;
  final SeasonRepository seasonsStorageRepository;
  SeasonStorageNotifier({required this.seasonsStorageRepository}) : super({});

  Future<void> saveSeason(Season season) async {
    final seasonWId = await seasonsStorageRepository.saveSeason(season);
    state = {...state, seasonWId.id: seasonWId};
  }

  Future<Season> getSeason(int id) async {
    if (state.containsKey(id)) {
      return state[id]!;
    }
    Season season = await seasonsStorageRepository.getSeason(id);
    state = {...state, season.id: season};
    return season;
  }

  Future<List<Season>> getSeasons() async {
    final seasons =
        await seasonsStorageRepository.getSeasons(offset: page * 10, limit: 10);
    if (seasons.isNotEmpty) {
      page++;
    }
    final tempSeasonsMap = <int, Season>{};
    for (final season in seasons) {
      tempSeasonsMap[season.id] = season;
    }
    state = {...state, ...tempSeasonsMap};
    return seasons;
  }

  Future<void> deleteSeason(int id) async {
    await seasonsStorageRepository.deleteSeason(id);
    state = {...state}..remove(id);
  }

  Future<void> updateSeason(int id, Season season) async {
    await seasonsStorageRepository.updateSeason(id, season);
    state = {...state, season.id: season};
  }
}
