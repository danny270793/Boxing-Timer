import { useState, useRef, useEffect } from 'preact/hooks'
import { useTranslation } from 'react-i18next'
import { SUPPORTED_LANGUAGES, type Language } from '../../i18n/types'

export const LanguageSwitcher = () => {
  const { i18n } = useTranslation()
  const [isOpen, setIsOpen] = useState(false)
  const [selectedLanguage, setSelectedLanguage] = useState<Language>(
    SUPPORTED_LANGUAGES.find((lang) => lang.code === i18n.language) ||
      SUPPORTED_LANGUAGES[0],
  )
  const dropdownRef = useRef<HTMLDivElement>(null)

  const changeLanguage = (language: Language) => {
    i18n.changeLanguage(language.code)
    setSelectedLanguage(language)
    setIsOpen(false)
  }

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (
        dropdownRef.current &&
        !dropdownRef.current.contains(event.target as Node)
      ) {
        setIsOpen(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  // Update selected language when i18n language changes
  useEffect(() => {
    const currentLang = SUPPORTED_LANGUAGES.find(
      (lang) => lang.code === i18n.language,
    )
    if (currentLang) {
      setSelectedLanguage(currentLang)
    }
  }, [i18n.language])

  return (
    <div className="language-combobox" ref={dropdownRef}>
      <button
        className="language-trigger"
        onClick={() => setIsOpen(!isOpen)}
        aria-expanded={isOpen}
        aria-haspopup="listbox"
      >
        <span className="language-flag">{selectedLanguage.flag}</span>
        <span className="language-name">{selectedLanguage.nativeName}</span>
        <span className={`dropdown-arrow ${isOpen ? 'open' : ''}`}>▼</span>
      </button>

      {isOpen && (
        <div className="language-dropdown">
          {SUPPORTED_LANGUAGES.map((language) => (
            <div
              key={language.code}
              className={`language-option ${selectedLanguage.code === language.code ? 'selected' : ''}`}
              onClick={() => changeLanguage(language)}
              onKeyDown={(e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                  e.preventDefault()
                  changeLanguage(language)
                }
              }}
              role="option"
              tabIndex={0}
              aria-selected={selectedLanguage.code === language.code}
            >
              <span className="language-flag">{language.flag}</span>
              <span className="language-name">{language.nativeName}</span>
              <span className="language-english">{language.name}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
