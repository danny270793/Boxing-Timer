import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/audio/sound_player.dart';
import '../../domain/entities/timer_mode.dart';
import '../../domain/entities/timer_phase.dart';
import 'modes_cubit.dart';
import 'timer_state.dart';

class TimerCubit extends Cubit<BoxingTimerState> {
  final ModesCubit _modes;
  final SoundPlayer _sounds;
  Timer? _ticker;
  TimerMode _mode;

  TimerCubit({required ModesCubit modes, required this._sounds})
    : _modes = modes,
      _mode = modes.activeMode,
      super(BoxingTimerState(totalRounds: modes.activeMode.totalRounds));

  void start() {
    if (state.phase != TimerPhase.idle) return;
    _mode = _modes.activeMode;
    emit(
      BoxingTimerState(
        phase: TimerPhase.warmup,
        currentRound: 0,
        totalRounds: _mode.totalRounds,
        secondsRemaining: kWarmupSeconds,
        totalSecondsForPhase: kWarmupSeconds,
        isPaused: false,
      ),
    );
    _runTicker();
  }

  void togglePause() {
    if (!state.isActive) return;
    emit(state.copyWithPaused(!state.isPaused));
  }

  void stop() {
    _ticker?.cancel();
    emit(BoxingTimerState(totalRounds: _mode.totalRounds));
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
        _sounds.playTenSecondsWarning();
      }
      emit(state.copyWithTick(secondsRemaining: nextSeconds));
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
    _sounds.playRoundBell();
    emit(
      BoxingTimerState(
        phase: TimerPhase.round,
        currentRound: round,
        totalRounds: _mode.totalRounds,
        secondsRemaining: _mode.roundSeconds,
        totalSecondsForPhase: _mode.roundSeconds,
        isPaused: false,
      ),
    );
  }

  void _beginRest() {
    _sounds.playRoundBell();
    emit(
      BoxingTimerState(
        phase: TimerPhase.rest,
        currentRound: state.currentRound,
        totalRounds: _mode.totalRounds,
        secondsRemaining: _mode.restSeconds,
        totalSecondsForPhase: _mode.restSeconds,
        isPaused: false,
      ),
    );
  }

  void _finish() {
    _ticker?.cancel();
    emit(
      BoxingTimerState(
        phase: TimerPhase.finished,
        currentRound: state.currentRound,
        totalRounds: _mode.totalRounds,
        secondsRemaining: 0,
        totalSecondsForPhase: 0,
        isPaused: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
