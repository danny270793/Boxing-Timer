import 'package:equatable/equatable.dart';

import '../../domain/entities/preset_modes.dart';
import '../../domain/entities/timer_mode.dart';

class ModesState extends Equatable {
  final List<TimerMode> customModes;
  final String selectedModeId;

  const ModesState({
    this.customModes = const [],
    this.selectedModeId = 'preset_boxing',
  });

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

  @override
  List<Object?> get props => [customModes, selectedModeId];
}
