import 'package:drops/drops.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveFormButton extends StatelessWidget {
  final void Function() submitForm;
  final String? onSaveTextAlert;
  const SaveFormButton({
    super.key,
    required this.submitForm,
    this.onSaveTextAlert,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: IconButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          submitForm();
          if (onSaveTextAlert != null) {
            Drops.show(
              shape: DropShape.squared,
              context,
              title: onSaveTextAlert!,
            );
          }
        },
        icon: Icon(
          Icons.save,
          size: 70,
          color: colors.secondary,
        ),
      ),
    );
  }
}
