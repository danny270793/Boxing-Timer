// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Boxing Timer';

  @override
  String get phaseWarmup => 'WARM UP';

  @override
  String get phaseRound => 'ROUND';

  @override
  String get phaseRest => 'REST';

  @override
  String get phaseFinished => 'FIGHT OVER';

  @override
  String get phaseReady => 'READY';

  @override
  String roundsAhead(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rounds ahead',
      one: '1 round ahead',
    );
    return '$_temp0';
  }

  @override
  String get getReady => 'Get ready...';

  @override
  String roundProgress(int current, int total) {
    return 'Round $current / $total';
  }

  @override
  String completedRounds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Completed $count / $count rounds',
      one: 'Completed 1 / 1 round',
    );
    return '$_temp0';
  }

  @override
  String get startButton => 'Start';

  @override
  String get startNewFightButton => 'Start new fight';

  @override
  String get pauseButton => 'Pause';

  @override
  String get resumeButton => 'Resume';

  @override
  String get stopButton => 'Stop';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get deleteButton => 'Delete';

  @override
  String get stopDialogTitle => 'Stop the fight?';

  @override
  String get stopDialogBody =>
      'This will stop the timer completely and reset it back to the start.';

  @override
  String get settingsProfileSection => 'Profile';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsTimerSection => 'Timer';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get modesMenuTitle => 'Modes';

  @override
  String get modesMenuSubtitle => 'Rounds, timing and presets';

  @override
  String get signIn => 'Sign in';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInSubtitle =>
      'Sign in to protect your settings, or keep using the timer locally.';

  @override
  String get continueWithoutAccount => 'Continue without account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get unexpectedError => 'Something went wrong. Please try again.';

  @override
  String get biometricLockTitle => 'Boxing Timer is locked';

  @override
  String get biometricLockBody => 'Authenticate to continue.';

  @override
  String get modesTitle => 'Modes';

  @override
  String get newModeButton => 'New mode';

  @override
  String get newModeTitle => 'New mode';

  @override
  String get editModeTitle => 'Edit mode';

  @override
  String get nameFieldLabel => 'Name';

  @override
  String get roundsSectionTitle => 'ROUNDS';

  @override
  String get roundsLabel => 'Rounds';

  @override
  String get roundDurationSectionTitle => 'ROUND DURATION';

  @override
  String get restDurationSectionTitle => 'REST DURATION';

  @override
  String get minutesLabel => 'Minutes';

  @override
  String get secondsLabel => 'Seconds';

  @override
  String get saveModeButton => 'Save mode';

  @override
  String get nameRequiredError => 'Give this mode a name.';

  @override
  String get roundDurationRequiredError =>
      'Round duration must be greater than 0.';

  @override
  String get duplicateTooltip => 'Duplicate';

  @override
  String get editTooltip => 'Edit';

  @override
  String get deleteTooltip => 'Delete';

  @override
  String get deleteModeDialogTitle => 'Delete mode?';

  @override
  String deleteModeDialogBody(String name) {
    return 'This will permanently delete \"$name\".';
  }

  @override
  String get switchModeBlockedSnackbar =>
      'Stop the current fight before switching modes.';

  @override
  String copyOfMode(String name) {
    return 'Copy of $name';
  }

  @override
  String modeRoundsCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rounds',
      one: '1 round',
    );
    return '$_temp0';
  }

  @override
  String workDuration(String duration) {
    return '$duration work';
  }

  @override
  String restDuration(String duration) {
    return '$duration rest';
  }

  @override
  String get settings => 'Settings';

  @override
  String get settingsChangeEmail => 'Change email';

  @override
  String get settingsChangeEmailDialogTitle => 'Change email';

  @override
  String get settingsNewEmailLabel => 'New email';

  @override
  String get settingsChangeEmailSubmit => 'Update';

  @override
  String get settingsChangeEmailSuccess =>
      'Check your new email to confirm the change.';

  @override
  String get settingsChangeEmailInvalid => 'Enter a valid email address.';

  @override
  String get settingsChangeEmailSameAsCurrent => 'That is already your email.';

  @override
  String get settingsChangePassword => 'Change password';

  @override
  String get settingsChangePasswordSubtitle =>
      'Updates the password you use to sign in.';

  @override
  String get settingsChangePasswordDialogTitle => 'Change password';

  @override
  String get settingsNewPasswordLabel => 'New password';

  @override
  String get settingsConfirmNewPasswordLabel => 'Confirm new password';

  @override
  String get settingsChangePasswordSubmit => 'Update password';

  @override
  String get settingsChangePasswordSuccess => 'Your password was updated.';

  @override
  String get settingsPasswordsDoNotMatch => 'Passwords do not match.';

  @override
  String get settingsPasswordTooShort =>
      'Password must be at least 6 characters.';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID & fingerprint';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Require authentication when returning to the app.';

  @override
  String get settingsBiometricUnavailable =>
      'Biometric unlock is not available on this device.';

  @override
  String get settingsBiometricAuthReason =>
      'Enable biometric unlock for Boxing Timer';

  @override
  String get settingsBiometricResumeReason => 'Unlock Boxing Timer';

  @override
  String get biometricLockUnlockButton => 'Unlock';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Spanish';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System default';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsAboutApp => 'About';

  @override
  String get settingsRateApp => 'Rate on Google Play';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTermsOfUse => 'Terms of use';

  @override
  String get settingsAboutTagline =>
      'Round timer for boxing, MMA, and combat sports training.';

  @override
  String get settingsAboutVersionLabel => 'Version';

  @override
  String get settingsAboutFeaturesHeading => 'What you can do';

  @override
  String get settingsAboutBulletRounds =>
      'Run structured warm-up, round, and rest timers for boxing, MMA, and other combat sports.';

  @override
  String get settingsAboutBulletModes =>
      'Start from the boxing and MMA presets or save your favorite setups as custom modes.';

  @override
  String get settingsAboutBulletSounds =>
      'Train with audio cues for round starts and the final ten seconds of each round.';

  @override
  String get settingsAboutDataHeading => 'Your data';

  @override
  String get settingsAboutDataBody =>
      'Training modes and preferences are stored on this device. Signing in is optional and handled by Supabase.';

  @override
  String get settingsAboutDeveloperHeading => 'Developer';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Website';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyTagline =>
      'How Boxing Timer handles your information.';

  @override
  String get settingsPrivacyDataTitle => 'Account (optional)';

  @override
  String get settingsPrivacyDataBody =>
      'You can use the app without an account. If you sign in, authentication is provided by Supabase. Your email and credentials are processed by Supabase; this app does not store your password.';

  @override
  String get settingsPrivacyInfraTitle => 'What we store today — and later';

  @override
  String get settingsPrivacyInfraBody =>
      'Custom training modes and preferences (theme, language, selected mode) are stored locally on your device. We do not currently upload app-generated data such as saved modes or favorites. In the future, if you are signed in, we may store that kind of information in Supabase so it can sync across your devices.';

  @override
  String get settingsPrivacyAnalyticsTitle => 'No analytics or advertising';

  @override
  String get settingsPrivacyAnalyticsBody =>
      'The app does not include third-party analytics, tracking, or advertising software.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permissions';

  @override
  String get settingsPrivacyPermissionsBody =>
      'Device permissions are limited to what is required for the timer, sounds, and optional biometric unlock.';

  @override
  String get settingsPrivacySharingTitle => 'Data sharing';

  @override
  String get settingsPrivacySharingBody =>
      'We do not sell your personal information. Sign-in data is processed by Supabase. Later cloud sync, if enabled, would also use Supabase.';

  @override
  String get settingsPrivacyNoticeTitle => 'Changes to this policy';

  @override
  String get settingsPrivacyNoticeBody =>
      'This privacy policy may be updated from time to time. Continued use of the app after changes means you accept the updated policy.';

  @override
  String get settingsTermsTagline => 'Rules for using Boxing Timer.';

  @override
  String get settingsTermsAcceptanceTitle => 'Acceptance';

  @override
  String get settingsTermsAcceptanceBody =>
      'These terms govern your use of Boxing Timer (the \"app\"). By downloading, installing, or using the app, you agree to be bound by these terms. If you do not agree, do not use the app.';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Use of the app';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'The app is provided for personal, non-commercial use as a round timer for boxing, MMA, and other combat sports training. You are responsible for using the app safely and are solely responsible for any injury or harm arising from your training activities.';

  @override
  String get settingsTermsAccountTitle => 'Optional account';

  @override
  String get settingsTermsAccountBody =>
      'You can use the app without signing in. If you create an account, sign-in is handled by Supabase. Training modes and similar app-generated data stay on this device today. Later versions may store that information in Supabase when you are signed in so it can sync across your devices.';

  @override
  String get settingsTermsDisclaimerTitle => 'No professional advice';

  @override
  String get settingsTermsDisclaimerBody =>
      'The app does not provide medical, coaching, or professional training advice. Consult a qualified professional before starting any exercise program.';

  @override
  String get settingsTermsIpTitle => 'Intellectual property';

  @override
  String get settingsTermsIpBody =>
      'All content, design, and code in the app are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.';

  @override
  String get settingsTermsLiabilityTitle => 'Warranty and liability';

  @override
  String get settingsTermsLiabilityBody =>
      'The app is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied. To the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of the app.';

  @override
  String get settingsTermsNoticeTitle => 'Changes to these terms';

  @override
  String get settingsTermsNoticeBody =>
      'These terms may be updated from time to time. Continued use of the app after changes are published constitutes acceptance of the revised terms.';
}
