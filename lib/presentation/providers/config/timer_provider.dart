import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<Timer?> {
  TimerNotifier() : super(null);

  void startTimer({
    required Duration duration,
    required VoidCallback onTick,
  }) {
    // Cancelar timer existente si hay uno
    state?.cancel();

    // Crear nuevo timer
    state = Timer.periodic(duration, (timer) {
      onTick();
    });
  }

  void stopTimer() {
    state?.cancel();
    state = null;
  }

  void resetTimer() {
    stopTimer();
  }

  @override
  void dispose() {
    state?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Timer?>((ref) {
  return TimerNotifier();
});
