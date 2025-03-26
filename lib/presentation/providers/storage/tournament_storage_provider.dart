import 'package:carrermodetracker/infrastructure/datasources/isar_tournament_datasource.dart';
import 'package:carrermodetracker/infrastructure/repositories/tournament_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tournamentStorageProvider = Provider(
  (ref) {
    return TournamentRepositoryImpl(datasource: IsarTournamentDatasource());
  },
);
