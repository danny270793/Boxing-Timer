import 'dart:async';

import 'package:boxing_timmer/core/persistence/shared_preferences_provider.dart';
import 'package:boxing_timmer/core/security/biometric_controller.dart';
import 'package:boxing_timmer/features/auth/application/auth_controller.dart';
import 'package:boxing_timmer/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuthService implements AuthService {
  FakeAuthService([this._user]);

  final _changes = StreamController<AuthUser?>.broadcast();
  AuthUser? _user;

  @override
  AuthUser? get currentUser => _user;

  @override
  Stream<AuthUser?> get authStateChanges => _changes.stream;

  @override
  Future<void> signIn({required String email, required String password}) async {
    _user = AuthUser(email: email);
    _changes.add(_user);
  }

  @override
  Future<void> signOut() async {
    _user = null;
    _changes.add(null);
  }

  @override
  Future<void> updateEmail(String email) async {
    _user = AuthUser(email: email);
    _changes.add(_user);
  }

  @override
  Future<void> updatePassword(String password) async {}
}

class FakeBiometricService implements BiometricService {
  @override
  Future<bool> authenticate(String reason) async => true;

  @override
  Future<bool> isAvailable() async => true;
}

Future<void> pumpApp(
  WidgetTester tester, {
  required FakeAuthService auth,
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        authServiceProvider.overrideWithValue(auth),
        biometricServiceProvider.overrideWithValue(FakeBiometricService()),
      ],
      child: const BoxingTimerApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('guest choice opens timer and remains local', (tester) async {
    await pumpApp(tester, auth: FakeAuthService());

    expect(find.text('Continue without account'), findsOneWidget);
    await tester.tap(find.text('Continue without account'));
    await tester.pumpAndSettle();

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('READY'), findsOneWidget);

    await tester.tap(find.text('Start'));
    await tester.pump();

    expect(find.text('WARM UP'), findsOneWidget);
    expect(find.text('00:10'), findsOneWidget);
  });

  testWidgets('persisted guest bypasses login', (tester) async {
    await pumpApp(
      tester,
      auth: FakeAuthService(),
      preferences: const {'continue_without_account': true},
    );

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
  });

  testWidgets('authenticated settings show profile and sign out', (
    tester,
  ) async {
    await pumpApp(
      tester,
      auth: FakeAuthService(const AuthUser(email: 'boxer@example.com')),
    );

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Change email'), findsOneWidget);
    expect(find.text('boxer@example.com'), findsOneWidget);
    expect(find.text('Change password'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Sign out'), 300);
    expect(find.text('Sign out'), findsOneWidget);
  });
}
