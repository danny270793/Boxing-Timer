import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../features/timer/presentation/cubit/modes_cubit.dart';
import '../features/timer/presentation/cubit/modes_state.dart';
import '../features/timer/presentation/cubit/timer_cubit.dart';
import '../l10n/app_localizations.dart';
import '../features/timer/domain/entities/preset_modes.dart';
import '../widgets/delete_mode_dialog.dart';
import '../widgets/mode_tile.dart';

class ModesPage extends StatelessWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ModesCubit>()),
        BlocProvider.value(value: getIt<TimerCubit>()),
      ],
      child: const _ModesView(),
    );
  }
}

class _ModesView extends StatelessWidget {
  const _ModesView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final ModesState modesState = context.watch<ModesCubit>().state;
    final isTimerActive = context.select<TimerCubit, bool>(
      (cubit) => cubit.state.isActive,
    );

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
                context.read<ModesCubit>().selectMode(mode.id);
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
                      if (confirmed && context.mounted) {
                        context.read<ModesCubit>().deleteMode(mode.id);
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
