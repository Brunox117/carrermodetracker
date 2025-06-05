import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;
  final bool isHeader;
  final String suffix;

  const TableText(
    this.text, {
    super.key,
    this.isHeader = false,
    this.suffix = '',
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text + suffix,
        style: isHeader ? textStyles.titleSmall : textStyles.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
