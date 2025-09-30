import { render } from 'preact'
import { App } from './app.tsx'
import './styles/index.css'
import '@danny270793/w3css/dist/w3css.css'
import './i18n'

render(<App />, document.getElementById('app')!)
