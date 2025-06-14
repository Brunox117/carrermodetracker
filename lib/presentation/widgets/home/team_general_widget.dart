import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TeamGeneralWidget extends ConsumerWidget {
  final String nombreEquipo;
  final String id;
  final String logoURL;
  const TeamGeneralWidget(
      {super.key,
      required this.nombreEquipo,
      required this.id,
      required this.logoURL});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.push('/teamoverview/$id');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            const SizedBox.expand(),
            Positioned(
              left: 0,
              right: 0,
              top: 10,
              bottom: 30,
              child: (logoURL.isNotEmpty)
                  ? SizedBox(
                      height: 100,
                      child: Image.file(
                        File(logoURL),
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Icon(
                      size: 100,
                      Icons.shield_outlined,
                    ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Center(
                  child: Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 19),
                    nombreEquipo,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
