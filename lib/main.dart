import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/persistence/shared_preferences_provider.dart';
import 'core/security/biometric_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/application/auth_controller.dart';
import 'features/settings/application/app_settings_controller.dart';
import 'l10n/generated/app_localizations.dart';
import 'routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    publishableKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const BoxingTimerApp(),
    ),
  );
}

class BoxingTimerApp extends ConsumerStatefulWidget {
  const BoxingTimerApp({super.key});

  @override
  ConsumerState<BoxingTimerApp> createState() => _BoxingTimerAppState();
}

class _BoxingTimerAppState extends ConsumerState<BoxingTimerApp>
    with WidgetsBindingObserver {
  bool _lockOnResume = false;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(
      Future<void>(
        () => ref
            .read(biometricControllerProvider.notifier)
            .refreshAvailability(),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockOnResume = true;
    } else if (state == AppLifecycleState.resumed && _lockOnResume) {
      _lockOnResume = false;
      final auth = ref.read(authControllerProvider);
      final biometric = ref.read(biometricControllerProvider);
      if (auth.isAuthenticated && biometric.enabled) {
        setState(() => _locked = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsControllerProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Boxing timer',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      debugShowCheckedModeBanner: true,
      builder: (context, child) {
        if (!_locked) return child ?? const SizedBox.shrink();
        return PopScope(
          canPop: false,
          child: _BiometricLockScreen(
            onUnlocked: () => setState(() => _locked = false),
          ),
        );
      },
    );
  }
}

class _BiometricLockScreen extends ConsumerStatefulWidget {
  const _BiometricLockScreen({required this.onUnlocked});

  final VoidCallback onUnlocked;

  @override
  ConsumerState<_BiometricLockScreen> createState() =>
      _BiometricLockScreenState();
}

class _BiometricLockScreenState extends ConsumerState<_BiometricLockScreen> {
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _unlock());
  }

  Future<void> _unlock() async {
    if (_busy) return;
    setState(() => _busy = true);
    final loc = AppLocalizations.of(context)!;
    final controller = ref.read(biometricControllerProvider.notifier);
    var unlocked = false;
    try {
      await controller.refreshAvailability();
      // Nothing left to unlock with: let the user back into the app rather
      // than trapping them behind a prompt that can never succeed.
      if (!ref.read(biometricControllerProvider).available ||
          !ref.read(authControllerProvider).isAuthenticated) {
        unlocked = true;
      } else {
        unlocked = await controller.authenticate(loc.biometricResumeReason);
      }
    } catch (_) {
      unlocked = false;
    }
    if (!mounted) return;
    setState(() => _busy = false);
    if (unlocked) widget.onUnlocked();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline_rounded, size: 56),
              const SizedBox(height: 20),
              Text(
                loc.biometricLockTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              Text(loc.biometricLockBody, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _busy ? null : _unlock,
                icon: const Icon(Icons.fingerprint),
                label: Text(loc.unlockButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
