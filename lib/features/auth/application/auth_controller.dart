import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/persistence/shared_preferences_provider.dart';

class AuthUser {
  const AuthUser({required this.email});

  final String email;
}

abstract class AuthService {
  AuthUser? get currentUser;
  Stream<AuthUser?> get authStateChanges;

  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> updateEmail(String email);
  Future<void> updatePassword(String password);
}

class SupabaseAuthService implements AuthService {
  SupabaseAuthService(this._client);

  final SupabaseClient _client;

  @override
  AuthUser? get currentUser {
    final user = _client.auth.currentUser;
    return user == null ? null : AuthUser(email: user.email ?? '');
  }

  @override
  Stream<AuthUser?> get authStateChanges =>
      _client.auth.onAuthStateChange.map((event) {
        final user = event.session?.user;
        return user == null ? null : AuthUser(email: user.email ?? '');
      });

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  Future<void> updateEmail(String email) =>
      _client.auth.updateUser(UserAttributes(email: email));

  @override
  Future<void> updatePassword(String password) =>
      _client.auth.updateUser(UserAttributes(password: password));
}

final authServiceProvider = Provider<AuthService>((ref) {
  return SupabaseAuthService(Supabase.instance.client);
});

class AuthController extends ChangeNotifier {
  AuthController(this._service, this._prefs) {
    _user = _service.currentUser;
    _continueAsGuest = _prefs.getBool(_guestKey) ?? false;
    _subscription = _service.authStateChanges.listen((user) {
      _user = user;
      if (user != null) {
        _continueAsGuest = false;
        unawaited(_prefs.setBool(_guestKey, false));
      }
      notifyListeners();
    });
  }

  static const _guestKey = 'continue_without_account';

  final AuthService _service;
  final SharedPreferences _prefs;
  late final StreamSubscription<AuthUser?> _subscription;
  AuthUser? _user;
  bool _continueAsGuest = false;

  AuthUser? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isGuest => !isAuthenticated && _continueAsGuest;
  bool get canUseApp => isAuthenticated || isGuest;

  Future<void> signIn({required String email, required String password}) async {
    await _service.signIn(email: email, password: password);
    _user = _service.currentUser;
    _continueAsGuest = false;
    await _prefs.setBool(_guestKey, false);
    notifyListeners();
  }

  Future<void> continueWithoutAccount() async {
    _continueAsGuest = true;
    await _prefs.setBool(_guestKey, true);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _service.signOut();
    _user = null;
    _continueAsGuest = false;
    await _prefs.setBool(_guestKey, false);
    notifyListeners();
  }

  Future<void> updateEmail(String email) async {
    await _service.updateEmail(email);
    _user = _service.currentUser;
    notifyListeners();
  }

  Future<void> updatePassword(String password) =>
      _service.updatePassword(password);

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final authControllerProvider = ChangeNotifierProvider<AuthController>((ref) {
  return AuthController(
    ref.watch(authServiceProvider),
    ref.watch(sharedPreferencesProvider),
  );
});
