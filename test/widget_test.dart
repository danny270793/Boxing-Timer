import 'dart:async';

import 'package:boxing_timmer/core/di/injection.dart';
import 'package:boxing_timmer/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:boxing_timmer/features/auth/domain/entities/user_entity.dart';
import 'package:boxing_timmer/features/timer/presentation/cubit/timer_cubit.dart';
import 'package:boxing_timmer/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuthRemoteDatasource implements AuthRemoteDatasource {
  FakeAuthRemoteDatasource([this._user]);

  final _changes = StreamController<UserEntity?>.broadcast();
  UserEntity? _user;

  @override
  UserEntity? get currentUser => _user;

  @override
  Stream<UserEntity?> get authStateChanges => _changes.stream;

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final user = UserEntity(id: 'user-1', email: email);
    _user = user;
    _changes.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _user = null;
    _changes.add(null);
  }

  @override
  Future<void> updateEmail({required String newEmail}) async {
    _user = UserEntity(id: _user?.id ?? 'user-1', email: newEmail);
    _changes.add(_user);
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {}
}

Future<void> pumpApp(
  WidgetTester tester, {
  required FakeAuthRemoteDatasource auth,
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  setupDi(authRemoteDatasource: auth);
  await tester.runAsync(bootstrap);
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
}

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('guest choice opens timer and remains local', (tester) async {
    await pumpApp(tester, auth: FakeAuthRemoteDatasource());

    expect(find.text('Continue without account'), findsOneWidget);
    await tester.tap(find.text('Continue without account'));
    await tester.pumpAndSettle();

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('READY'), findsOneWidget);

    await tester.tap(find.text('Start'));
    await tester.pump();

    expect(find.text('WARM UP'), findsOneWidget);
    expect(find.text('00:10'), findsOneWidget);

    getIt<TimerCubit>().stop();
  });

  testWidgets('persisted guest bypasses login', (tester) async {
    await pumpApp(
      tester,
      auth: FakeAuthRemoteDatasource(),
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
      auth: FakeAuthRemoteDatasource(
        const UserEntity(id: 'user-1', email: 'boxer@example.com'),
      ),
    );

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Change email'), findsOneWidget);
    expect(find.text('boxer@example.com'), findsOneWidget);
    expect(find.text('Change password'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Sign out'), 300);
    expect(find.text('Sign out'), findsOneWidget);
  });

  testWidgets('settings about section offers Google Play rating', (
    tester,
  ) async {
    await pumpApp(
      tester,
      auth: FakeAuthRemoteDatasource(),
      preferences: const {'continue_without_account': true},
    );

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Rate on Google Play'), 300);
    expect(find.text('Rate on Google Play'), findsOneWidget);
    expect(find.text('Privacy policy'), findsOneWidget);
  });
}
