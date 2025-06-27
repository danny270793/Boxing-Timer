import { useEffect, useRef, useState, type MutableRef } from 'preact/hooks'
import { CircularIndicator } from './components/circular-indicator'

const secondsToMMSS = (seconds: number): string => {
  const minutes: number = Math.floor(seconds / 60)
  const remainingSeconds: number = seconds % 60
  return `${minutes.toString().padStart(2, '0')}:${remainingSeconds
    .toString()
    .padStart(2, '0')}`
}

const ROUND_SECONDS: number = 7

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED'

export function App() {
  const [secondsOfRound, setSecondsOfRound] = useState<number>(0)
  const [state, setState] = useState<State>('STOPPED')
  const intervalRef: MutableRef<number | null> = useRef<number | null>(null)

  useEffect(() => {
    if (state === 'RUNNING') {
      intervalRef.current = setInterval(() => {
        setSecondsOfRound((previous: number) => {
          if (previous >= ROUND_SECONDS) {
            clearInterval(intervalRef.current!)
            setState('FINISHED')
            return previous
          }
          return previous + 1
        })
      }, 1000)
    }

    return () => clearInterval(intervalRef.current!)
  }, [state])

  const onStartClicked = async () => {
    if (state === 'FINISHED') {
      setSecondsOfRound(0)
    }
    if (state !== 'RUNNING') {
      setState('RUNNING')
    }
  }

  const onPauseClicked = () => {
    clearInterval(intervalRef.current!)
    setState('PAUSED')
  }

  const onStopClicked = () => {
    clearInterval(intervalRef.current!)
    setSecondsOfRound(0)
    setState('STOPPED')
  }

  return (
    <>
      {}
      <CircularIndicator
        percentage={
          100 - ((ROUND_SECONDS - secondsOfRound) / ROUND_SECONDS) * 100
        }
      >
        {secondsToMMSS(ROUND_SECONDS - secondsOfRound)}
      </CircularIndicator>
      {state !== 'RUNNING' && (
        <button className="w3-button w3-blue" onClick={onStartClicked}>
          Start
        </button>
      )}
      {state === 'RUNNING' && (
        <button className="w3-button w3-blue" onClick={onPauseClicked}>
          Pause
        </button>
      )}
      {state === 'RUNNING' && (
        <button className="w3-button w3-blue" onClick={onStopClicked}>
          Stop
        </button>
      )}
    </>
  )
}
