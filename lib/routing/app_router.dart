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
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        name: 'timer',
        builder: (context, state) => const TimerPage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsHomePage(),
        routes: [
          GoRoute(
            path: 'modes',
            name: 'modes',
            builder: (context, state) => const ModesPage(),
            routes: [
              GoRoute(
                path: 'mode',
                name: 'newMode',
                builder: (context, state) =>
                    ModeEditorPage(template: state.extra as TimerMode?),
              ),
              GoRoute(
                path: 'mode/:id',
                name: 'editMode',
                builder: (context, state) =>
                    ModeEditorPage(modeId: state.pathParameters['id']),
              ),
            ],
          ),
          GoRoute(
            path: 'about',
            name: 'about',
            builder: (context, state) => const AboutPage(),
          ),
          GoRoute(
            path: 'terms',
            name: 'terms',
            builder: (context, state) => const TermsPage(),
          ),
          GoRoute(
            path: 'privacy',
            name: 'privacy',
            builder: (context, state) => const PrivacyPolicyPage(),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
