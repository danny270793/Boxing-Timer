import { useNavigate } from 'react-router-dom'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faArrowLeft, faFileText, faExternalLinkAlt } from '@fortawesome/free-solid-svg-icons'

export const LicensesPage = () => {
  const navigate = useNavigate()

  const handleBack = () => {
    navigate('/settings')
  }

  const licenses = [
    {
      name: 'React',
      version: '18.2.0',
      license: 'MIT',
      description: 'A JavaScript library for building user interfaces',
      url: 'https://reactjs.org/',
      copyright: 'Copyright (c) Meta Platforms, Inc. and affiliates.'
    },
    {
      name: 'Preact',
      version: '10.26.5',
      license: 'MIT',
      description: 'Fast 3kB alternative to React with the same modern API',
      url: 'https://preactjs.com/',
      copyright: 'Copyright (c) 2015-present Jason Miller'
    },
    {
      name: 'React Router DOM',
      version: '6.28.1',
      license: 'MIT',
      description: 'Declarative routing for React',
      url: 'https://reactrouter.com/',
      copyright: 'Copyright (c) React Training'
    },
    {
      name: 'i18next',
      version: '23.15.1',
      license: 'MIT',
      description: 'Internationalization framework for JavaScript',
      url: 'https://www.i18next.com/',
      copyright: 'Copyright (c) i18next'
    },
    {
      name: 'react-i18next',
      version: '14.1.2',
      license: 'MIT',
      description: 'React integration for i18next',
      url: 'https://react.i18next.com/',
      copyright: 'Copyright (c) i18next'
    },
    {
      name: 'Font Awesome',
      version: '6.7.2',
      license: 'Font Awesome Free License',
      description: 'The web\'s most popular icon set and toolkit',
      url: 'https://fontawesome.com/',
      copyright: 'Copyright (c) Fonticons, Inc.'
    },
    {
      name: 'Vite',
      version: '6.3.5',
      license: 'MIT',
      description: 'Next generation frontend tooling',
      url: 'https://vitejs.dev/',
      copyright: 'Copyright (c) 2019-present Evan You'
    },
    {
      name: 'TypeScript',
      version: '5.8.3',
      license: 'Apache-2.0',
      description: 'JavaScript with syntax for types',
      url: 'https://www.typescriptlang.org/',
      copyright: 'Copyright (c) Microsoft Corporation'
    },
    {
      name: 'Capacitor',
      version: '6.2.1',
      license: 'MIT',
      description: 'Cross-platform native runtime for web apps',
      url: 'https://capacitorjs.com/',
      copyright: 'Copyright (c) 2017-present Drifty Co.'
    }
  ]

  return (
    <div className="licenses-page">
      {/* Header */}
      <div className="licenses-page-header">
        <button className="licenses-back-button" onClick={handleBack}>
          <FontAwesomeIcon icon={faArrowLeft} />
        </button>
        <div className="licenses-title">
          <div className="licenses-title-icon">
            <FontAwesomeIcon icon={faFileText} />
          </div>
          <div className="licenses-title-text">
            <h1>Open Source Licenses</h1>
            <p>Third-party libraries and their licenses</p>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="licenses-page-content">
        <div className="licenses-intro">
          <p>
            This application uses several open source libraries. We are grateful to the developers 
            who have contributed to these projects. Below are the licenses for the libraries used:
          </p>
        </div>

        <div className="licenses-list">
          {licenses.map((license, index) => (
            <div key={index} className="license-item">
              <div className="license-header">
                <div className="license-name-section">
                  <h3 className="license-name">{license.name}</h3>
                  <span className="license-version">v{license.version}</span>
                </div>
                <div className="license-badge">
                  <span className="license-type">{license.license}</span>
                </div>
              </div>
              
              <p className="license-description">{license.description}</p>
              
              <div className="license-footer">
                <div className="license-copyright">
                  <span>{license.copyright}</span>
                </div>
                <a 
                  href={license.url} 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="license-link"
                >
                  <FontAwesomeIcon icon={faExternalLinkAlt} />
                  <span>Visit Website</span>
                </a>
              </div>
            </div>
          ))}
        </div>

        <div className="licenses-footer">
          <p>
            This application is open source and available under the MIT License. 
            You can find the source code and contribute at our GitHub repository.
          </p>
        </div>
      </div>
    </div>
  )
}
