import { useState, useEffect } from 'preact/hooks'
import { useTranslation } from 'react-i18next'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {
  faArrowLeft,
  faCog,
  faLanguage,
} from '@fortawesome/free-solid-svg-icons'
import { SUPPORTED_LANGUAGES, type Language } from '../../i18n/types'

interface SettingsScreenProps {
  isOpen: boolean
  onClose: () => void
}

export const SettingsScreen = ({ isOpen, onClose }: SettingsScreenProps) => {
  const { i18n, t } = useTranslation()
  const [selectedLanguage, setSelectedLanguage] = useState<Language>(
    SUPPORTED_LANGUAGES.find((lang) => lang.code === i18n.language) ||
      SUPPORTED_LANGUAGES[0],
  )

  // Update selected language when i18n language changes
  useEffect(() => {
    const currentLang = SUPPORTED_LANGUAGES.find(
      (lang) => lang.code === i18n.language,
    )
    if (currentLang) {
      setSelectedLanguage(currentLang)
    }
  }, [i18n.language])

  const changeLanguage = (language: Language) => {
    i18n.changeLanguage(language.code)
    setSelectedLanguage(language)
  }

  if (!isOpen) return null

  return (
    <div className="settings-overlay">
      <div className="settings-container">
        {/* Header */}
        <div className="settings-header">
          <button className="settings-back-button" onClick={onClose}>
            <FontAwesomeIcon icon={faArrowLeft} />
          </button>
          <div className="settings-title">
            <FontAwesomeIcon icon={faCog} />
            <span>Settings</span>
          </div>
        </div>

        {/* Content */}
        <div className="settings-content">
          {/* Language Section */}
          <div className="settings-section">
            <div className="settings-section-header">
              <FontAwesomeIcon icon={faLanguage} />
              <h3>Language</h3>
            </div>
            <div className="language-options">
              {SUPPORTED_LANGUAGES.map((language) => (
                <button
                  key={language.code}
                  className={`language-option-card ${
                    selectedLanguage.code === language.code ? 'selected' : ''
                  }`}
                  onClick={() => changeLanguage(language)}
                >
                  <div className="language-option-content">
                    <span className="language-flag">{language.flag}</span>
                    <div className="language-info">
                      <span className="language-native-name">
                        {language.nativeName}
                      </span>
                      <span className="language-english-name">
                        {language.name}
                      </span>
                    </div>
                    {selectedLanguage.code === language.code && (
                      <div className="selected-indicator">✓</div>
                    )}
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* App Info Section */}
          <div className="settings-section">
            <div className="settings-section-header">
              <h3>About</h3>
            </div>
            <div className="app-info">
              <div className="app-info-item">
                <span className="app-info-label">App Name:</span>
                <span className="app-info-value">{t('app.title')}</span>
              </div>
              <div className="app-info-item">
                <span className="app-info-label">Version:</span>
                <span className="app-info-value">1.0.0</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
