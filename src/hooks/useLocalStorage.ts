import { useState, useEffect } from 'preact/hooks'

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED'

interface TimerState {
  state: State
  seconds: number
  lastUpdated: number
}

const STORAGE_KEY = 'boxing-timer-state'

export function useLocalStorage() {
  const [timerState, setTimerState] = useState<TimerState>({
    state: 'STOPPED',
    seconds: 0,
    lastUpdated: Date.now(),
  })

  // Load state from localStorage on mount
  useEffect(() => {
    try {
      const savedState = localStorage.getItem(STORAGE_KEY)
      if (savedState) {
        const parsedState: TimerState = JSON.parse(savedState)
        console.log('Loaded timer state from localStorage:', parsedState)
        setTimerState(parsedState)
      }
    } catch (error) {
      console.warn('Failed to load timer state from localStorage:', error)
    }
  }, [])

  // Save state to localStorage whenever it changes
  const updateTimerState = (newState: Partial<TimerState>) => {
    const updatedState = {
      ...timerState,
      ...newState,
      lastUpdated: Date.now(),
    }

    setTimerState(updatedState)

    try {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(updatedState))
      console.log('Saved timer state to localStorage:', updatedState)
    } catch (error) {
      console.warn('Failed to save timer state to localStorage:', error)
    }
  }

  // Clear state from localStorage
  const clearTimerState = () => {
    setTimerState({
      state: 'STOPPED',
      seconds: 0,
      lastUpdated: Date.now(),
    })

    try {
      localStorage.removeItem(STORAGE_KEY)
    } catch (error) {
      console.warn('Failed to clear timer state from localStorage:', error)
    }
  }

  // Calculate elapsed time since last update for running timers
  const getElapsedSeconds = () => {
    if (timerState.state !== 'RUNNING') {
      return timerState.seconds
    }

    const now = Date.now()
    const elapsedMs = now - timerState.lastUpdated
    const elapsedSeconds = Math.floor(elapsedMs / 1000)

    return timerState.seconds + elapsedSeconds
  }

  return {
    timerState,
    updateTimerState,
    clearTimerState,
    getElapsedSeconds,
  }
}
