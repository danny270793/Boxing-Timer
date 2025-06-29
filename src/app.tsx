import { useEffect, useRef, useState, type MutableRef } from 'preact/hooks'
import { CircularIndicator } from './components/circular-indicator'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faPause, faPlay, faStop } from '@fortawesome/free-solid-svg-icons'
import Bell from './assets/boxing-bell.mp3'
import TenSecondsLeft from './assets/10-seconds-left.mp3'
import { Time } from './utils/time'
import { StatusBar } from './utils/status-bar'

const SECONDS_BY_ROUND: number = Time.minutesInSeconds(3)
const REST_SECONDS: number = Time.minutesInSeconds(1)
const ROUNDS: number = 12

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED'

export function App() {
  const bellRef: MutableRef<HTMLAudioElement> = useRef(new Audio(Bell))
  const tenSecondsLeftRef: MutableRef<HTMLAudioElement> = useRef(
    new Audio(TenSecondsLeft),
  )

  const [state, setState] = useState<State>('STOPPED')
  const [seconds, setSeconds] = useState<number>(0)

  useEffect(() => {
    StatusBar.backgroundColorByHexString('#2196f3')
  }, [])

  useEffect(() => {
    if (state === 'RUNNING') {
      const interval: NodeJS.Timeout = setInterval(() => {
        setSeconds((prevSeconds: number) => {
          if (
            prevSeconds >=
            ROUNDS * SECONDS_BY_ROUND + ROUNDS * REST_SECONDS
          ) {
            clearInterval(interval)
            setState('FINISHED')
            return 0
          }
          return prevSeconds + 1
        })
      }, 1000)

      return () => clearInterval(interval)
    }
  }, [state])

  const onStartClicked = () => {
    if (state === 'FINISHED') {
      setSeconds(0)
    }
    setState('RUNNING')
  }

  const onStopClicked = () => {
    setSeconds(0)
    setState('STOPPED')
  }

  const onPauseClicked = () => {
    setState('PAUSED')
  }

  const rounds: number =
    Math.floor(seconds / (SECONDS_BY_ROUND + REST_SECONDS)) + 1
  const lastRoundSeconds: number =
    (rounds - 1) * (SECONDS_BY_ROUND + REST_SECONDS)
  const roundSeconds: number = seconds - lastRoundSeconds
  const isInRest: boolean = roundSeconds > SECONDS_BY_ROUND
  const restSeconds: number = roundSeconds - SECONDS_BY_ROUND
  const roundPercentage: number = (roundSeconds / SECONDS_BY_ROUND) * 100
  const restPercentage: number = (restSeconds / REST_SECONDS) * 100

  if (state === 'RUNNING') {
    if (roundSeconds === SECONDS_BY_ROUND || roundSeconds === 0) {
      bellRef.current.currentTime = 0
      bellRef.current.play()
    }

    if (roundSeconds === SECONDS_BY_ROUND - 10) {
      tenSecondsLeftRef.current.currentTime = 0
      tenSecondsLeftRef.current.play()
    }

    if (restSeconds === REST_SECONDS - 10) {
      tenSecondsLeftRef.current.currentTime = 0
      tenSecondsLeftRef.current.play()
    }
  }

  return (
    <div className={isInRest ? 'w3-orange' : 'w3-green'}>
      <div className="w3-container">
        <div>
          <h1 className="w3-center">
            Round {rounds} of {ROUNDS}
          </h1>
        </div>
        <div
          style={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            height:
              'calc(100vh - env(safe-area-inset-top) - env(safe-area-inset-bottom) - 135px)',
          }}
        >
          <div
            style={{
              aspectRatio: '1/1',
            }}
          >
            <CircularIndicator
              percentage={isInRest ? restPercentage : roundPercentage}
              background={isInRest ? '#ff9800' : '#4caf50'}
            >
              <div className="w3-xxxlarge">
                {isInRest
                  ? Time.secondsToMMSS(
                      SECONDS_BY_ROUND + REST_SECONDS - roundSeconds,
                    )
                  : Time.secondsToMMSS(SECONDS_BY_ROUND - roundSeconds)}
              </div>
            </CircularIndicator>
          </div>
        </div>
      </div>
      <div className="w3-bottom">
        {state !== 'RUNNING' && (
          <button
            className="w3-button w3-blue w3-block"
            onClick={onStartClicked}
          >
            <FontAwesomeIcon className="w3-xxxlarge" icon={faPlay} />
          </button>
        )}
        {state === 'RUNNING' && (
          <div className="w3-row">
            <div className="w3-col" style={{ width: '50%' }}>
              <button
                className="w3-button w3-blue w3-block"
                onClick={onPauseClicked}
              >
                <FontAwesomeIcon className="w3-xxxlarge" icon={faPause} />
              </button>
            </div>
            <div className="w3-col" style={{ width: '50%' }}>
              <button
                className="w3-button w3-red w3-block"
                onClick={onStopClicked}
              >
                <FontAwesomeIcon className="w3-xxxlarge" icon={faStop} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
