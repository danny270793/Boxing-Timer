import 'package:boxing_timmer/core/di/injection.dart';
import 'package:boxing_timmer/features/timer/presentation/cubit/timer_cubit.dart';
import 'package:boxing_timmer/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpApp(
  WidgetTester tester, {
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  setupDi();
  await tester.runAsync(bootstrap);
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
}

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('app opens directly on the timer without a login screen', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('READY'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);

    await tester.tap(find.text('Start'));
    await tester.pump();

    expect(find.text('WARM UP'), findsOneWidget);
    expect(find.text('00:10'), findsOneWidget);

    getIt<TimerCubit>().stop();
  });

  testWidgets('settings show security biometric unlock and no sign in', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Security'), findsOneWidget);
    expect(find.text('Face ID & fingerprint'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
    expect(find.text('Sign out'), findsNothing);
    expect(find.text('Profile'), findsNothing);
  });

  testWidgets('settings about section offers Google Play rating', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Rate on Google Play'), 300);
    expect(find.text('Rate on Google Play'), findsOneWidget);
    expect(find.text('Privacy policy'), findsOneWidget);
    expect(find.text('Terms of use'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
  });
}
