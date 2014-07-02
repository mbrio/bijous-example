'use strict';

var gulp = require('gulp');
var jshint = require('gulp-jshint');

var srcFiles = ['./index.js', './modules/**/*.js'];

gulp.task('lint', function gulpLint() {
  return gulp.src(['./*.js', './modules/**/*.js'])
    .pipe(jshint())
    .pipe(jshint.reporter('default'));
});

gulp.task('default', ['server']);

gulp.task('server', function gulpServer(cb) {
  require('./index');
});