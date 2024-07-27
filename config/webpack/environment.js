const { environment } = require('@rails/webpacker')

const path = require('path');

// Add this to explicitly set the entry point
environment.config.set('entry', {
   application: path.resolve(__dirname, '../../app/javascript/application.js')
});

module.exports = environment;
