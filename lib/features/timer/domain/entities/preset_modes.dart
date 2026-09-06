import 'timer_mode.dart';

const boxingPreset = TimerMode(
  id: 'preset_boxing',
  name: 'Boxing',
  totalRounds: 12,
  roundSeconds: 180,
  restSeconds: 60,
);

const mmaNormalPreset = TimerMode(
  id: 'preset_mma_normal',
  name: 'MMA — Normal',
  totalRounds: 3,
  roundSeconds: 300,
  restSeconds: 60,
);

const mmaChampionshipPreset = TimerMode(
  id: 'preset_mma_championship',
  name: 'MMA — Championship',
  totalRounds: 5,
  roundSeconds: 300,
  restSeconds: 60,
);

const kPresetModes = [boxingPreset, mmaNormalPreset, mmaChampionshipPreset];

final kPresetModeIds = kPresetModes.map((mode) => mode.id).toSet();
