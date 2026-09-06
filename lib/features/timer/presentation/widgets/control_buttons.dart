import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/timer_phase.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.phase,
    required this.isPaused,
    required this.onStart,
    required this.onTogglePause,
    required this.onStop,
  });

  final TimerPhase phase;
  final bool isPaused;
  final VoidCallback onStart;
  final VoidCallback onTogglePause;
  final VoidCallback onStop;

  bool get _isActive =>
      phase != TimerPhase.idle && phase != TimerPhase.finished;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (!_isActive) {
      return SizedBox(
        width: 220,
        height: 64,
        child: FilledButton.icon(
          onPressed: onStart,
          icon: const Icon(Icons.play_arrow, size: 28),
          label: Text(
            phase == TimerPhase.finished
                ? loc.startNewFightButton
                : loc.startButton,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: FilledButton.icon(
              onPressed: onTogglePause,
              icon: Icon(isPaused ? Icons.play_arrow : Icons.pause, size: 26),
              label: Text(
                isPaused ? loc.resumeButton : loc.pauseButton,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 64,
            child: FilledButton.icon(
              onPressed: onStop,
              icon: const Icon(Icons.stop, size: 26),
              label: Text(
                loc.stopButton,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
