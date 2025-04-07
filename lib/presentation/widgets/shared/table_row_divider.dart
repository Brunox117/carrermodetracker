import 'package:flutter/material.dart';

//Returns a table row that can be used as a divider
TableRow tableRowDivider(int columns, TableCell tableCell) {
  return TableRow(
      children: List.generate(
    columns,
    (index) => tableCell,
  ));
}
