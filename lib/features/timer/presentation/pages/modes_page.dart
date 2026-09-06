import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../application/boxing_timer_controller.dart';
import '../../application/modes_controller.dart';
import '../../domain/entities/preset_modes.dart';
import '../widgets/delete_mode_dialog.dart';
import '../widgets/mode_tile.dart';

class ModesPage extends ConsumerWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final modesState = ref.watch(modesControllerProvider);
    final isTimerActive = ref.watch(boxingTimerControllerProvider).isActive;

    return Scaffold(
      appBar: AppBar(title: Text(loc.modesTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          for (final mode in modesState.allModes)
            ModeTile(
              mode: mode,
              isSelected: mode.id == modesState.selectedModeId,
              isPreset: kPresetModeIds.contains(mode.id),
              onSelect: () {
                if (isTimerActive) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(loc.switchModeBlockedSnackbar)),
                  );
                  return;
                }
                ref.read(modesControllerProvider.notifier).selectMode(mode.id);
              },
              onDuplicate: () =>
                  context.push('/settings/modes/mode', extra: mode),
              onEdit: kPresetModeIds.contains(mode.id)
                  ? null
                  : () => context.push('/settings/modes/mode/${mode.id}'),
              onDelete: kPresetModeIds.contains(mode.id)
                  ? null
                  : () async {
                      final confirmed = await showDeleteModeDialog(
                        context,
                        mode.name,
                      );
                      if (confirmed) {
                        ref
                            .read(modesControllerProvider.notifier)
                            .deleteMode(mode.id);
                      }
                    },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/settings/modes/mode'),
        icon: const Icon(Icons.add),
        label: Text(loc.newModeButton),
      ),
    );
  }
}
