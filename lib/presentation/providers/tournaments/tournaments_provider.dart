import 'dart:io';

import 'package:carrermodetracker/config/helpers/image_utilities.dart';
import 'package:carrermodetracker/domain/entities/tournament.dart';
import 'package:carrermodetracker/domain/repositories/tournament_repository.dart';
import 'package:carrermodetracker/presentation/providers/storage/tournament_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';

final tournamentsProvider =
    StateNotifierProvider<StorageTournamentsNotifier, Map<int, Tournament>>(
  (ref) {
    final tournamentStorageRepository = ref.watch(tournamentStorageProvider);
    return StorageTournamentsNotifier(
        tournamentStorageRepository: tournamentStorageRepository);
  },
);

final singleTournamentProvider =
    FutureProvider.autoDispose.family<Tournament, int>(
  (ref, id) {
    final tournamentsMap = ref.watch(tournamentsProvider);
    if (tournamentsMap.containsKey(id)) {
      return tournamentsMap[id]!;
    }
    return ref.read(tournamentsProvider.notifier).getTournament(id);
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

  Future<void> addTournament(Tournament tournament, XFile? imageFile) async {
    final tournamentWId =
        await tournamentStorageRepository.saveTournament(tournament);
    if (imageFile != null) {
      tournamentWId.logoURL = await saveImageInLocalStorage(
          imageFile, 'tournaments', tournamentWId.id.toString());
      await tournamentStorageRepository.updateTournament(
          tournamentWId.id, tournamentWId);
    }
    state = {...state, tournamentWId.id: tournamentWId};
  }

  Future<Tournament> getTournament(Id id) async {
    Tournament tournament = await tournamentStorageRepository.getTournament(id);
    state = {...state, tournament.id: tournament};
    return tournament;
  }

  Future<void> updateTournament(
      Id id, Tournament tournament, XFile? imageFile) async {
    Tournament oldTournament =
        await tournamentStorageRepository.getTournament(id);
    tournament.id = oldTournament.id;
    if (imageFile != null) {
      if (oldTournament.logoURL.isNotEmpty) {
        PaintingBinding.instance.imageCache
            .evict(FileImage(File(oldTournament.logoURL)));
        await deleteImage(oldTournament.logoURL);
      }
      oldTournament.logoURL = await saveImageInLocalStorage(
          imageFile, 'tournaments', id.toString());
    }
    oldTournament.name = tournament.name;
    await tournamentStorageRepository.updateTournament(id, oldTournament);
    state = {...state, id: oldTournament};
  }

  Future<void> deleteTournament(Id id) async {
    Future.delayed(
      const Duration(milliseconds: 350),
      () async {
        await tournamentStorageRepository.deleteTournament(id);
        state = {...state}..remove(id);
      },
    );
  }
}
