import { Application } from "@hotwired/stimulus"

// Initialize Stimulus application
const application = Application.start()

// Automatically load all controllers from the controllers directory
const context = require.context(".", true, /\.js$/)
context.keys().forEach(key => {
  if (key === './application.js') return // Skip itself
  const controller = context(key)
  const controllerName = key.replace(/^\.\/|\.js$/g, "")
  application.register(controllerName, controller.default)
})

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
