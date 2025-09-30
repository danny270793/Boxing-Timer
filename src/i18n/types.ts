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
}

export interface TimerTranslations {
  round: string
  rest: string
}

export interface Translations {
  app: AppTranslations
  timer: TimerTranslations
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
