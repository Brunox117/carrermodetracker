import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/domain/repositories/tournament_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/tournament_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final tournamentsProvider =
    StateNotifierProvider<StorageTournamentsNotifier, Map<int, Tournament>>(
  (ref) {
    final tournamentStorageRepository = ref.watch(tournamentStorageProvider);
    return StorageTournamentsNotifier(
        tournamentStorageRepository: tournamentStorageRepository);
  },
);

class StorageTournamentsNotifier extends StateNotifier<Map<int, Tournament>> {
  int page = 0;
  final TournamentRepository tournamentStorageRepository;

  StorageTournamentsNotifier({required this.tournamentStorageRepository})
      : super({});

  Future<List<Tournament>> loadNextPage() async {
    final tournaments = await tournamentStorageRepository.getTournaments(
        offset: page * 10, limit: 10);
    page++;
    final tempTournamentsMap = <int, Tournament>{};
    for (final tournament in tournaments) {
      tempTournamentsMap[tournament.id] = tournament;
    }
    state = {...state, ...tempTournamentsMap};
    return tournaments;
  }

  Future<void> addTournament(Tournament tournament) async {
    await tournamentStorageRepository.saveTournament(tournament);
    state = {...state, tournament.id: tournament};
  }

  Future<Tournament> getTournament(Id id) async {
    Tournament tournament = await tournamentStorageRepository.getTournament(id);
    state = {...state, tournament.id: tournament};
    return tournament;
  }

  Future<void> updateTournament(Id id, Tournament tournament) async {
    await tournamentStorageRepository.updateTournament(id, tournament);
    state = {...state, tournament.id: tournament};
  }

  Future<void> deleteTournament(Id id) async {
    await tournamentStorageRepository.deleteTournament(id);
    state = {...state}..remove(id);
  }
}
