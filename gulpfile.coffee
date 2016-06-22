gulp = require "gulp"
coffee = require "gulp-coffee"
del = require 'del'
vinylPaths = require 'vinyl-paths'
ngAnnotate = require "gulp-ng-annotate"

paths =
  app: {
    scripts: "app/js/"
  }

gulp.task "cleanDevelop", ->
  gulp.src ["develop"], {read: false}
  .pipe vinylPaths(del)

gulp.task "cleanDist", ->
  gulp.src ["dist"], {read: false}
  .pipe vinylPaths(del)
  
gulp.task "compile", ->
  coffeeStream = coffee({bare:true})
  gulp.src(paths.app.scripts)
  .pipe(
    order ["**/*.coffee"]
  )
  .pipe sourcemaps.init()
  .pipe(gulpif(/[.]coffee$/, coffeeStream))
  .pipe(ngAnnotate())  
  
  
gulp.task "minify", ["compile"], ->
  
gulp.task "develop", ["cleanDevelop", "compile"], ->

gulp.task "deploy", ["cleanDeploy", "minify"], ->


gulp.task "default", ->
  gulp.start "develop"