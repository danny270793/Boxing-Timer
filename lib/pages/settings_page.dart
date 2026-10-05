import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;
import 'package:url_launcher/url_launcher.dart';

import '../core/di/injection.dart';
import '../core/locale/app_locale_controller.dart';
import '../core/security/app_biometric_unlock_controller.dart';
import '../core/theme/app_theme_controller.dart';
import '../features/auth/domain/usecases/update_email_usecase.dart';
import '../features/auth/domain/usecases/update_password_usecase.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/auth_state.dart';
import '../features/auth/presentation/cubit/settings_cubit.dart';
import '../features/auth/presentation/cubit/settings_state.dart';
import '../l10n/app_localizations.dart';
import '../widgets/bottom_sheet_pinned_title.dart';

const _playStoreUrl =
    'https://play.google.com/store/apps/details?id=io.github.danny270793.boxingtimmer';

String _languageOptionLabel(AppLocalizations l10n, AppLanguagePreference p) =>
    switch (p) {
      AppLanguagePreference.system => l10n.settingsLanguageSystem,
      AppLanguagePreference.en => l10n.settingsLanguageEnglish,
      AppLanguagePreference.es => l10n.settingsLanguageSpanish,
    };

String _themeOptionLabel(AppLocalizations l10n, AppThemePreference p) =>
    switch (p) {
      AppThemePreference.system => l10n.settingsThemeSystem,
      AppThemePreference.light => l10n.settingsThemeLight,
      AppThemePreference.dark => l10n.settingsThemeDark,
    };

Future<void> _showLanguagePickerSheet(
  BuildContext context,
  AppLocalizations l10n,
  AppLocaleController ctrl,
) async {
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (sheetContext) => BottomSheetPinnedTitleScrollView(
      padding: EdgeInsets.zero,
      title: l10n.settingsLanguage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final option in AppLanguagePreference.values)
            ListTile(
              title: Text(_languageOptionLabel(l10n, option)),
              trailing: ctrl.preference == option
                  ? Icon(
                      Icons.check,
                      color: Theme.of(sheetContext).colorScheme.primary,
                    )
                  : null,
              onTap: () async {
                await ctrl.setPreference(option);
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
        ],
      ),
    ),
  );
}

Future<void> _showThemePickerSheet(
  BuildContext context,
  AppLocalizations l10n,
  AppThemeController ctrl,
) async {
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (sheetContext) => BottomSheetPinnedTitleScrollView(
      padding: EdgeInsets.zero,
      title: l10n.settingsTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final option in AppThemePreference.values)
            ListTile(
              title: Text(_themeOptionLabel(l10n, option)),
              trailing: ctrl.preference == option
                  ? Icon(
                      Icons.check,
                      color: Theme.of(sheetContext).colorScheme.primary,
                    )
                  : null,
              onTap: () async {
                await ctrl.setPreference(option);
                if (sheetContext.mounted) Navigator.of(sheetContext).pop();
              },
            ),
        ],
      ),
    ),
  );
}

Future<void> _setBiometricUnlockEnabled(
  BuildContext context,
  AppLocalizations l10n,
  AppBiometricUnlockController ctrl,
  bool enabled,
) async {
  if (!enabled) {
    await ctrl.setEnabled(false);
    return;
  }
  await ctrl.refreshAuthenticatorAvailability();
  if (!ctrl.authenticatorAvailable) {
    if (context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(l10n.settingsBiometricUnavailable)),
      );
    }
    return;
  }
  final ok = await ctrl.localAuth
      .authenticate(
        localizedReason: l10n.settingsBiometricAuthReason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      )
      .catchError((Object _) => false, test: (e) => e is LocalAuthException);
  if (!context.mounted) {
    return;
  }
  if (ok) {
    await ctrl.setEnabled(true);
  }
}

Future<void> _showChangeEmailSheet(
  BuildContext context,
  AppLocalizations l10n,
) async {
  final email = getIt<AuthCubit>().state.user?.email ?? '';
  final ok = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (_) => BottomSheetPinnedTitleScrollView(
      title: l10n.settingsChangeEmailDialogTitle,
      child: _ChangeEmailSheetBody(
        hostContext: context,
        currentEmail: email,
        l10n: l10n,
      ),
    ),
  );
  if (ok == true && context.mounted) {
    unawaited(getIt<AuthCubit>().refresh());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.settingsChangeEmailSuccess)));
  }
}

Future<void> _showChangePasswordSheet(
  BuildContext context,
  AppLocalizations l10n,
) async {
  final ok = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (_) => BottomSheetPinnedTitleScrollView(
      title: l10n.settingsChangePasswordDialogTitle,
      child: _ChangePasswordSheetBody(hostContext: context, l10n: l10n),
    ),
  );
  if (ok == true && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.settingsChangePasswordSuccess)));
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        getIt<AppBiometricUnlockController>()
            .refreshAuthenticatorAvailability(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SettingsCubit>()),
        BlocProvider.value(value: getIt<AuthCubit>()),
      ],
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) async {
          if (state is SettingsSignedOut) {
            await getIt<AuthCubit>().refresh();
            if (context.mounted) context.go('/login');
          } else if (state is SettingsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? l10n.unexpectedError)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(l10n.settings)),
          body: SafeArea(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, auth) => ListView(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                children: [
                  if (auth.isAuthenticated) ...[
                    _SectionHeader(l10n.settingsProfileSection),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      leading: Icon(
                        Icons.person_outline_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      title: Text(l10n.settingsChangeEmail),
                      subtitle: Text(
                        auth.user?.email ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showChangeEmailSheet(context, l10n),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      leading: Icon(
                        Icons.lock_outline_rounded,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      title: Text(l10n.settingsChangePassword),
                      subtitle: Text(
                        l10n.settingsChangePasswordSubtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showChangePasswordSheet(context, l10n),
                    ),
                    const _SectionDivider(),
                    _SectionHeader(l10n.settingsSecuritySection),
                    ListenableBuilder(
                      listenable: getIt<AppBiometricUnlockController>(),
                      builder: (context, _) {
                        final bio = getIt<AppBiometricUnlockController>();
                        return SwitchListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          secondary: Icon(
                            Icons.fingerprint_rounded,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          title: Text(l10n.settingsBiometricUnlockTitle),
                          subtitle: Text(
                            bio.authenticatorAvailable
                                ? l10n.settingsBiometricUnlockSubtitle
                                : l10n.settingsBiometricUnavailable,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.35,
                            ),
                          ),
                          value: bio.enabled,
                          onChanged: bio.authenticatorAvailable
                              ? (v) => _setBiometricUnlockEnabled(
                                  context,
                                  l10n,
                                  bio,
                                  v,
                                )
                              : null,
                        );
                      },
                    ),
                    const _SectionDivider(),
                  ],
                  _SectionHeader(l10n.settingsAppearance),
                  ListenableBuilder(
                    listenable: getIt<AppLocaleController>(),
                    builder: (context, _) {
                      final ctrl = getIt<AppLocaleController>();
                      return _NavigationTile(
                        icon: Icons.language_outlined,
                        title: l10n.settingsLanguage,
                        subtitle: _languageOptionLabel(l10n, ctrl.preference),
                        onTap: () =>
                            _showLanguagePickerSheet(context, l10n, ctrl),
                      );
                    },
                  ),
                  ListenableBuilder(
                    listenable: getIt<AppThemeController>(),
                    builder: (context, _) {
                      final ctrl = getIt<AppThemeController>();
                      return _NavigationTile(
                        icon: Icons.palette_outlined,
                        title: l10n.settingsTheme,
                        subtitle: _themeOptionLabel(l10n, ctrl.preference),
                        onTap: () => _showThemePickerSheet(context, l10n, ctrl),
                      );
                    },
                  ),
                  const _SectionDivider(),
                  _SectionHeader(l10n.settingsTimerSection),
                  _NavigationTile(
                    icon: Icons.timer_outlined,
                    title: l10n.modesMenuTitle,
                    subtitle: l10n.modesMenuSubtitle,
                    onTap: () => context.push('/settings/modes'),
                  ),
                  const _SectionDivider(),
                  _SectionHeader(l10n.settingsAboutSection),
                  _NavigationTile(
                    icon: Icons.info_outline_rounded,
                    title: l10n.settingsAboutApp,
                    onTap: () => context.push('/settings/about'),
                  ),
                  _NavigationTile(
                    icon: Icons.star_outline_rounded,
                    title: l10n.settingsRateApp,
                    trailingIcon: Icons.open_in_new_rounded,
                    onTap: () => launchUrl(
                      Uri.parse(_playStoreUrl),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  _NavigationTile(
                    icon: Icons.privacy_tip_outlined,
                    title: l10n.settingsPrivacyPolicy,
                    onTap: () => context.push('/settings/privacy'),
                  ),
                  _NavigationTile(
                    icon: Icons.description_outlined,
                    title: l10n.settingsTermsOfUse,
                    onTap: () => context.push('/settings/terms'),
                  ),
                  const _SectionDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: auth.isAuthenticated
                          ? const _SignOutButton()
                          : FilledButton.icon(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () => getIt<AuthCubit>().showSignIn(),
                              icon: const Icon(Icons.login_rounded),
                              label: Text(l10n.signIn),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final signOutStyle = FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.error,
          foregroundColor: theme.colorScheme.onError,
          padding: const EdgeInsets.symmetric(vertical: 14),
        );
        return state is SettingsLoading
            ? FilledButton(
                style: signOutStyle,
                onPressed: null,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.onError,
                  ),
                ),
              )
            : FilledButton.icon(
                style: signOutStyle,
                onPressed: () => context.read<SettingsCubit>().signOut(),
                icon: const Icon(Icons.logout_rounded),
                label: Text(l10n.signOut),
              );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Divider(height: 1),
  );
}

class _NavigationTile extends StatelessWidget {
  const _NavigationTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailingIcon = Icons.chevron_right,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final IconData trailingIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: Icon(trailingIcon),
      onTap: onTap,
    );
  }
}

class _ChangeEmailSheetBody extends StatefulWidget {
  const _ChangeEmailSheetBody({
    required this.hostContext,
    required this.currentEmail,
    required this.l10n,
  });

  final BuildContext hostContext;
  final String currentEmail;
  final AppLocalizations l10n;

  @override
  State<_ChangeEmailSheetBody> createState() => _ChangeEmailSheetBodyState();
}

class _ChangeEmailSheetBodyState extends State<_ChangeEmailSheetBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(widget.hostContext)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final next = _controller.text.trim();
    if (next == widget.currentEmail.trim()) {
      _snack(widget.l10n.settingsChangeEmailSameAsCurrent);
      return;
    }
    setState(() => _loading = true);
    try {
      await getIt<UpdateEmailUsecase>()(newEmail: next);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on AuthException catch (e) {
      if (mounted) setState(() => _loading = false);
      _snack(e.message);
    } catch (_) {
      if (mounted) setState(() => _loading = false);
      _snack(widget.l10n.unexpectedError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            autofocus: true,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(labelText: l10n.settingsNewEmailLabel),
            enabled: !_loading,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l10n.fieldRequired;
              final t = v.trim();
              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t)) {
                return l10n.settingsChangeEmailInvalid;
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.settingsChangeEmailSubmit),
          ),
        ],
      ),
    );
  }
}

const int _kMinPasswordLength = 6;

class _ChangePasswordSheetBody extends StatefulWidget {
  const _ChangePasswordSheetBody({
    required this.hostContext,
    required this.l10n,
  });

  final BuildContext hostContext;
  final AppLocalizations l10n;

  @override
  State<_ChangePasswordSheetBody> createState() =>
      _ChangePasswordSheetBodyState();
}

class _ChangePasswordSheetBodyState extends State<_ChangePasswordSheetBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _newController;
  late final TextEditingController _confirmController;
  bool _loading = false;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _newController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(widget.hostContext)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await getIt<UpdatePasswordUsecase>()(newPassword: _newController.text);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on AuthException catch (e) {
      if (mounted) setState(() => _loading = false);
      _snack(e.message);
    } catch (_) {
      if (mounted) setState(() => _loading = false);
      _snack(widget.l10n.unexpectedError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _newController,
            obscureText: _obscureNew,
            textInputAction: TextInputAction.next,
            autofocus: true,
            autofillHints: const [AutofillHints.newPassword],
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: l10n.settingsNewPasswordLabel,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNew ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => _obscureNew = !_obscureNew),
              ),
            ),
            enabled: !_loading,
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.fieldRequired;
              if (v.length < _kMinPasswordLength) {
                return l10n.settingsPasswordTooShort;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _confirmController,
            obscureText: _obscureConfirm,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: l10n.settingsConfirmNewPasswordLabel,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
            ),
            enabled: !_loading,
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.fieldRequired;
              if (v != _newController.text) {
                return l10n.settingsPasswordsDoNotMatch;
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.settingsChangePasswordSubmit),
          ),
        ],
      ),
    );
  }
}
