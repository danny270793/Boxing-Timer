import 'package:flutter/material.dart';

import '../../../../core/utils/duration_format.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/timer_phase.dart';

class CountdownDisplay extends StatelessWidget {
  const CountdownDisplay({
    super.key,
    required this.phase,
    required this.secondsRemaining,
    required this.totalSeconds,
  });

  final TimerPhase phase;
  final int secondsRemaining;
  final int totalSeconds;

  static Color colorFor(BuildContext context, TimerPhase phase) {
    switch (phase) {
      case TimerPhase.warmup:
        return Colors.orangeAccent;
      case TimerPhase.round:
        return Colors.redAccent;
      case TimerPhase.rest:
        return Colors.lightBlueAccent;
      case TimerPhase.finished:
        return Colors.amberAccent;
      case TimerPhase.idle:
        return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7);
    }
  }

  String _labelFor(AppLocalizations loc, TimerPhase phase) {
    switch (phase) {
      case TimerPhase.warmup:
        return loc.phaseWarmup;
      case TimerPhase.round:
        return loc.phaseRound;
      case TimerPhase.rest:
        return loc.phaseRest;
      case TimerPhase.finished:
        return loc.phaseFinished;
      case TimerPhase.idle:
        return loc.phaseReady;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final color = colorFor(context, phase);
    final progress = totalSeconds == 0 ? 0.0 : secondsRemaining / totalSeconds;

    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(
              value: 1,
              strokeWidth: 10,
              color: onSurface.withValues(alpha: 0.08),
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: progress, end: progress),
              duration: const Duration(milliseconds: 250),
              builder: (context, value, _) {
                return Transform.rotate(
                  angle: -1.5708,
                  child: CircularProgressIndicator(
                    value: value.clamp(0, 1),
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _labelFor(loc, phase),
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                formatSeconds(secondsRemaining),
                style: TextStyle(
                  color: onSurface,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
