Bijous = require 'bijous'
winston = require 'winston'

startDate = new Date

# Create our `Bijous` instance
bijous = new Bijous
  # Configure our module bundles

  bundles:

    # Private modules are setup for server-side code. The solution here is
    # designed around creating a web server based on express. Because many of
    # our modules rely on the express app created by the *server* module we
    # specify that the server module should be loaded first. We also specify
    # that the routes module should be loaded last because it relies on all
    # other modules
    private: [
      'modules/private/server' # Load the *server* module first
      'modules/private/!(routes)' # Load all other modules but *routes*
      'modules/private/routes' # Load the *routes* module last
    ]

    # Public modules are setup for client-side code, these files will be
    # accessible at */* and will match the full path below
    # (e.g /modules/public/vendors/angular.js)
    public: [
      'modules/public/vendors/angular.js' # Many of our modules rely on angular
      'modules/public/vendors/*.js' # All other vendor modules
      'modules/public/app/index.js' # Application initialization module
      'modules/public/**/*.js' # All other modules
    ]

    # Public views for use with public modules, as with public modules the
    # files will be accessible at */* and will match the full path of the file
    # with the *.jade* extension substituded with *.html*
    views: [
      'modules/public/**/*.jade'
    ]

    # Public stylesheets for use with public views, as with the public views
    # the files will be accessible at */* and will match the full path of the
    # file with the *.less extension substituded with *.css*
    stylesheets: [
      'modules/public/app/styles/styles.less'
      'modules/public/**/*.less'
    ]

# The `config` property is not part of `Bijous`; as our `Bijous` instance is
# passed as a context parameter to each module we can store properties here
# that can be consumed by all modules.
bijous.config =
  server:
    port: 3000

# Setup a logger for use by our modules, as all modules will rely on this we
# have placed this within the context
bijous.logger = new winston.Logger
bijous.logger.setLevels winston.config.npm.levels
bijous.logger.add winston.transports.Console,
  colorize: true
  timestamp: true
  exitOnError: true
  level: 'silly'

# We need only load the *private* bundle as it's the only set of modules
# pertaining to server-side code
bijous.load 'private', (err, results) ->
  duration = new Date() - startDate
  bijous.logger.silly 'Loaded all modules in:', duration, 'ms'
