import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/preset_modes.dart';
import '../../domain/entities/timer_mode.dart';
import '../../domain/usecases/get_custom_modes_usecase.dart';
import '../../domain/usecases/get_selected_mode_id_usecase.dart';
import '../../domain/usecases/save_custom_modes_usecase.dart';
import '../../domain/usecases/save_selected_mode_id_usecase.dart';
import 'modes_state.dart';

class ModesCubit extends Cubit<ModesState> {
  final GetCustomModesUsecase _getCustomModes;
  final SaveCustomModesUsecase _saveCustomModes;
  final GetSelectedModeIdUsecase _getSelectedModeId;
  final SaveSelectedModeIdUsecase _saveSelectedModeId;

  ModesCubit({
    required this._getCustomModes,
    required this._saveCustomModes,
    required this._getSelectedModeId,
    required this._saveSelectedModeId,
  }) : super(const ModesState());

  /// The mode the timer should use for the next fight.
  TimerMode get activeMode => state.selectedMode;

  Future<void> load() async {
    final customModes = await _getCustomModes();
    final selectedModeId = await _getSelectedModeId() ?? boxingPreset.id;
    emit(ModesState(customModes: customModes, selectedModeId: selectedModeId));
  }

  void selectMode(String id) {
    emit(state.copyWith(selectedModeId: id));
    unawaited(_saveSelectedModeId(id));
  }

  void upsertMode(TimerMode mode) {
    final updated = [
      ...state.customModes.where((existing) => existing.id != mode.id),
      mode,
    ];
    emit(state.copyWith(customModes: updated, selectedModeId: mode.id));
    unawaited(_saveCustomModes(updated));
    unawaited(_saveSelectedModeId(mode.id));
  }

  void deleteMode(String id) {
    final updated = state.customModes
        .where((existing) => existing.id != id)
        .toList();
    final fallbackId = state.selectedModeId == id
        ? boxingPreset.id
        : state.selectedModeId;
    emit(state.copyWith(customModes: updated, selectedModeId: fallbackId));
    unawaited(_saveCustomModes(updated));
    unawaited(_saveSelectedModeId(fallbackId));
  }
}
