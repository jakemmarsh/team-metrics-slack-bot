'use strict';

var gulp  = require('gulp');
var mocha = require('gulp-mocha');

gulp.task('test', function() {

  require('coffee-script/register');

  return gulp.src('test/index.js')
    .pipe(mocha({
      compilers: 'coffee:coffee-script'
    }))
    .once('error', function () {
      process.exit(1);
    })
    .once('end', function () {
      process.exit();
    });

});
