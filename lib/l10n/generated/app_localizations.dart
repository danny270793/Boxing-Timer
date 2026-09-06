import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'BOXING TIMER'**
  String get appTitle;

  /// No description provided for @phaseWarmup.
  ///
  /// In en, this message translates to:
  /// **'WARM UP'**
  String get phaseWarmup;

  /// No description provided for @phaseRound.
  ///
  /// In en, this message translates to:
  /// **'ROUND'**
  String get phaseRound;

  /// No description provided for @phaseRest.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get phaseRest;

  /// No description provided for @phaseFinished.
  ///
  /// In en, this message translates to:
  /// **'FIGHT OVER'**
  String get phaseFinished;

  /// No description provided for @phaseReady.
  ///
  /// In en, this message translates to:
  /// **'READY'**
  String get phaseReady;

  /// No description provided for @roundsAhead.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 round ahead} other{{count} rounds ahead}}'**
  String roundsAhead(num count);

  /// No description provided for @getReady.
  ///
  /// In en, this message translates to:
  /// **'Get ready...'**
  String get getReady;

  /// No description provided for @roundProgress.
  ///
  /// In en, this message translates to:
  /// **'Round {current} / {total}'**
  String roundProgress(int current, int total);

  /// No description provided for @completedRounds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Completed 1 / 1 round} other{Completed {count} / {count} rounds}}'**
  String completedRounds(num count);

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startButton;

  /// No description provided for @startNewFightButton.
  ///
  /// In en, this message translates to:
  /// **'Start new fight'**
  String get startNewFightButton;

  /// No description provided for @pauseButton.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseButton;

  /// No description provided for @resumeButton.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeButton;

  /// No description provided for @stopButton.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stopButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @stopDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop the fight?'**
  String get stopDialogTitle;

  /// No description provided for @stopDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This will stop the timer completely and reset it back to the start.'**
  String get stopDialogBody;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @modesMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Modes'**
  String get modesMenuTitle;

  /// No description provided for @modesMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rounds, timing and presets'**
  String get modesMenuSubtitle;

  /// No description provided for @themeMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeMenuTitle;

  /// No description provided for @languageMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageMenuTitle;

  /// No description provided for @aboutMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutMenuTitle;

  /// No description provided for @termsMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsMenuTitle;

  /// No description provided for @privacyMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyMenuTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to protect your settings, or keep using the timer locally.'**
  String get signInSubtitle;

  /// No description provided for @continueWithoutAccount.
  ///
  /// In en, this message translates to:
  /// **'Continue without account'**
  String get continueWithoutAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unexpectedError;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @newEmail.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get newEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @emailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Email update requested.'**
  String get emailUpdated;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get passwordUpdated;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @biometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Face ID / biometric unlock'**
  String get biometricUnlock;

  /// No description provided for @biometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require authentication when returning to the app'**
  String get biometricUnlockSubtitle;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is unavailable.'**
  String get biometricUnavailable;

  /// No description provided for @biometricEnableReason.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric unlock for Boxing Timer'**
  String get biometricEnableReason;

  /// No description provided for @biometricResumeReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Boxing Timer'**
  String get biometricResumeReason;

  /// No description provided for @biometricLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Boxing Timer is locked'**
  String get biometricLockTitle;

  /// No description provided for @biometricLockBody.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to continue.'**
  String get biometricLockBody;

  /// No description provided for @unlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockButton;

  /// No description provided for @chooseThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose theme'**
  String get chooseThemeTitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguageTitle;

  /// No description provided for @languageSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @modesTitle.
  ///
  /// In en, this message translates to:
  /// **'Modes'**
  String get modesTitle;

  /// No description provided for @newModeButton.
  ///
  /// In en, this message translates to:
  /// **'New mode'**
  String get newModeButton;

  /// No description provided for @newModeTitle.
  ///
  /// In en, this message translates to:
  /// **'New mode'**
  String get newModeTitle;

  /// No description provided for @editModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit mode'**
  String get editModeTitle;

  /// No description provided for @nameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFieldLabel;

  /// No description provided for @roundsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ROUNDS'**
  String get roundsSectionTitle;

  /// No description provided for @roundsLabel.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get roundsLabel;

  /// No description provided for @roundDurationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ROUND DURATION'**
  String get roundDurationSectionTitle;

  /// No description provided for @restDurationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'REST DURATION'**
  String get restDurationSectionTitle;

  /// No description provided for @minutesLabel.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutesLabel;

  /// No description provided for @secondsLabel.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get secondsLabel;

  /// No description provided for @saveModeButton.
  ///
  /// In en, this message translates to:
  /// **'Save mode'**
  String get saveModeButton;

  /// No description provided for @nameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Give this mode a name.'**
  String get nameRequiredError;

  /// No description provided for @roundDurationRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Round duration must be greater than 0.'**
  String get roundDurationRequiredError;

  /// No description provided for @duplicateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicateTooltip;

  /// No description provided for @editTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editTooltip;

  /// No description provided for @deleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteTooltip;

  /// No description provided for @deleteModeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete mode?'**
  String get deleteModeDialogTitle;

  /// No description provided for @deleteModeDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete \"{name}\".'**
  String deleteModeDialogBody(String name);

  /// No description provided for @switchModeBlockedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Stop the current fight before switching modes.'**
  String get switchModeBlockedSnackbar;

  /// No description provided for @copyOfMode.
  ///
  /// In en, this message translates to:
  /// **'Copy of {name}'**
  String copyOfMode(String name);

  /// No description provided for @modeRoundsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 round} other{{count} rounds}}'**
  String modeRoundsCount(num count);

  /// No description provided for @workDuration.
  ///
  /// In en, this message translates to:
  /// **'{duration} work'**
  String workDuration(String duration);

  /// No description provided for @restDuration.
  ///
  /// In en, this message translates to:
  /// **'{duration} rest'**
  String restDuration(String duration);

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Round timer for boxing, MMA, and combat sports training.'**
  String get appTagline;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Boxing Timer helps you run structured round timers for boxing, MMA, and other combat sports. Configure warm-up, round, and rest durations, save your favorite setups as modes, and train with audio cues for round starts and the final ten seconds of each round.'**
  String get aboutDescription;

  /// No description provided for @contactLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactLabel;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'support@example.com'**
  String get contactEmail;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsTitle;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyTitle;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'These Terms & Conditions (\"Terms\") govern your use of Boxing Timer (the \"App\"). By downloading, installing, or using the App, you agree to be bound by these Terms. If you do not agree, do not use the App.\n\n1. Use of the App\nThe App is provided for personal, non-commercial use as a round timer for boxing, MMA, and other combat sports training. You are responsible for using the App safely and are solely responsible for any injury or harm arising from your training activities.\n\n2. No Professional Advice\nThe App does not provide medical, coaching, or professional training advice. Consult a qualified professional before starting any exercise program.\n\n3. Intellectual Property\nAll content, design, and code in the App are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.\n\n4. Disclaimer of Warranty\nThe App is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied, including but not limited to fitness for a particular purpose, accuracy, or uninterrupted operation.\n\n5. Limitation of Liability\nTo the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of, or inability to use, the App.\n\n6. Changes to These Terms\nThese Terms may be updated from time to time. Continued use of the App after changes are published constitutes acceptance of the revised Terms.\n\n7. Contact\nIf you have questions about these Terms, contact us at [your-email@example.com].\n\nLast updated: [insert date]\n\nThis is placeholder legal text. Replace it with content reviewed by a lawyer for your jurisdiction before publishing this App.'**
  String get termsBody;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'This Privacy Policy explains how Boxing Timer (the \"App\") handles your information.\n\n1. Data We Collect\nThe App does not require an account and does not collect, transmit, or sell any personal information. Your custom training modes and preferences (theme, language, selected mode) are stored locally on your device only.\n\n2. No Analytics or Advertising\nThe App does not include third-party analytics, tracking, or advertising software.\n\n3. Permissions\nThe App does not request access to your camera, microphone, contacts, or location. Any device permissions used are limited to what is required for the App\'s core timer and sound features.\n\n4. Data Sharing\nBecause no personal data is collected, none is shared with third parties.\n\n5. Children\'s Privacy\nThe App is not directed at children and does not knowingly collect information from children.\n\n6. Changes to This Policy\nThis Privacy Policy may be updated from time to time. Changes will be reflected by an updated \"Last updated\" date below.\n\n7. Contact\nIf you have questions about this Privacy Policy, contact us at [your-email@example.com].\n\nLast updated: [insert date]\n\nThis is placeholder legal text. Replace it with content reviewed by a lawyer for your jurisdiction before publishing this App.'**
  String get privacyBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
