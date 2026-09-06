import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/sound_player.dart';
import '../domain/entities/preset_modes.dart';
import '../domain/entities/timer_mode.dart';
import '../domain/entities/timer_phase.dart';
import '../domain/entities/timer_state.dart';
import 'modes_controller.dart';

class BoxingTimerController extends Notifier<BoxingTimerState> {
  Timer? _ticker;
  TimerMode _mode = boxingPreset;

  @override
  BoxingTimerState build() {
    ref.onDispose(() => _ticker?.cancel());
    _mode = ref.read(activeTimerModeProvider);
    return BoxingTimerState(totalRounds: _mode.totalRounds);
  }

  void start() {
    if (state.phase != TimerPhase.idle) return;
    _mode = ref.read(activeTimerModeProvider);
    state = BoxingTimerState(
      phase: TimerPhase.warmup,
      currentRound: 0,
      totalRounds: _mode.totalRounds,
      secondsRemaining: kWarmupSeconds,
      totalSecondsForPhase: kWarmupSeconds,
      isPaused: false,
    );
    _runTicker();
  }

  void togglePause() {
    if (!state.isActive) return;
    state = state.copyWithPaused(!state.isPaused);
  }

  void stop() {
    _ticker?.cancel();
    state = BoxingTimerState(totalRounds: _mode.totalRounds);
  }

  void _runTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (state.isPaused) return;

    final nextSeconds = state.secondsRemaining - 1;
    if (nextSeconds > 0) {
      if (state.phase == TimerPhase.round &&
          nextSeconds == kClashWarningSeconds) {
        ref.read(soundPlayerProvider).playTenSecondsWarning();
      }
      state = state.copyWithTick(secondsRemaining: nextSeconds);
      return;
    }

    _advancePhase();
  }

  void _advancePhase() {
    switch (state.phase) {
      case TimerPhase.warmup:
        _beginRound(1);
      case TimerPhase.round:
        if (state.currentRound >= _mode.totalRounds) {
          _finish();
        } else {
          _beginRest();
        }
      case TimerPhase.rest:
        _beginRound(state.currentRound + 1);
      case TimerPhase.idle:
      case TimerPhase.finished:
        break;
    }
  }

  void _beginRound(int round) {
    ref.read(soundPlayerProvider).playRoundBell();
    state = BoxingTimerState(
      phase: TimerPhase.round,
      currentRound: round,
      totalRounds: _mode.totalRounds,
      secondsRemaining: _mode.roundSeconds,
      totalSecondsForPhase: _mode.roundSeconds,
      isPaused: false,
    );
  }

  void _beginRest() {
    ref.read(soundPlayerProvider).playRoundBell();
    state = BoxingTimerState(
      phase: TimerPhase.rest,
      currentRound: state.currentRound,
      totalRounds: _mode.totalRounds,
      secondsRemaining: _mode.restSeconds,
      totalSecondsForPhase: _mode.restSeconds,
      isPaused: false,
    );
  }

  void _finish() {
    _ticker?.cancel();
    state = BoxingTimerState(
      phase: TimerPhase.finished,
      currentRound: state.currentRound,
      totalRounds: _mode.totalRounds,
      secondsRemaining: 0,
      totalSecondsForPhase: 0,
      isPaused: false,
    );
  }
}

final boxingTimerControllerProvider =
    NotifierProvider<BoxingTimerController, BoxingTimerState>(
      BoxingTimerController.new,
    );
