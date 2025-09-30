export interface AppTranslations {
  title: string
  round: string
  of: string
  roundActive: string
  restTime: string
  paused: string
  workoutComplete: string
  start: string
  pause: string
  stop: string
  openSettings: string
  customizeExperience: string
  chooseLanguage: string
  appInfo: string
  appInfoDescription: string
  openSourceLicenses: string
  viewLicenses: string
  privacyPolicy: string
  privacyDescription: string
  termsConditions: string
  termsDescription: string
  viewPrivacy: string
  viewTerms: string
}

export interface SettingsTranslations {
  title: string
  language: string
  about: string
  appName: string
  version: string
}

export interface TimerTranslations {
  round: string
  rest: string
}

export interface LicensesTranslations {
  title: string
  subtitle: string
  intro: string
  visitWebsite: string
  footer: string
}

export interface PrivacyTranslations {
  title: string
  subtitle: string
  intro: string
  lastUpdated: string
  sections: {
    informationWeCollect: string
    personalInformation: string
    personalInformationText: string
    usageData: string
    usageDataText: string
    howWeUse: string
    howWeUseText: string
    dataStorage: string
    dataStorageText: string
    thirdPartyServices: string
    thirdPartyServicesText: string
    childrensPrivacy: string
    childrensPrivacyText: string
    changesToPolicy: string
    changesToPolicyText: string
    contactUs: string
    contactUsText: string
  }
  footer: string
}

export interface TermsTranslations {
  title: string
  subtitle: string
  intro: string
  lastUpdated: string
  sections: {
    acceptanceOfTerms: string
    acceptanceOfTermsText: string
    descriptionOfService: string
    descriptionOfServiceText: string
    userResponsibilities: string
    userResponsibilitiesText: string
    healthSafetyDisclaimer: string
    healthSafetyDisclaimerText: string
    intellectualProperty: string
    intellectualPropertyText: string
    privacy: string
    privacyText: string
    limitationOfLiability: string
    limitationOfLiabilityText: string
    disclaimerOfWarranties: string
    disclaimerOfWarrantiesText: string
    changesToTerms: string
    changesToTermsText: string
    contactInformation: string
    contactInformationText: string
  }
  footer: string
}

export interface Translations {
  app: AppTranslations
  timer: TimerTranslations
  settings: SettingsTranslations
  licenses: LicensesTranslations
  privacy: PrivacyTranslations
  terms: TermsTranslations
}

export interface Language {
  code: string
  name: string
  nativeName: string
  flag: string
}

export const SUPPORTED_LANGUAGES: Language[] = [
  {
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flag: '🇺🇸',
  },
  {
    code: 'es',
    name: 'Spanish',
    nativeName: 'Español',
    flag: '🇪🇸',
  },
]
