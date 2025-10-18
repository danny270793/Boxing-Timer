import { useState, useEffect } from 'preact/hooks'

export type Theme = 'light' | 'dark' | 'system'

const THEME_STORAGE_KEY = 'boxing-timer-theme'

export function useTheme() {
  const [theme, setTheme] = useState<Theme>(() => {
    // Get theme from localStorage or default to 'system'
    if (globalThis.window !== undefined) {
      const savedTheme = globalThis.localStorage.getItem(
        THEME_STORAGE_KEY,
      ) as Theme
      return savedTheme || 'system'
    }
    return 'system'
  })

  const [resolvedTheme, setResolvedTheme] = useState<'light' | 'dark'>('light')

  // Update resolved theme based on system preference when theme is 'system'
  useEffect(() => {
    const updateResolvedTheme = () => {
      if (theme === 'system') {
        const prefersDark = globalThis.matchMedia(
          '(prefers-color-scheme: dark)',
        ).matches
        setResolvedTheme(prefersDark ? 'dark' : 'light')
      } else {
        setResolvedTheme(theme)
      }
    }

    updateResolvedTheme()

    // Listen for system theme changes
    const mediaQuery = globalThis.matchMedia('(prefers-color-scheme: dark)')
    const handleChange = () => {
      if (theme === 'system') {
        updateResolvedTheme()
      }
    }

    mediaQuery.addEventListener('change', handleChange)
    return () => mediaQuery.removeEventListener('change', handleChange)
  }, [theme])

  // Apply theme to document
  useEffect(() => {
    if (globalThis.document !== undefined) {
      document.documentElement.dataset.theme = resolvedTheme
    }
  }, [resolvedTheme])

  // Save theme to localStorage
  const changeTheme = (newTheme: Theme) => {
    setTheme(newTheme)
    if (globalThis.window !== undefined) {
      globalThis.localStorage.setItem(THEME_STORAGE_KEY, newTheme)
    }
  }

  return {
    theme,
    resolvedTheme,
    changeTheme,
    isDark: resolvedTheme === 'dark',
    isLight: resolvedTheme === 'light',
  }
}
