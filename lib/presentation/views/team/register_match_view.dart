import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterMatchView extends StatelessWidget {
  final String id;
  const RegisterMatchView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Registra partidos, agrega nuevos jugadores e inicia nuevas temporadas',
            style: textStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          AddButton(
            onPressed: () {
              context.push('/teamoverview/$id/addtournamentview');
            },
            text: 'Crea un torneo',
          ),
          AddButton(
            onPressed: () {
              context.push('/teamoverview/$id/addplayerview');
            },
            text: 'Agregar jugador',
          ),
          AddButton(
            onPressed: () {
              context.push('/teamoverview/$id/addstatview');
            },
            text: 'Registra estadísticas',
          ),
          AddButton(
            onPressed: () {context.push('/teamoverview/$id/addseasonview');},
            text: 'Iniciar nueva temporada',
          ),
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const AddButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
