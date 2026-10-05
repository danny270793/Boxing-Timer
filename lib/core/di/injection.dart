import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../audio/sound_player.dart';
import '../locale/app_locale_controller.dart';
import '../security/app_biometric_unlock_controller.dart';
import '../theme/app_theme_controller.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/continue_without_account_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/update_email_usecase.dart';
import '../../features/auth/domain/usecases/update_password_usecase.dart';
import '../../features/auth/presentation/bloc/login_bloc.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/settings_cubit.dart';
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

/// Registers every dependency. [authRemoteDatasource] can be replaced
/// (e.g. in widget tests that run without Supabase).
void setupDi({AuthRemoteDatasource? authRemoteDatasource}) {
  getIt.registerLazySingleton<AppLocaleController>(AppLocaleController.new);
  getIt.registerLazySingleton<AppThemeController>(AppThemeController.new);
  getIt.registerLazySingleton<AppBiometricUnlockController>(
    AppBiometricUnlockController.new,
  );
  getIt.registerLazySingleton<SoundPlayer>(SoundPlayer.new);

  // auth
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () =>
        authRemoteDatasource ??
        AuthSupabaseDatasource(Supabase.instance.client),
  );
  getIt.registerLazySingleton<AuthLocalDatasource>(AuthLocalDatasource.new);
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDatasource>(),
      getIt<AuthLocalDatasource>(),
    ),
  );
  getIt.registerFactory<SignInUsecase>(() => SignInUsecase(getIt()));
  getIt.registerFactory<SignOutUsecase>(() => SignOutUsecase(getIt()));
  getIt.registerFactory<UpdateEmailUsecase>(() => UpdateEmailUsecase(getIt()));
  getIt.registerFactory<UpdatePasswordUsecase>(
    () => UpdatePasswordUsecase(getIt()),
  );
  getIt.registerFactory<ContinueWithoutAccountUsecase>(
    () => ContinueWithoutAccountUsecase(getIt()),
  );
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(repository: getIt(), continueWithoutAccount: getIt()),
  );
  getIt.registerFactory<LoginBloc>(() => LoginBloc(signIn: getIt()));
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit(signOut: getIt()));

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
