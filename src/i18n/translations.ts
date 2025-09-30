import type { Translations } from './types'

export const en: Translations = {
  app: {
    title: 'Boxing Timer',
    round: 'Round',
    of: 'of',
    roundActive: 'Round Active',
    restTime: 'Rest Time',
    paused: 'Paused',
    workoutComplete: 'Workout Complete!',
    start: 'Start',
    pause: 'Pause',
    stop: 'Stop',
    openSettings: 'Open Settings',
  },
  timer: {
    round: 'Round',
    rest: 'Rest',
  },
  settings: {
    title: 'Settings',
    language: 'Language',
    about: 'About',
    appName: 'App Name:',
    version: 'Version:',
  },
}

export const es: Translations = {
  app: {
    title: 'Temporizador de Boxeo',
    round: 'Ronda',
    of: 'de',
    roundActive: 'Ronda Activa',
    restTime: 'Tiempo de Descanso',
    paused: 'Pausado',
    workoutComplete: '¡Entrenamiento Completo!',
    start: 'Iniciar',
    pause: 'Pausar',
    stop: 'Detener',
    openSettings: 'Abrir Configuración',
  },
  timer: {
    round: 'Ronda',
    rest: 'Descanso',
  },
  settings: {
    title: 'Configuración',
    language: 'Idioma',
    about: 'Acerca de',
    appName: 'Nombre de la App:',
    version: 'Versión:',
  },
}

export const translations = {
  en,
  es,
}
