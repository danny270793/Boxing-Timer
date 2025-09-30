import { useState, useEffect } from 'preact/hooks'
import { useTranslation } from 'react-i18next'
import { useNavigate } from 'react-router-dom'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import {
  faArrowLeft,
  faCog,
  faLanguage,
  faFileText,
  faExternalLinkAlt,
  faShieldAlt,
  faFileContract,
} from '@fortawesome/free-solid-svg-icons'
import { SUPPORTED_LANGUAGES, type Language } from '../../i18n/types'
import { useScrollToTop } from '../../hooks/useScrollToTop'

export const SettingsPage = () => {
  const { i18n, t } = useTranslation()
  const navigate = useNavigate()
  const [selectedLanguage, setSelectedLanguage] = useState<Language>(
    SUPPORTED_LANGUAGES.find((lang) => lang.code === i18n.language) ||
      SUPPORTED_LANGUAGES[0],
  )
  const [showLanguageOptions, setShowLanguageOptions] = useState(false)

  // Scroll to top on navigation
  useScrollToTop()

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
    setShowLanguageOptions(false)
  }

  const toggleLanguageOptions = () => {
    setShowLanguageOptions(!showLanguageOptions)
  }

  const handleBack = () => {
    navigate('/')
  }

  const handleLicensesClick = () => {
    navigate('/licenses')
  }

  const handlePrivacyClick = () => {
    navigate('/privacy')
  }

  const handleTermsClick = () => {
    navigate('/terms')
  }

  return (
    <div className="settings-page">
      {/* Header */}
      <div className="settings-page-header">
        <button className="settings-back-button" onClick={handleBack}>
          <FontAwesomeIcon icon={faArrowLeft} />
        </button>
        <div className="settings-title">
          <div className="settings-title-icon">
            <FontAwesomeIcon icon={faCog} />
          </div>
          <div className="settings-title-text">
            <h1>{t('settings.title')}</h1>
            <p>{t('app.customizeExperience')}</p>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="settings-page-content">
        {/* Language Section */}
        <div className="settings-section language-section">
          <div className="settings-section-header">
            <div className="section-icon">
              <FontAwesomeIcon icon={faLanguage} />
            </div>
            <div className="section-title">
              <h3>{t('settings.language')}</h3>
              <p>{t('app.chooseLanguage')}</p>
            </div>
          </div>
          <div className="settings-section-content">
            {/* Language Selector */}
            <div className="language-selector">
              <button
                className="language-selected-card"
                onClick={toggleLanguageOptions}
              >
                <div className="language-option-content">
                  <span className="language-flag">{selectedLanguage.flag}</span>
                  <div className="language-info">
                    <span className="language-native-name">
                      {selectedLanguage.nativeName}
                    </span>
                    <span className="language-english-name">
                      {selectedLanguage.name}
                    </span>
                  </div>
                  <span
                    className={`language-toggle-arrow ${showLanguageOptions ? 'open' : ''}`}
                  >
                    ▼
                  </span>
                </div>
              </button>

              {/* Language Options Dropdown */}
              {showLanguageOptions && (
                <div className="language-options-dropdown">
                  {SUPPORTED_LANGUAGES.map((language) => (
                    <button
                      key={language.code}
                      className={`language-option-item ${
                        selectedLanguage.code === language.code
                          ? 'selected'
                          : ''
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
              )}
            </div>
          </div>
        </div>

        {/* App Info Section */}
        <div className="settings-section">
          <div className="settings-section-header">
            <div className="section-icon">
              <FontAwesomeIcon icon={faCog} />
            </div>
            <div className="section-title">
              <h3>{t('settings.about')}</h3>
              <p>{t('app.appInfoDescription')}</p>
            </div>
          </div>
          <div className="settings-section-content">
            <div className="app-info">
              <div className="app-info-item">
                <div className="app-info-icon">
                  <span>📱</span>
                </div>
                <div className="app-info-content">
                  <span className="app-info-label">
                    {t('settings.appName')}
                  </span>
                  <span className="app-info-value">{t('app.title')}</span>
                </div>
              </div>
              <div className="app-info-item">
                <div className="app-info-icon">
                  <span>🔢</span>
                </div>
                <div className="app-info-content">
                  <span className="app-info-label">
                    {t('settings.version')}
                  </span>
                  <span className="app-info-value">1.0.0</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Licenses Section */}
        <button
          className="settings-section clickable-section"
          onClick={handleLicensesClick}
          aria-label={t('app.viewLicenses')}
        >
          <div className="settings-section-header">
            <div className="section-icon">
              <FontAwesomeIcon icon={faFileText} />
            </div>
            <div className="section-title">
              <h3>{t('app.openSourceLicenses')}</h3>
              <p>{t('app.viewLicenses')}</p>
            </div>
            <div className="section-action">
              <FontAwesomeIcon icon={faExternalLinkAlt} />
            </div>
          </div>
        </button>

        {/* Privacy Policy Section */}
        <button
          className="settings-section clickable-section"
          onClick={handlePrivacyClick}
          aria-label={t('app.viewPrivacy')}
        >
          <div className="settings-section-header">
            <div className="section-icon">
              <FontAwesomeIcon icon={faShieldAlt} />
            </div>
            <div className="section-title">
              <h3>{t('app.privacyPolicy')}</h3>
              <p>{t('app.privacyDescription')}</p>
            </div>
            <div className="section-action">
              <FontAwesomeIcon icon={faExternalLinkAlt} />
            </div>
          </div>
        </button>

        {/* Terms and Conditions Section */}
        <button
          className="settings-section clickable-section"
          onClick={handleTermsClick}
          aria-label={t('app.viewTerms')}
        >
          <div className="settings-section-header">
            <div className="section-icon">
              <FontAwesomeIcon icon={faFileContract} />
            </div>
            <div className="section-title">
              <h3>{t('app.termsConditions')}</h3>
              <p>{t('app.termsDescription')}</p>
            </div>
            <div className="section-action">
              <FontAwesomeIcon icon={faExternalLinkAlt} />
            </div>
          </div>
        </button>
      </div>
    </div>
  )
}
