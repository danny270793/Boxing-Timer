import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { HomePage } from './pages/home'
import { SettingsPage } from './pages/settings'
import { LicensesPage } from './pages/licenses'

export function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/settings" element={<SettingsPage />} />
        <Route path="/licenses" element={<LicensesPage />} />
      </Routes>
    </BrowserRouter>
  )
}
