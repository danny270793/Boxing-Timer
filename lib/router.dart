import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/timer/domain/entities/timer_mode.dart';
import 'pages/legal_info_page.dart';
import 'pages/mode_editor_page.dart';
import 'pages/modes_page.dart';
import 'pages/settings_page.dart';
import 'pages/timer_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Builds the app router. There is no sign-in, so the app opens on the timer.
GoRouter createRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
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
