import 'package:flutter/material.dart';

import '../../domain/entities/timer_phase.dart';
import 'countdown_display.dart';

class RoundDots extends StatelessWidget {
  const RoundDots({
    super.key,
    required this.phase,
    required this.currentRound,
    required this.totalRounds,
  });

  final TimerPhase phase;
  final int currentRound;
  final int totalRounds;

  @override
  Widget build(BuildContext context) {
    final activeColor = CountdownDisplay.colorFor(context, phase);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isFinished = phase == TimerPhase.finished;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(totalRounds, (index) {
        final roundNumber = index + 1;
        final isDone = isFinished || roundNumber < currentRound;
        final isCurrent =
            !isFinished &&
            roundNumber == currentRound &&
            (phase == TimerPhase.round || phase == TimerPhase.rest);

        Color color;
        if (isCurrent) {
          color = activeColor;
        } else if (isDone) {
          color = onSurface.withValues(alpha: 0.54);
        } else {
          color = onSurface.withValues(alpha: 0.24);
        }

        return Container(
          width: isCurrent ? 12 : 9,
          height: isCurrent ? 12 : 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone || isCurrent ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
          ),
        );
      }),
    );
  }
}
