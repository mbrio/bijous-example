Bijous = require 'bijous'
winston = require 'winston'
config = require('envirofig').init 'bijous-example'

startDate = new Date()

# Create our `Bijous` instance
bijous = new Bijous
  # Configure our module bundles, see the file *config.cson* for more info
  bundles: config.bundles

# The `config` property is not part of `Bijous`; as our `Bijous` instance is
# passed as a context parameter to each module we can store properties here
# that can be consumed by all modules.
bijous.config = config

# Setup a logger for use by our modules, as all modules will rely on this we
# have placed this within the context
bijous.logger = new winston.Logger()
bijous.logger.setLevels winston.config.npm.levels
bijous.logger.add winston.transports.Console, config.logger

# We need only load the *private* bundle as it's the only set of modules
# pertaining to server-side code
bijous.load 'private', (err, results) ->
  duration = new Date() - startDate
  bijous.logger.silly 'Loaded all modules in:', duration, 'ms'
