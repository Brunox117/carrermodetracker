import 'package:carrermodetracker/presentation/widgets/team_table/table_text.dart';
import 'package:flutter/material.dart';

//NOT A WIDGET
TableRow buildTableRow(BuildContext context) {
  return const TableRow(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
    children: [
      TableCell(child: TableText('PO')),
      TableCell(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.person) ,TableText("Bruno")],
      )),
      TableCell(child: TableText("29")),
      TableCell(child: TableText("20")),
      TableCell(child: TableText("2")),
    ],
  );
}
