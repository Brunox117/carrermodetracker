import 'package:flutter/material.dart';
import 'package:carrermodetracker/domain/entities/team.dart';

class CustomMultiDropdownButton extends StatelessWidget {
  final List<Team> items;
  final List<Team> selectedItems;
  final Function(List<Team>) onChanged;
  final String hint;

  const CustomMultiDropdownButton({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.hint = 'Selecciona los equipos',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ...selectedItems.map((team) => Chip(
                    label: Text(team.name),
                    onDeleted: () {
                      final newSelection = List<Team>.from(selectedItems)
                        ..remove(team);
                      onChanged(newSelection);
                    },
                  )),
              DropdownButton<Team>(
                isExpanded: true,
                hint: const Text('Agregar equipo'),
                items: items
                    .where((team) => !selectedItems.contains(team))
                    .map((team) => DropdownMenuItem<Team>(
                          value: team,
                          child: Text(team.name),
                        ))
                    .toList(),
                onChanged: (Team? newValue) {
                  if (newValue != null) {
                    final newSelection = List<Team>.from(selectedItems)
                      ..add(newValue);
                    onChanged(newSelection);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
