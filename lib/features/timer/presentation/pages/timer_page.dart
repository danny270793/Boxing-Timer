import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../application/boxing_timer_controller.dart';
import '../../application/modes_controller.dart';
import '../../domain/entities/timer_phase.dart';
import '../widgets/control_buttons.dart';
import '../widgets/countdown_display.dart';
import '../widgets/round_dots.dart';
import '../widgets/stop_confirm_dialog.dart';

String _roundLabel(
  AppLocalizations loc,
  TimerPhase phase,
  int currentRound,
  int totalRounds,
) {
  switch (phase) {
    case TimerPhase.idle:
      return loc.roundsAhead(totalRounds);
    case TimerPhase.warmup:
      return loc.getReady;
    case TimerPhase.finished:
      return loc.completedRounds(totalRounds);
    case TimerPhase.round:
    case TimerPhase.rest:
      return loc.roundProgress(currentRound, totalRounds);
  }
}

class TimerPage extends ConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final state = ref.watch(boxingTimerControllerProvider);
    final controller = ref.read(boxingTimerControllerProvider.notifier);
    final activeMode = ref.watch(activeTimerModeProvider);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    final isIdle = state.phase == TimerPhase.idle;
    final displayTotalRounds = isIdle
        ? activeMode.totalRounds
        : state.totalRounds;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: loc.settingsTitle,
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (isIdle)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  activeMode.name,
                  style: TextStyle(
                    color: onSurface.withValues(alpha: 0.38),
                    fontSize: 14,
                  ),
                ),
              ),
            Expanded(
              child: Center(
                child: CountdownDisplay(
                  phase: state.phase,
                  secondsRemaining: state.secondsRemaining,
                  totalSeconds: state.totalSecondsForPhase,
                ),
              ),
            ),
            RoundDots(
              phase: state.phase,
              currentRound: state.currentRound,
              totalRounds: displayTotalRounds,
            ),
            const SizedBox(height: 12),
            Text(
              _roundLabel(
                loc,
                state.phase,
                state.currentRound,
                displayTotalRounds,
              ),
              style: TextStyle(
                color: onSurface.withValues(alpha: 0.54),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: ControlButtons(
                phase: state.phase,
                isPaused: state.isPaused,
                onStart: controller.start,
                onTogglePause: controller.togglePause,
                onStop: () async {
                  final confirmed = await showStopConfirmDialog(context);
                  if (confirmed) {
                    controller.stop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
