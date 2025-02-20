import 'package:flutter/material.dart';

extension TableTextTheme on TextTheme {
  TextStyle get tableHeaderText => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 0.5,
      );

  TextStyle get tableBodyText => const TextStyle(
        fontSize: 14,
        height: 1.4,
        overflow: TextOverflow.ellipsis
      );
}
