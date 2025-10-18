import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { HomePage } from './pages/home'
import { SettingsPage } from './pages/settings'
import { LicensesPage } from './pages/licenses'
import { PrivacyPage } from './pages/privacy'
import { TermsPage } from './pages/terms'
import { useTheme } from './hooks/useTheme'

export function App() {
  // Initialize theme system
  useTheme()

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="/licenses" element={<LicensesPage />} />
        <Route path="/privacy" element={<PrivacyPage />} />
        <Route path="/terms" element={<TermsPage />} />
      </Routes>
    </BrowserRouter>
  )
}
