import 'package:flutter/material.dart';

import '../../../../core/utils/duration_format.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/timer_mode.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.isPreset,
    required this.onSelect,
    required this.onDuplicate,
    this.onEdit,
    this.onDelete,
  });

  final TimerMode mode;
  final bool isSelected;
  final bool isPreset;
  final VoidCallback onSelect;
  final VoidCallback onDuplicate;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final onSurface = colors.onSurface;
    final subtitle = mode.restSeconds > 0
        ? '${loc.modeRoundsCount(mode.totalRounds)} • '
              '${loc.workDuration(formatSeconds(mode.roundSeconds))} • '
              '${loc.restDuration(formatSeconds(mode.restSeconds))}'
        : '${loc.modeRoundsCount(mode.totalRounds)} • '
              '${loc.workDuration(formatSeconds(mode.roundSeconds))}';

    return Card(
      color: isSelected ? colors.primary.withValues(alpha: 0.12) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? colors.primary
              : onSurface.withValues(alpha: 0.12),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected
                    ? colors.primary
                    : onSurface.withValues(alpha: 0.38),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mode.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: onSurface.withValues(alpha: 0.54),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy_outlined, size: 20),
                tooltip: loc.duplicateTooltip,
                onPressed: onDuplicate,
              ),
              if (onEdit != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  tooltip: loc.editTooltip,
                  onPressed: onEdit,
                ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  tooltip: loc.deleteTooltip,
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
