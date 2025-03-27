import 'package:flutter/material.dart';

class SaveFormButton extends StatelessWidget {
  final void Function() submitForm;
  const SaveFormButton({
    super.key,
    required this.submitForm,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: IconButton(
        onPressed: () {
          submitForm();
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
