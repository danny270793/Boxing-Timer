import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/security/biometric_controller.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/app_settings_controller.dart';
import '../widgets/language_picker_dialog.dart';
import '../widgets/theme_picker_dialog.dart';

class SettingsHomePage extends ConsumerStatefulWidget {
  const SettingsHomePage({super.key});

  @override
  ConsumerState<SettingsHomePage> createState() => _SettingsHomePageState();
}

class _SettingsHomePageState extends ConsumerState<SettingsHomePage> {
  bool _signingOut = false;

  String _themeLabel(AppLocalizations loc, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return loc.themeLight;
      case ThemeMode.dark:
        return loc.themeDark;
      case ThemeMode.system:
        return loc.themeSystem;
    }
  }

  String _languageLabel(AppLocalizations loc, Locale? locale) {
    switch (locale?.languageCode) {
      case 'en':
        return loc.languageEnglish;
      case 'es':
        return loc.languageSpanish;
      default:
        return loc.languageSystemDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final settings = ref.watch(appSettingsControllerProvider);
    final auth = ref.watch(authControllerProvider);
    final biometric = ref.watch(biometricControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settingsTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            if (auth.isAuthenticated) ...[
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(loc.changeEmail),
                subtitle: Text(auth.user?.email ?? ''),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showChangeEmailDialog(context, ref),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text(loc.changePassword),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showChangePasswordDialog(context, ref),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.fingerprint),
                title: Text(loc.biometricUnlock),
                subtitle: Text(
                  biometric.available
                      ? loc.biometricUnlockSubtitle
                      : loc.biometricUnavailable,
                ),
                value: biometric.enabled,
                onChanged: (value) async {
                  final controller = ref.read(
                    biometricControllerProvider.notifier,
                  );
                  if (!value) {
                    await controller.setEnabled(false);
                    return;
                  }
                  final enabled = await controller.enable(
                    loc.biometricEnableReason,
                  );
                  if (!enabled && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.biometricUnavailable)),
                    );
                  }
                },
              ),
              const Divider(height: 1),
            ],
            ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: Text(loc.modesMenuTitle),
              subtitle: Text(loc.modesMenuSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/modes'),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: Text(loc.themeMenuTitle),
              subtitle: Text(_themeLabel(loc, settings.themeMode)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showThemePickerDialog(context),
            ),
            ListTile(
              leading: const Icon(Icons.language_outlined),
              title: Text(loc.languageMenuTitle),
              subtitle: Text(_languageLabel(loc, settings.locale)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => showLanguagePickerDialog(context),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(loc.aboutMenuTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/about'),
            ),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(loc.termsMenuTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/terms'),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(loc.privacyMenuTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/settings/privacy'),
            ),
            const SizedBox(height: 24),
            if (auth.isAuthenticated)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _signingOut
                      ? null
                      : () async {
                          setState(() => _signingOut = true);
                          try {
                            await ref.read(authControllerProvider).signOut();
                            if (context.mounted) context.go('/login');
                          } on AuthException catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.message)),
                              );
                            }
                          } finally {
                            if (mounted) setState(() => _signingOut = false);
                          }
                        },
                  icon: const Icon(Icons.logout),
                  label: Text(loc.signOut),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.login),
                  label: Text(loc.signIn),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChangeEmailDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final loc = AppLocalizations.of(context)!;
    final controller = TextEditingController(
      text: ref.read(authControllerProvider).user?.email ?? '',
    );
    await _showUpdateDialog(
      context: context,
      title: loc.changeEmail,
      label: loc.newEmail,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        final email = value?.trim() ?? '';
        if (email.isEmpty) return loc.fieldRequired;
        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
          return loc.invalidEmail;
        }
        return null;
      },
      update: (value) =>
          ref.read(authControllerProvider).updateEmail(value.trim()),
      successMessage: loc.emailUpdated,
    );
    controller.dispose();
  }

  Future<void> _showChangePasswordDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final loc = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    await _showUpdateDialog(
      context: context,
      title: loc.changePassword,
      label: loc.newPassword,
      controller: controller,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) return loc.fieldRequired;
        if (value.length < 6) return loc.passwordTooShort;
        return null;
      },
      update: ref.read(authControllerProvider).updatePassword,
      successMessage: loc.passwordUpdated,
    );
    controller.dispose();
  }

  Future<void> _showUpdateDialog({
    required BuildContext context,
    required String title,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required Future<void> Function(String) update,
    required String successMessage,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) async {
    final formKey = GlobalKey<FormState>();
    var loading = false;
    final success = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              autofocus: true,
              enabled: !loading,
              validator: validator,
              decoration: InputDecoration(labelText: label),
            ),
          ),
          actions: [
            TextButton(
              onPressed: loading ? null : () => Navigator.pop(context, false),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            FilledButton(
              onPressed: loading
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;
                      setDialogState(() => loading = true);
                      try {
                        await update(controller.text);
                        if (context.mounted) Navigator.pop(context, true);
                      } on AuthException catch (error) {
                        if (context.mounted) {
                          setDialogState(() => loading = false);
                        }
                        if (mounted) {
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            SnackBar(content: Text(error.message)),
                          );
                        }
                      }
                    },
              child: Text(AppLocalizations.of(context)!.saveButton),
            ),
          ],
        ),
      ),
    );
    if (success == true && mounted) {
      ScaffoldMessenger.of(this.context)
          .showSnackBar(SnackBar(content: Text(successMessage)));
    }
  }
}
