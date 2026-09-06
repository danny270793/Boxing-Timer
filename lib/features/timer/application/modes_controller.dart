import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/shared_preferences_provider.dart';
import '../data/mode_repository.dart';
import '../domain/entities/preset_modes.dart';
import '../domain/entities/timer_mode.dart';

final modeRepositoryProvider = Provider<ModeRepository>((ref) {
  return ModeRepository(ref.watch(sharedPreferencesProvider));
});

class ModesState {
  final List<TimerMode> customModes;
  final String selectedModeId;

  const ModesState({required this.customModes, required this.selectedModeId});

  List<TimerMode> get allModes => [...kPresetModes, ...customModes];

  TimerMode get selectedMode => allModes.firstWhere(
    (mode) => mode.id == selectedModeId,
    orElse: () => boxingPreset,
  );

  ModesState copyWith({List<TimerMode>? customModes, String? selectedModeId}) {
    return ModesState(
      customModes: customModes ?? this.customModes,
      selectedModeId: selectedModeId ?? this.selectedModeId,
    );
  }
}

class ModesController extends Notifier<ModesState> {
  @override
  ModesState build() {
    final repository = ref.watch(modeRepositoryProvider);
    return ModesState(
      customModes: repository.loadCustomModes(),
      selectedModeId: repository.loadSelectedModeId() ?? boxingPreset.id,
    );
  }

  void selectMode(String id) {
    state = state.copyWith(selectedModeId: id);
    ref.read(modeRepositoryProvider).saveSelectedModeId(id);
  }

  void upsertMode(TimerMode mode) {
    final updated = [
      ...state.customModes.where((existing) => existing.id != mode.id),
      mode,
    ];
    state = state.copyWith(customModes: updated, selectedModeId: mode.id);
    final repository = ref.read(modeRepositoryProvider);
    repository.saveCustomModes(updated);
    repository.saveSelectedModeId(mode.id);
  }

  void deleteMode(String id) {
    final updated = state.customModes
        .where((existing) => existing.id != id)
        .toList();
    final fallbackId = state.selectedModeId == id
        ? boxingPreset.id
        : state.selectedModeId;
    state = state.copyWith(customModes: updated, selectedModeId: fallbackId);
    final repository = ref.read(modeRepositoryProvider);
    repository.saveCustomModes(updated);
    repository.saveSelectedModeId(fallbackId);
  }
}

final modesControllerProvider = NotifierProvider<ModesController, ModesState>(
  ModesController.new,
);

final activeTimerModeProvider = Provider<TimerMode>((ref) {
  return ref.watch(modesControllerProvider).selectedMode;
});
