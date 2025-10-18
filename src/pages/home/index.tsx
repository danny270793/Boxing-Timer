import { useEffect, useRef, useState, type MutableRef } from 'preact/hooks'
import { useTranslation } from 'react-i18next'
import { useNavigate } from 'react-router-dom'
import { CircularIndicator } from '../../components/circular-indicator'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {
  faPause,
  faPlay,
  faStop,
  faCog,
} from '@fortawesome/free-solid-svg-icons'
import Bell from '../../assets/boxing-bell.mp3'
import TenSecondsLeft from '../../assets/10-seconds-left.mp3'
import { Time } from '../../utils/time'
import { StatusBar } from '../../utils/status-bar'
import { useLocalStorage } from '../../hooks/useLocalStorage'
import { useScrollToTop } from '../../hooks/useScrollToTop'

const SECONDS_BY_ROUND: number = Time.minutesInSeconds(3)
const REST_SECONDS: number = Time.minutesInSeconds(1)
const ROUNDS: number = 12

type State = 'RUNNING' | 'PAUSED' | 'STOPPED' | 'FINISHED' | 'COUNTDOWN'

export const HomePage = () => {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const bellRef: MutableRef<HTMLAudioElement> = useRef(new Audio(Bell))
  const tenSecondsLeftRef: MutableRef<HTMLAudioElement> = useRef(
    new Audio(TenSecondsLeft),
  )

  const { timerState, updateTimerState, clearTimerState, getElapsedSeconds } =
    useLocalStorage()
  const [state, setState] = useState<State>(timerState.state)
  const [seconds, setSeconds] = useState<number>(timerState.seconds)
  const [countdown, setCountdown] = useState<number>(0)

  // Scroll to top on navigation
  useScrollToTop()

  useEffect(() => {
    StatusBar.backgroundColorByHexString('#667eea')
  }, [])

  // Sync local state with localStorage state
  useEffect(() => {
    setState(timerState.state)
    setSeconds(timerState.seconds)
  }, [timerState.state, timerState.seconds])

  // Handle countdown logic
  useEffect(() => {
    if (state === 'COUNTDOWN') {
      const interval = setInterval(() => {
        setCountdown((prev) => {
          if (prev <= 1) {
            clearInterval(interval)
            setState('RUNNING')
            if (timerState.state === 'FINISHED') {
              setSeconds(0)
              updateTimerState({ state: 'RUNNING', seconds: 0 })
            } else {
              updateTimerState({ state: 'RUNNING' })
            }
            return 0
          }
          return prev - 1
        })
      }, 1000)

      return () => clearInterval(interval)
    }
  }, [state, timerState.state, updateTimerState])

  // Update seconds for running timers based on elapsed time
  useEffect(() => {
    if (state === 'RUNNING') {
      const interval = setInterval(() => {
        const elapsedSeconds = getElapsedSeconds()
        setSeconds(elapsedSeconds)

        // Update localStorage with current progress
        updateTimerState({ seconds: elapsedSeconds })

        // Check if workout is complete
        if (
          elapsedSeconds >=
          ROUNDS * SECONDS_BY_ROUND + ROUNDS * REST_SECONDS
        ) {
          clearInterval(interval)
          setState('FINISHED')
          updateTimerState({ state: 'FINISHED', seconds: 0 })
        }
      }, 1000)

      return () => clearInterval(interval)
    }
  }, [state, getElapsedSeconds, updateTimerState])

  const onStartClicked = () => {
    setCountdown(10)
    setState('COUNTDOWN')
  }

  const onStopClicked = () => {
    setSeconds(0)
    setState('STOPPED')
    clearTimerState()
  }

  const onPauseClicked = () => {
    setState('PAUSED')
    updateTimerState({ state: 'PAUSED' })
  }

  const handleSettingsClick = () => {
    navigate('/settings')
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
    if (state === 'COUNTDOWN') return 'countdown'
    return 'stopped'
  }

  const getStatusText = () => {
    if (state === 'FINISHED') return t('app.workoutComplete')
    if (state === 'PAUSED') return t('app.paused')
    if (state === 'COUNTDOWN') return t('app.getReady')
    if (isInRest) return t('app.restTime')
    return t('app.roundActive')
  }

  const getTimerPercentage = () => {
    if (state === 'COUNTDOWN') {
      return ((10 - countdown) / 10) * 100
    }
    return isInRest ? restPercentage : roundPercentage
  }

  return (
    <div className="app-container">
      {/* Settings Button */}
      <button
        className="settings-button"
        onClick={handleSettingsClick}
        aria-label={t('app.openSettings')}
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
            percentage={getTimerPercentage()}
            className={getStateClass()}
          >
            <div className="timer-content">
              {state === 'COUNTDOWN' ? (
                <>
                  <div className="timer-text countdown-text">{countdown}</div>
                  <div className="round-text">{t('app.startingIn')}</div>
                </>
              ) : (
                <>
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
                </>
              )}
            </div>
          </CircularIndicator>
        </div>
      </div>

      {/* Control Buttons */}
      <div className="controls-container">
        {state !== 'RUNNING' && state !== 'COUNTDOWN' && (
          <button
            className="control-button primary-button animate-slide-in"
            onClick={onStartClicked}
          >
            <FontAwesomeIcon icon={faPlay} />
            <span>{t('app.start')}</span>
          </button>
        )}
        {state === 'COUNTDOWN' && (
          <div className="countdown-controls animate-slide-in">
            <div className="countdown-info">
              <span>
                {t('app.startingIn')} {countdown}
              </span>
            </div>
            <button
              className="control-button danger-button"
              onClick={onStopClicked}
            >
              <FontAwesomeIcon icon={faStop} />
              <span>{t('app.stop')}</span>
            </button>
          </div>
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
    </div>
  )
}
