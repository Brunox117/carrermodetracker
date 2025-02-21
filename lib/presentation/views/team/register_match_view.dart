import 'package:flutter/material.dart';

class RegisterMatchView extends StatelessWidget {
  const RegisterMatchView({super.key});

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
            onPressed: () {},
            text: 'Agregar jugador',
          ),
          AddButton(
            onPressed: () {},
            text: 'Registra un partido',
          ),
          AddButton(
            onPressed: () {},
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
