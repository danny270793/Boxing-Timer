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
      'Training modes and preferences are stored only on this device. There are no accounts and nothing is uploaded.';

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
  String get settingsPrivacyDataTitle => 'No account needed';

  @override
  String get settingsPrivacyDataBody =>
      'Boxing Timer has no accounts and no sign-in. You never enter an email or password, and the app does not collect personal information.';

  @override
  String get settingsPrivacyInfraTitle => 'What we store';

  @override
  String get settingsPrivacyInfraBody =>
      'Custom training modes and preferences (theme, language, selected mode and biometric unlock) are stored only on this device. There are no servers and nothing is uploaded or synced. Uninstalling the app deletes this data.';

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
      'We do not sell or share your personal information. All app data stays on your device.';

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
  String get settingsTermsAccountTitle => 'No account';

  @override
  String get settingsTermsAccountBody =>
      'You can use every feature without creating an account. Training modes and other app data stay on this device; if you uninstall the app or clear its data, they cannot be recovered.';

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
