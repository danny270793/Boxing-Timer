import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faArrowLeft, faShieldAlt } from '@fortawesome/free-solid-svg-icons'

export const PrivacyPage = () => {
  const { t } = useTranslation()
  const navigate = useNavigate()

  const handleBack = () => {
    navigate('/settings')
  }

  return (
    <div className="legal-page">
      {/* Header */}
      <div className="legal-page-header">
        <button className="legal-back-button" onClick={handleBack}>
          <FontAwesomeIcon icon={faArrowLeft} />
        </button>
        <div className="legal-title">
          <div className="legal-title-icon">
            <FontAwesomeIcon icon={faShieldAlt} />
          </div>
          <div className="legal-title-text">
            <h1>{t('privacy.title')}</h1>
            <p>{t('privacy.subtitle')}</p>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="legal-page-content">
        <div className="legal-intro">
          <p>{t('privacy.intro')}</p>
          <p>
            <strong>{t('privacy.lastUpdated')}</strong>{' '}
            {new Date().toLocaleDateString()}
          </p>
        </div>

        <div className="legal-sections">
          <section className="legal-section">
            <h2>{t('privacy.sections.informationWeCollect')}</h2>
            <div className="legal-content">
              <h3>1.1 Personal Information</h3>
              <p>
                We do not collect any personal information from users. The
                Boxing Timer app operates entirely locally on your device
                without requiring user registration or data collection.
              </p>

              <h3>1.2 Usage Data</h3>
              <p>
                The app may store your language preference locally on your
                device to provide a personalized experience. This data is stored
                only on your device and is not transmitted to our servers.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>2. How We Use Your Information</h2>
            <div className="legal-content">
              <p>
                Since we do not collect personal information, there is no
                personal data to use. Any local preferences (such as language
                settings) are used solely to:
              </p>
              <ul>
                <li>Provide the app functionality you expect</li>
                <li>
                  Remember your language preference for future app launches
                </li>
                <li>Ensure the app works correctly on your device</li>
              </ul>
            </div>
          </section>

          <section className="legal-section">
            <h2>3. Data Storage and Security</h2>
            <div className="legal-content">
              <p>
                All data is stored locally on your device. We do not have access
                to any information stored on your device. The app uses standard
                device security measures to protect any locally stored
                preferences.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>4. Third-Party Services</h2>
            <div className="legal-content">
              <p>This app uses the following third-party services:</p>
              <ul>
                <li>
                  <strong>Capacitor:</strong> For cross-platform functionality
                </li>
                <li>
                  <strong>React/Preact:</strong> For the user interface
                </li>
                <li>
                  <strong>Font Awesome:</strong> For icons
                </li>
              </ul>
              <p>
                These services do not collect personal information through our
                app.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>5. Children's Privacy</h2>
            <div className="legal-content">
              <p>
                Our app does not collect any personal information from anyone,
                including children under 13. The app is safe for users of all
                ages.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>6. Changes to This Privacy Policy</h2>
            <div className="legal-content">
              <p>
                We may update this Privacy Policy from time to time. We will
                notify you of any changes by posting the new Privacy Policy in
                the app. You are advised to review this Privacy Policy
                periodically for any changes.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>7. Contact Us</h2>
            <div className="legal-content">
              <p>
                If you have any questions about this Privacy Policy, please
                contact us through the app store where you downloaded this
                application.
              </p>
            </div>
          </section>
        </div>

        <div className="legal-footer">
          <p>
            This privacy policy is effective as of the date listed above and
            applies to all users of the Boxing Timer application.
          </p>
        </div>
      </div>
    </div>
  )
}
