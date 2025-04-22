import 'package:flutter/material.dart';

void showDefaultDialog(
    BuildContext context,
    String message,
    String acceptButtonText,
    String cancelButtonText,
    void Function()? onPressedCancel,
    void Function()? onPressedAccept) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onPressedCancel,
            child: Text(cancelButtonText),
          ),
          TextButton(
            onPressed: onPressedAccept,
            child: Text(acceptButtonText),
          ),
        ],
      );
    },
  );
}
