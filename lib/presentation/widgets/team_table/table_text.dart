import 'package:carrermodetracker/config/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;
  final bool isHeader;

  const TableText(
    this.text, {
    super.key,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader ? textTheme.tableHeaderText : textTheme.tableBodyText,
      ),
    );
  }
}
