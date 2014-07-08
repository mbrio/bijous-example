gulp = require 'gulp'
coffeelint = require 'gulp-coffeelint'

srcFiles = ['./*.coffee', './modules/**/*.coffee']

gulp.task 'lint', ->
  gulp.src srcFiles
    .pipe coffeelint()
    .pipe coffeelint.reporter('default')

gulp.task 'default', ['server']

gulp.task 'server', (cb) ->
  require './index'
