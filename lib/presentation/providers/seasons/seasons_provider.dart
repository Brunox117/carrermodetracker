import 'package:carrermodetracker/domain/entities/season.dart';
import 'package:carrermodetracker/domain/repositories/season_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeasonStorageNotifier extends StateNotifier<Map<int, Season>> {
  int page = 0;
  final SeasonRepository seasonsStorageRepository;
  SeasonStorageNotifier({required this.seasonsStorageRepository}) : super({});

  //   Future<bool> saveSeason(Season season);

  // Future<Season> getSeason(Id id);

  // Future<List<Season>> getSeasons({int limit = 10, offset = 0});

  // Future<bool> deleteSeason(Id id);

  // Future<bool> updateSeason(Id id, Season season);
}
