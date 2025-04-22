import 'package:carrermodetracker/presentation/providers/tournaments/tournaments_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentView extends ConsumerWidget {
  final String tournamentID;
  const TournamentView({super.key, required this.tournamentID});

  @override
  Widget build(BuildContext context, ref) {
    final tournamentAsync =
        ref.watch(singleTournamentProvider(int.parse(tournamentID)));
    return tournamentAsync.when(
        data: (tournament) => Scaffold(
              appBar: AppBar(
                title: Text(tournament.name),
              ),
              body: const Center(
                child: Text(
                    'Hubo un error al cargar el torneo, intentalo de nuevo más tarde'),
              ),
            ),
        error: (error, stackTrace) => const Center(
              child: Text(
                  'Hubo un error al cargar el torneo, intentalo de nuevo más tarde'),
            ),
        loading: () => const CircularProgressIndicator());
  }
}
