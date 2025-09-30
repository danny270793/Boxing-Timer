import { useNavigate } from 'react-router-dom'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faArrowLeft, faFileContract } from '@fortawesome/free-solid-svg-icons'

export const TermsPage = () => {
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
            <FontAwesomeIcon icon={faFileContract} />
          </div>
          <div className="legal-title-text">
            <h1>Terms and Conditions</h1>
            <p>Terms of use for the Boxing Timer application</p>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="legal-page-content">
        <div className="legal-intro">
          <p>
            These Terms and Conditions ("Terms") govern your use of the Boxing
            Timer application. By using our app, you agree to be bound by these
            terms.
          </p>
          <p>
            <strong>Last updated:</strong> {new Date().toLocaleDateString()}
          </p>
        </div>

        <div className="legal-sections">
          <section className="legal-section">
            <h2>1. Acceptance of Terms</h2>
            <div className="legal-content">
              <p>
                By downloading, installing, or using the Boxing Timer app, you
                agree to be bound by these Terms and Conditions. If you do not
                agree to these terms, please do not use the application.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>2. Description of Service</h2>
            <div className="legal-content">
              <p>
                The Boxing Timer app is a fitness application designed to help
                users track boxing rounds and rest periods. The app provides:
              </p>
              <ul>
                <li>Customizable round and rest timers</li>
                <li>Audio notifications for round changes</li>
                <li>Multi-language support</li>
                <li>Offline functionality</li>
              </ul>
            </div>
          </section>

          <section className="legal-section">
            <h2>3. User Responsibilities</h2>
            <div className="legal-content">
              <p>As a user of this application, you agree to:</p>
              <ul>
                <li>Use the app only for its intended purpose</li>
                <li>Not attempt to reverse engineer or modify the app</li>
                <li>
                  Not use the app in any way that could harm yourself or others
                </li>
                <li>
                  Consult with a healthcare professional before starting any
                  exercise program
                </li>
                <li>
                  Use the app responsibly and in accordance with safety
                  guidelines
                </li>
              </ul>
            </div>
          </section>

          <section className="legal-section">
            <h2>4. Health and Safety Disclaimer</h2>
            <div className="legal-content">
              <p>
                <strong>IMPORTANT:</strong> This app is for informational
                purposes only and is not intended to replace professional
                medical advice, diagnosis, or treatment. Always consult with a
                qualified healthcare provider before starting any exercise
                program.
              </p>
              <p>
                The developers of this app are not responsible for any injuries
                or health issues that may arise from the use of this
                application. Use the app at your own risk.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>5. Intellectual Property</h2>
            <div className="legal-content">
              <p>
                The Boxing Timer app and its original content, features, and
                functionality are owned by the developers and are protected by
                international copyright, trademark, patent, trade secret, and
                other intellectual property laws.
              </p>
              <p>
                You may not copy, modify, distribute, sell, or lease any part of
                our services or included software, nor may you reverse engineer
                or attempt to extract the source code of that software.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>6. Privacy</h2>
            <div className="legal-content">
              <p>
                Your privacy is important to us. Please review our Privacy
                Policy, which also governs your use of the app, to understand
                our practices.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>7. Limitation of Liability</h2>
            <div className="legal-content">
              <p>
                In no event shall the developers be liable for any indirect,
                incidental, special, consequential, or punitive damages,
                including without limitation, loss of profits, data, use,
                goodwill, or other intangible losses, resulting from your use of
                the app.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>8. Disclaimer of Warranties</h2>
            <div className="legal-content">
              <p>
                The app is provided on an "AS IS" and "AS AVAILABLE" basis. We
                make no warranties, expressed or implied, and hereby disclaim
                and negate all other warranties including, without limitation,
                implied warranties or conditions of merchantability, fitness for
                a particular purpose, or non-infringement of intellectual
                property or other violation of rights.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>9. Changes to Terms</h2>
            <div className="legal-content">
              <p>
                We reserve the right to modify or replace these Terms at any
                time. If a revision is material, we will try to provide at least
                30 days notice prior to any new terms taking effect.
              </p>
            </div>
          </section>

          <section className="legal-section">
            <h2>10. Contact Information</h2>
            <div className="legal-content">
              <p>
                If you have any questions about these Terms and Conditions,
                please contact us through the app store where you downloaded
                this application.
              </p>
            </div>
          </section>
        </div>

        <div className="legal-footer">
          <p>
            By using the Boxing Timer app, you acknowledge that you have read
            and understood these Terms and Conditions and agree to be bound by
            them.
          </p>
        </div>
      </div>
    </div>
  )
}
