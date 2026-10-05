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
/// import 'l10n/app_localizations.dart';
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
  /// **'Boxing Timer'**
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

  /// No description provided for @settingsSecuritySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecuritySection;

  /// No description provided for @settingsTimerSection.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get settingsTimerSection;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

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

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsBiometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Face ID & fingerprint'**
  String get settingsBiometricUnlockTitle;

  /// No description provided for @settingsBiometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require authentication when returning to the app.'**
  String get settingsBiometricUnlockSubtitle;

  /// No description provided for @settingsBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is not available on this device.'**
  String get settingsBiometricUnavailable;

  /// No description provided for @settingsBiometricAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric unlock for Boxing Timer'**
  String get settingsBiometricAuthReason;

  /// No description provided for @settingsBiometricResumeReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Boxing Timer'**
  String get settingsBiometricResumeReason;

  /// No description provided for @biometricLockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get biometricLockUnlockButton;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutApp;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate on Google Play'**
  String get settingsRateApp;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsAboutTagline.
  ///
  /// In en, this message translates to:
  /// **'Round timer for boxing, MMA, and combat sports training.'**
  String get settingsAboutTagline;

  /// No description provided for @settingsAboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsAboutVersionLabel;

  /// No description provided for @settingsAboutFeaturesHeading.
  ///
  /// In en, this message translates to:
  /// **'What you can do'**
  String get settingsAboutFeaturesHeading;

  /// No description provided for @settingsAboutBulletRounds.
  ///
  /// In en, this message translates to:
  /// **'Run structured warm-up, round, and rest timers for boxing, MMA, and other combat sports.'**
  String get settingsAboutBulletRounds;

  /// No description provided for @settingsAboutBulletModes.
  ///
  /// In en, this message translates to:
  /// **'Start from the boxing and MMA presets or save your favorite setups as custom modes.'**
  String get settingsAboutBulletModes;

  /// No description provided for @settingsAboutBulletSounds.
  ///
  /// In en, this message translates to:
  /// **'Train with audio cues for round starts and the final ten seconds of each round.'**
  String get settingsAboutBulletSounds;

  /// No description provided for @settingsAboutDataHeading.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get settingsAboutDataHeading;

  /// No description provided for @settingsAboutDataBody.
  ///
  /// In en, this message translates to:
  /// **'Training modes and preferences are stored only on this device. There are no accounts and nothing is uploaded.'**
  String get settingsAboutDataBody;

  /// No description provided for @settingsAboutDeveloperHeading.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsAboutDeveloperHeading;

  /// No description provided for @settingsAboutDeveloperGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settingsAboutDeveloperGithub;

  /// No description provided for @settingsAboutDeveloperWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get settingsAboutDeveloperWebsite;

  /// No description provided for @settingsAboutDeveloperYoutube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get settingsAboutDeveloperYoutube;

  /// No description provided for @settingsAboutDeveloperLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get settingsAboutDeveloperLinkedin;

  /// No description provided for @settingsPrivacyTagline.
  ///
  /// In en, this message translates to:
  /// **'How Boxing Timer handles your information.'**
  String get settingsPrivacyTagline;

  /// No description provided for @settingsPrivacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No account needed'**
  String get settingsPrivacyDataTitle;

  /// No description provided for @settingsPrivacyDataBody.
  ///
  /// In en, this message translates to:
  /// **'Boxing Timer has no accounts and no sign-in. You never enter an email or password, and the app does not collect personal information.'**
  String get settingsPrivacyDataBody;

  /// No description provided for @settingsPrivacyInfraTitle.
  ///
  /// In en, this message translates to:
  /// **'What we store'**
  String get settingsPrivacyInfraTitle;

  /// No description provided for @settingsPrivacyInfraBody.
  ///
  /// In en, this message translates to:
  /// **'Custom training modes and preferences (theme, language, selected mode and biometric unlock) are stored only on this device. There are no servers and nothing is uploaded or synced. Uninstalling the app deletes this data.'**
  String get settingsPrivacyInfraBody;

  /// No description provided for @settingsPrivacyAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'No analytics or advertising'**
  String get settingsPrivacyAnalyticsTitle;

  /// No description provided for @settingsPrivacyAnalyticsBody.
  ///
  /// In en, this message translates to:
  /// **'The app does not include third-party analytics, tracking, or advertising software.'**
  String get settingsPrivacyAnalyticsBody;

  /// No description provided for @settingsPrivacyPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPrivacyPermissionsTitle;

  /// No description provided for @settingsPrivacyPermissionsBody.
  ///
  /// In en, this message translates to:
  /// **'Device permissions are limited to what is required for the timer, sounds, and optional biometric unlock.'**
  String get settingsPrivacyPermissionsBody;

  /// No description provided for @settingsPrivacySharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Data sharing'**
  String get settingsPrivacySharingTitle;

  /// No description provided for @settingsPrivacySharingBody.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or share your personal information. All app data stays on your device.'**
  String get settingsPrivacySharingBody;

  /// No description provided for @settingsPrivacyNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to this policy'**
  String get settingsPrivacyNoticeTitle;

  /// No description provided for @settingsPrivacyNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy may be updated from time to time. Continued use of the app after changes means you accept the updated policy.'**
  String get settingsPrivacyNoticeBody;

  /// No description provided for @settingsTermsTagline.
  ///
  /// In en, this message translates to:
  /// **'Rules for using Boxing Timer.'**
  String get settingsTermsTagline;

  /// No description provided for @settingsTermsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Acceptance'**
  String get settingsTermsAcceptanceTitle;

  /// No description provided for @settingsTermsAcceptanceBody.
  ///
  /// In en, this message translates to:
  /// **'These terms govern your use of Boxing Timer (the \"app\"). By downloading, installing, or using the app, you agree to be bound by these terms. If you do not agree, do not use the app.'**
  String get settingsTermsAcceptanceBody;

  /// No description provided for @settingsTermsResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Use of the app'**
  String get settingsTermsResponsibilitiesTitle;

  /// No description provided for @settingsTermsResponsibilitiesBody.
  ///
  /// In en, this message translates to:
  /// **'The app is provided for personal, non-commercial use as a round timer for boxing, MMA, and other combat sports training. You are responsible for using the app safely and are solely responsible for any injury or harm arising from your training activities.'**
  String get settingsTermsResponsibilitiesBody;

  /// No description provided for @settingsTermsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'No account'**
  String get settingsTermsAccountTitle;

  /// No description provided for @settingsTermsAccountBody.
  ///
  /// In en, this message translates to:
  /// **'You can use every feature without creating an account. Training modes and other app data stay on this device; if you uninstall the app or clear its data, they cannot be recovered.'**
  String get settingsTermsAccountBody;

  /// No description provided for @settingsTermsDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'No professional advice'**
  String get settingsTermsDisclaimerTitle;

  /// No description provided for @settingsTermsDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'The app does not provide medical, coaching, or professional training advice. Consult a qualified professional before starting any exercise program.'**
  String get settingsTermsDisclaimerBody;

  /// No description provided for @settingsTermsIpTitle.
  ///
  /// In en, this message translates to:
  /// **'Intellectual property'**
  String get settingsTermsIpTitle;

  /// No description provided for @settingsTermsIpBody.
  ///
  /// In en, this message translates to:
  /// **'All content, design, and code in the app are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.'**
  String get settingsTermsIpBody;

  /// No description provided for @settingsTermsLiabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty and liability'**
  String get settingsTermsLiabilityTitle;

  /// No description provided for @settingsTermsLiabilityBody.
  ///
  /// In en, this message translates to:
  /// **'The app is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied. To the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of the app.'**
  String get settingsTermsLiabilityBody;

  /// No description provided for @settingsTermsNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to these terms'**
  String get settingsTermsNoticeTitle;

  /// No description provided for @settingsTermsNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'These terms may be updated from time to time. Continued use of the app after changes are published constitutes acceptance of the revised terms.'**
  String get settingsTermsNoticeBody;
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
