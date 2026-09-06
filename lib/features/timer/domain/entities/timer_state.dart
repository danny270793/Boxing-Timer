import 'timer_phase.dart';

class BoxingTimerState {
  final TimerPhase phase;
  final int currentRound;
  final int totalRounds;
  final int secondsRemaining;
  final int totalSecondsForPhase;
  final bool isPaused;

  const BoxingTimerState({
    this.phase = TimerPhase.idle,
    this.currentRound = 0,
    this.totalRounds = 12,
    this.secondsRemaining = 0,
    this.totalSecondsForPhase = 0,
    this.isPaused = false,
  });

  bool get isActive => phase != TimerPhase.idle && phase != TimerPhase.finished;

  BoxingTimerState copyWithTick({
    required int secondsRemaining,
    bool? isPaused,
  }) {
    return BoxingTimerState(
      phase: phase,
      currentRound: currentRound,
      totalRounds: totalRounds,
      secondsRemaining: secondsRemaining,
      totalSecondsForPhase: totalSecondsForPhase,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  BoxingTimerState copyWithPaused(bool isPaused) {
    return BoxingTimerState(
      phase: phase,
      currentRound: currentRound,
      totalRounds: totalRounds,
      secondsRemaining: secondsRemaining,
      totalSecondsForPhase: totalSecondsForPhase,
      isPaused: isPaused,
    );
  }
}
