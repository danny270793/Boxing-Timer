import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_controller.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/settings/presentation/pages/about_page.dart';
import '../features/settings/presentation/pages/privacy_policy_page.dart';
import '../features/settings/presentation/pages/settings_home_page.dart';
import '../features/settings/presentation/pages/terms_page.dart';
import '../features/timer/domain/entities/timer_mode.dart';
import '../features/timer/presentation/pages/mode_editor_page.dart';
import '../features/timer/presentation/pages/modes_page.dart';
import '../features/timer/presentation/pages/timer_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.read(authControllerProvider);
  final router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: auth,
    redirect: (context, state) {
      final location = state.matchedLocation;
      if (location == '/splash') {
        return auth.canUseApp ? '/' : '/login';
      }
      if (!auth.canUseApp && location != '/login') return '/login';
      if (auth.canUseApp && location == '/login') return '/';
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
        pageBuilder: (context, state) => _page(state, const SettingsHomePage()),
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
            pageBuilder: (context, state) => _page(state, const AboutPage()),
          ),
          GoRoute(
            path: 'terms',
            name: 'terms',
            pageBuilder: (context, state) => _page(state, const TermsPage()),
          ),
          GoRoute(
            path: 'privacy',
            name: 'privacy',
            pageBuilder: (context, state) =>
                _page(state, const PrivacyPolicyPage()),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Routes declare their pages explicitly because go_router only falls back to
/// transition-less pages otherwise, which also drops the iOS swipe-back
/// gesture. [MaterialPage] restores the platform transition and the gesture.
MaterialPage<void> _page(GoRouterState state, Widget child) =>
    MaterialPage<void>(key: state.pageKey, name: state.name, child: child);
