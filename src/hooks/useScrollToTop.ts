import { useEffect } from 'preact/hooks'
import { useLocation } from 'react-router-dom'

export function useScrollToTop() {
  const location = useLocation()

  useEffect(() => {
    // Scroll to top when location changes
    window.scrollTo({
      top: 0,
      left: 0,
      behavior: 'smooth'
    })
  }, [location.pathname])
}
