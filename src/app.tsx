import { useEffect, useRef, useState, type MutableRef } from 'preact/hooks'
import { CircularIndicator } from './components/circular-indicator'

const secondsToMMSS = (seconds: number): string => {
  const minutes: number = Math.floor(seconds / 60)
  const remainingSeconds: number = seconds % 60
  return `${minutes.toString().padStart(2, '0')}:${remainingSeconds
    .toString()
    .padStart(2, '0')}`
}

const SECONDS_BY_ROUND: number = 7
const REST_SECONDS: number = 5
const ROUNDS: number = 12

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED'

export function App() {
  const [round, setRound] = useState<number>(1)
  const [resting, setResting] = useState<boolean>(false)
  const [secondsOfRound, setSecondsOfRound] = useState<number>(0)
  const [state, setState] = useState<State>('STOPPED')
  const intervalRef: MutableRef<number | null> = useRef<number | null>(null)

  useEffect(() => {
    if (state === 'RUNNING') {
      intervalRef.current = setInterval(() => {
        setSecondsOfRound((previousSeconds: number) => {
          if (previousSeconds >= SECONDS_BY_ROUND) {
            setRound((previousRound: number) => {
              if (previousRound >= ROUNDS) {
                clearInterval(intervalRef.current!)
                setState('FINISHED')
                return previousRound
              }
              return previousRound + 1
            })
            return 0
          }

          return previousSeconds + 1
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

  const percentage: number =
    100 - ((SECONDS_BY_ROUND - secondsOfRound) / SECONDS_BY_ROUND) * 100

  return (
    <>
      <div
        style={{ display: 'flex', flexDirection: 'column', height: '100vh' }}
      >
        <h1 className="w3-center" style={{ flexShrink: 0 }}>
          Round {round} of 12
        </h1>
        <div
          className="w3-center"
          style={{
            flexGrow: 1,
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <CircularIndicator percentage={percentage}>
            {secondsToMMSS(SECONDS_BY_ROUND - secondsOfRound)}
          </CircularIndicator>
        </div>
      </div>
      <div className="w3-bottom">
        {state !== 'RUNNING' && (
          <div className="w3-row">
            <button
              className="w3-button w3-block w3-blue"
              onClick={onStartClicked}
            >
              Start
            </button>
          </div>
        )}
        {state === 'RUNNING' && (
          <div className="w3-row">
            <div className="w3-col" style={{ width: '50%' }}>
              <button
                className="w3-button w3-block w3-blue"
                onClick={onPauseClicked}
              >
                Pause
              </button>
            </div>
            <div className="w3-col" style={{ width: '50%' }}>
              <button
                className="w3-button w3-block w3-blue"
                onClick={onStopClicked}
              >
                Stop
              </button>
            </div>
          </div>
        )}
      </div>
    </>
  )
}
