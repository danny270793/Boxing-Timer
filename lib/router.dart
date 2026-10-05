import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/timer/domain/entities/timer_mode.dart';
import 'pages/legal_info_page.dart';
import 'pages/mode_editor_page.dart';
import 'pages/modes_page.dart';
import 'pages/settings_page.dart';
import 'pages/splash_page.dart';
import 'pages/timer_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Builds the app router. Redirects re-run whenever [AuthCubit] emits.
GoRouter createRouter() {
  final auth = getIt<AuthCubit>();
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: _StreamListenable(auth.stream),
    redirect: (context, state) {
      final canUseApp = auth.state.canUseApp;
      final location = state.matchedLocation;
      if (location == '/splash') {
        return canUseApp ? '/' : '/login';
      }
      if (!canUseApp && location != '/login') return '/login';
      if (canUseApp && location == '/login') return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => _page(state, const SplashPage()),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => _page(state, const LoginPage()),
      ),
      GoRoute(
        path: '/',
        name: 'timer',
        pageBuilder: (context, state) => _page(state, const TimerPage()),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => _page(state, const SettingsPage()),
        routes: [
          GoRoute(
            path: 'modes',
            name: 'modes',
            pageBuilder: (context, state) => _page(state, const ModesPage()),
            routes: [
              GoRoute(
                path: 'mode',
                name: 'newMode',
                pageBuilder: (context, state) => _page(
                  state,
                  ModeEditorPage(template: state.extra as TimerMode?),
                ),
              ),
              GoRoute(
                path: 'mode/:id',
                name: 'editMode',
                pageBuilder: (context, state) => _page(
                  state,
                  ModeEditorPage(modeId: state.pathParameters['id']),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.about)),
          ),
          GoRoute(
            path: 'privacy',
            name: 'privacy',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.privacy)),
          ),
          GoRoute(
            path: 'terms',
            name: 'terms',
            pageBuilder: (context, state) =>
                _page(state, const LegalInfoPage(kind: LegalInfoKind.terms)),
          ),
        ],
      ),
    ],
  );
}

/// Routes declare their pages explicitly because go_router only falls back to
/// transition-less pages otherwise, which also drops the iOS swipe-back
/// gesture. [MaterialPage] restores the platform transition and the gesture.
MaterialPage<void> _page(GoRouterState state, Widget child) =>
    MaterialPage<void>(key: state.pageKey, name: state.name, child: child);

/// Adapts a cubit stream to the [Listenable] go_router uses for re-redirects.
class _StreamListenable extends ChangeNotifier {
  _StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
