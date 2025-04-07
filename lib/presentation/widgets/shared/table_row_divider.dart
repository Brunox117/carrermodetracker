import 'package:flutter/material.dart';

TableRow tableRowDivider(int columns, TableCell tableCell) {
  return TableRow(
      children: List.generate(
    columns,
    (index) => tableCell,
  ));
}
