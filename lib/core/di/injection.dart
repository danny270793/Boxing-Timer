import 'package:get_it/get_it.dart';

import '../audio/sound_player.dart';
import '../locale/app_locale_controller.dart';
import '../security/app_biometric_unlock_controller.dart';
import '../theme/app_theme_controller.dart';
import '../../features/timer/data/datasources/modes_local_datasource.dart';
import '../../features/timer/data/repositories/modes_repository_impl.dart';
import '../../features/timer/domain/repositories/modes_repository.dart';
import '../../features/timer/domain/usecases/get_custom_modes_usecase.dart';
import '../../features/timer/domain/usecases/get_selected_mode_id_usecase.dart';
import '../../features/timer/domain/usecases/save_custom_modes_usecase.dart';
import '../../features/timer/domain/usecases/save_selected_mode_id_usecase.dart';
import '../../features/timer/presentation/cubit/modes_cubit.dart';
import '../../features/timer/presentation/cubit/timer_cubit.dart';

final getIt = GetIt.instance;

/// Registers every dependency.
void setupDi() {
  getIt.registerLazySingleton<AppLocaleController>(AppLocaleController.new);
  getIt.registerLazySingleton<AppThemeController>(AppThemeController.new);
  getIt.registerLazySingleton<AppBiometricUnlockController>(
    AppBiometricUnlockController.new,
  );
  getIt.registerLazySingleton<SoundPlayer>(SoundPlayer.new);

  // timer
  getIt.registerLazySingleton<ModesLocalDatasource>(ModesLocalDatasource.new);
  getIt.registerLazySingleton<ModesRepository>(
    () => ModesRepositoryImpl(getIt<ModesLocalDatasource>()),
  );
  getIt.registerFactory<GetCustomModesUsecase>(
    () => GetCustomModesUsecase(getIt()),
  );
  getIt.registerFactory<SaveCustomModesUsecase>(
    () => SaveCustomModesUsecase(getIt()),
  );
  getIt.registerFactory<GetSelectedModeIdUsecase>(
    () => GetSelectedModeIdUsecase(getIt()),
  );
  getIt.registerFactory<SaveSelectedModeIdUsecase>(
    () => SaveSelectedModeIdUsecase(getIt()),
  );
  // App-wide: the running fight and the selected mode outlive any one page.
  getIt.registerLazySingleton<ModesCubit>(
    () => ModesCubit(
      getCustomModes: getIt(),
      saveCustomModes: getIt(),
      getSelectedModeId: getIt(),
      saveSelectedModeId: getIt(),
    ),
  );
  getIt.registerLazySingleton<TimerCubit>(
    () => TimerCubit(modes: getIt(), sounds: getIt()),
  );
}
