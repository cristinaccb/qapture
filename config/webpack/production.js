const { environment } = require('@rails/webpacker')

// Add additional entry points if needed
environment.config.merge({
  entry: {
    application: './app/javascript/packs/application.js',
    // Add more entry points here if needed
  }
})

module.exports = environment
