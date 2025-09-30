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
  },
  timer: {
    round: 'Round',
    rest: 'Rest',
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
  },
  timer: {
    round: 'Ronda',
    rest: 'Descanso',
  },
}

export const translations = {
  en,
  es,
}
