// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BOXING TIMER';

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
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfileSection => 'Profile';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsTimerSection => 'Timer';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get modesMenuTitle => 'Modes';

  @override
  String get modesMenuSubtitle => 'Rounds, timing and presets';

  @override
  String get themeMenuTitle => 'Theme';

  @override
  String get languageMenuTitle => 'Language';

  @override
  String get aboutMenuTitle => 'About';

  @override
  String get termsMenuTitle => 'Terms & Conditions';

  @override
  String get privacyMenuTitle => 'Privacy Policy';

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
  String get changeEmail => 'Change email';

  @override
  String get newEmail => 'New email';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get emailUpdated => 'Email update requested.';

  @override
  String get changePassword => 'Change password';

  @override
  String get newPassword => 'New password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters.';

  @override
  String get passwordUpdated => 'Password updated.';

  @override
  String get saveButton => 'Save';

  @override
  String get biometricUnlock => 'Face ID / biometric unlock';

  @override
  String get biometricUnlockSubtitle =>
      'Require authentication when returning to the app';

  @override
  String get biometricUnavailable => 'Biometric authentication is unavailable.';

  @override
  String get biometricEnableReason =>
      'Enable biometric unlock for Boxing Timer';

  @override
  String get biometricResumeReason => 'Unlock Boxing Timer';

  @override
  String get biometricLockTitle => 'Boxing Timer is locked';

  @override
  String get biometricLockBody => 'Authenticate to continue.';

  @override
  String get unlockButton => 'Unlock';

  @override
  String get chooseThemeTitle => 'Choose theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get chooseLanguageTitle => 'Choose language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

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
  String get aboutTitle => 'About';

  @override
  String get appTagline =>
      'Round timer for boxing, MMA, and combat sports training.';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDescription =>
      'Boxing Timer helps you run structured round timers for boxing, MMA, and other combat sports. Configure warm-up, round, and rest durations, save your favorite setups as modes, and train with audio cues for round starts and the final ten seconds of each round.';

  @override
  String get contactLabel => 'Contact';

  @override
  String get contactEmail => 'support@example.com';

  @override
  String get termsTitle => 'Terms & Conditions';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get termsBody =>
      'These Terms & Conditions (\"Terms\") govern your use of Boxing Timer (the \"App\"). By downloading, installing, or using the App, you agree to be bound by these Terms. If you do not agree, do not use the App.\n\n1. Use of the App\nThe App is provided for personal, non-commercial use as a round timer for boxing, MMA, and other combat sports training. You are responsible for using the App safely and are solely responsible for any injury or harm arising from your training activities.\n\n2. Optional account\nYou can use the App without signing in. If you create an account, sign-in is handled by Supabase. Training modes and similar app-generated data stay on this device today. Later versions may store that information in Supabase when you are signed in so it can sync across your devices.\n\n3. No Professional Advice\nThe App does not provide medical, coaching, or professional training advice. Consult a qualified professional before starting any exercise program.\n\n4. Intellectual Property\nAll content, design, and code in the App are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.\n\n5. Disclaimer of Warranty\nThe App is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied.\n\n6. Limitation of Liability\nTo the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of the App.\n\n7. Changes to These Terms\nThese Terms may be updated from time to time. Continued use of the App after changes are published constitutes acceptance of the revised Terms.';

  @override
  String get privacyBody =>
      'This Privacy Policy explains how Boxing Timer (the \"App\") handles your information.\n\n1. Account (optional)\nYou can use the App without an account. If you sign in, authentication is provided by Supabase. Your email and credentials are processed by Supabase; this App does not store your password.\n\n2. What we store today — and later\nCustom training modes and preferences (theme, language, selected mode) are stored locally on your device. We do not currently upload app-generated data such as saved modes or favorites. In the future, if you are signed in, we may store that kind of information in Supabase so it can sync across your devices.\n\n3. No Analytics or Advertising\nThe App does not include third-party analytics, tracking, or advertising software.\n\n4. Permissions\nDevice permissions are limited to what is required for the timer, sounds, and optional biometric unlock.\n\n5. Data Sharing\nWe do not sell your personal information. Sign-in data is processed by Supabase. Later cloud sync, if enabled, would also use Supabase.\n\n6. Changes to This Policy\nThis Privacy Policy may be updated from time to time. Continued use of the App after changes means you accept the updated policy.';
}
