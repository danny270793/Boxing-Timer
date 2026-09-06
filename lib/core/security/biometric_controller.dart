import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../persistence/shared_preferences_provider.dart';

abstract class BiometricService {
  Future<bool> isAvailable();
  Future<bool> authenticate(String reason);
}

class LocalBiometricService implements BiometricService {
  LocalBiometricService(this._auth);

  final LocalAuthentication _auth;

  @override
  Future<bool> isAvailable() async {
    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      final types = await _auth.getAvailableBiometrics();
      return supported && (canCheck || types.isNotEmpty);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) {
    return _auth.authenticate(
      localizedReason: reason,
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }
}

final biometricServiceProvider = Provider<BiometricService>((ref) {
  return LocalBiometricService(LocalAuthentication());
});

class BiometricState {
  const BiometricState({required this.enabled, required this.available});

  final bool enabled;
  final bool available;

  BiometricState copyWith({bool? enabled, bool? available}) {
    return BiometricState(
      enabled: enabled ?? this.enabled,
      available: available ?? this.available,
    );
  }
}

class BiometricController extends Notifier<BiometricState> {
  static const _key = 'biometric_unlock_enabled';

  @override
  BiometricState build() {
    final enabled = ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;
    return BiometricState(enabled: enabled, available: false);
  }

  Future<void> refreshAvailability() async {
    final available = await ref.read(biometricServiceProvider).isAvailable();
    state = state.copyWith(available: available);
  }

  Future<bool> enable(String reason) async {
    await refreshAvailability();
    if (!state.available) return false;
    final authenticated = await ref
        .read(biometricServiceProvider)
        .authenticate(reason);
    if (authenticated) await setEnabled(true);
    return authenticated;
  }

  Future<void> setEnabled(bool value) async {
    state = state.copyWith(enabled: value);
    await ref.read(sharedPreferencesProvider).setBool(_key, value);
  }

  Future<bool> authenticate(String reason) =>
      ref.read(biometricServiceProvider).authenticate(reason);
}

final biometricControllerProvider =
    NotifierProvider<BiometricController, BiometricState>(
      BiometricController.new,
    );
