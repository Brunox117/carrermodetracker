import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color? backGroundColor;
  const CustomCard(
      {super.key,
      this.backGroundColor,
      required this.child,
      this.paddingHorizontal = 8.0,
      this.paddingVertical = 8.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Card(
        color: backGroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal, vertical: paddingVertical),
          child: child,
        ),
      ),
    );
  }
}
