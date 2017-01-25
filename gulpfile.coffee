browserify = require 'gulp-browserify'
gulp = require 'gulp'
stringify = require 'stringify'
uglify = require 'gulp-uglifyjs'
rename = require 'gulp-rename'
cleanCSS = require 'gulp-clean-css'

gulp.task "browserify", ->
  gulp.src('./src/index.js', { read: false })
  .pipe browserify {
    transform: stringify {
      appliesTo: { includeExtensions: ['.html'] },
      minify: true
      minifyOptions:
        removeComments: false
        collapseWhitespace: true
    }
  }
  .pipe rename {
    basename: 'kox'
    suffix: '.min'
  }
  .pipe uglify()
  .pipe gulp.dest './dist'

gulp.task 'minify-css', ->
  gulp.src './dist/kox.css'
  .pipe cleanCSS {compatibility: 'ie8'}
  .pipe rename {
    suffix: '.min'
  }
  .pipe gulp.dest 'dist'

watcher1 = gulp.watch './src/*.js', ['browserify']
watcher2 = gulp.watch './src/**/*.js', ['browserify']
watcher3 = gulp.watch './src/tpl/*.html', ['browserify']
watcher4 = gulp.watch './dis/ko-ui.css', ['minify-css']
watcher1.on 'change', (event) ->
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...')
watcher2.on 'change', (event) ->
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...')
watcher3.on 'change', (event) ->
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...')
watcher4.on 'change', (event) ->
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...')

gulp.task 'default', ['browserify', 'minify-css']