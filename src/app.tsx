import { useEffect, useRef, useState, type MutableRef } from 'preact/hooks'
import { useTranslation } from 'react-i18next'
import { CircularIndicator } from './components/circular-indicator'
import { SettingsScreen } from './components/settings-screen'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {
  faPause,
  faPlay,
  faStop,
  faCog,
} from '@fortawesome/free-solid-svg-icons'
import Bell from './assets/boxing-bell.mp3'
import TenSecondsLeft from './assets/10-seconds-left.mp3'
import { Time } from './utils/time'
import { StatusBar } from './utils/status-bar'

const SECONDS_BY_ROUND: number = Time.minutesInSeconds(3)
const REST_SECONDS: number = Time.minutesInSeconds(1)
const ROUNDS: number = 12

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED'

export function App() {
  const { t } = useTranslation()
  const bellRef: MutableRef<HTMLAudioElement> = useRef(new Audio(Bell))
  const tenSecondsLeftRef: MutableRef<HTMLAudioElement> = useRef(
    new Audio(TenSecondsLeft),
  )

  const [state, setState] = useState<State>('STOPPED')
  const [seconds, setSeconds] = useState<number>(0)
  const [isSettingsOpen, setIsSettingsOpen] = useState<boolean>(false)

  useEffect(() => {
    StatusBar.backgroundColorByHexString('#667eea')
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

  const getStateClass = () => {
    if (state === 'RUNNING') {
      return isInRest ? 'rest-active' : 'round-active'
    }
    if (state === 'PAUSED') return 'paused'
    return 'stopped'
  }

  const getStatusText = () => {
    if (state === 'FINISHED') return t('app.workoutComplete')
    if (state === 'PAUSED') return t('app.paused')
    if (isInRest) return t('app.restTime')
    return t('app.roundActive')
  }

  return (
    <div className="app-container">
      {/* Settings Button */}
      <button
        className="settings-button"
        onClick={() => setIsSettingsOpen(true)}
        aria-label="Open Settings"
      >
        <FontAwesomeIcon icon={faCog} />
      </button>

      {/* Header */}
      <div className="app-header animate-fade-in">
        <div className="round-info">
          <h1 className="round-title">
            {t('app.round')} {rounds} {t('app.of')} {ROUNDS}
          </h1>
          <div className={`status-badge ${getStateClass()}`}>
            {getStatusText()}
          </div>
        </div>
      </div>

      {/* Main Timer Area */}
      <div className="timer-container">
        <div className="timer-wrapper">
          <CircularIndicator
            percentage={isInRest ? restPercentage : roundPercentage}
            className={getStateClass()}
          >
            <div className="timer-content">
              <div className="timer-text">
                {isInRest
                  ? Time.secondsToMMSS(
                      SECONDS_BY_ROUND + REST_SECONDS - roundSeconds,
                    )
                  : Time.secondsToMMSS(SECONDS_BY_ROUND - roundSeconds)}
              </div>
              <div className="round-text">
                {isInRest ? t('timer.rest') : t('timer.round')}
              </div>
            </div>
          </CircularIndicator>
        </div>
      </div>

      {/* Control Buttons */}
      <div className="controls-container">
        {state !== 'RUNNING' && (
          <button
            className="control-button primary-button animate-slide-in"
            onClick={onStartClicked}
          >
            <FontAwesomeIcon icon={faPlay} />
            <span>{t('app.start')}</span>
          </button>
        )}
        {state === 'RUNNING' && (
          <div className="control-row animate-slide-in">
            <button
              className="control-button secondary-button"
              onClick={onPauseClicked}
            >
              <FontAwesomeIcon icon={faPause} />
              <span>{t('app.pause')}</span>
            </button>
            <button
              className="control-button danger-button"
              onClick={onStopClicked}
            >
              <FontAwesomeIcon icon={faStop} />
              <span>{t('app.stop')}</span>
            </button>
          </div>
        )}
      </div>

      {/* Settings Screen */}
      <SettingsScreen
        isOpen={isSettingsOpen}
        onClose={() => setIsSettingsOpen(false)}
      />
    </div>
  )
}
