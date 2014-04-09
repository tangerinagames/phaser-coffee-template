# path.resolve
{resolve} = require 'path'

# livereload
livereload = require 'connect-livereload'
LIVERELOAD_PORT = 35729

module.exports = (grunt) ->

  # get the env
  production = grunt.option('production')?

  # load all grunt tasks
  require('load-grunt-tasks')(grunt)

  # browserify transforms
  transform = ['coffeeify']
  transform.push 'uglifyify' if production

  # grunt configuration
  grunt.initConfig

    bower:
      install: {}

    watch:
      scripts:
        files: ['game/**/*.coffee', 'stylus/**/*.styl']
        options:
          spawn: false
          livereload: LIVERELOAD_PORT
        tasks: ['build']

    connect:
      options:
        port: 3000
        hostname: '0.0.0.0'
      livereload:
        options:
          middleware: (connect) ->
            [livereload(port: LIVERELOAD_PORT), connect.static resolve 'dist']

    open:
      server:
        path: 'http://localhost:3000'

    browserify:
      dist:
        files:
          'dist/game.js': 'game/**/*.coffee'
        options:
          browserifyOptions:
            extensions: ['.coffee']
          transform: transform

    uglify:
      options:
        compress: production
        beautify: not production
      libs:
        files:
          'dist/libs.js': ['lib/**/*.js', 'plugins/*.js']

    copy:
      dist:
        files: [
          { expand: true, src: ['assets/**'], dest: 'dist/' }
          { expand: false, src: ['index.html'], dest: 'dist/index.html' }
          { expand: false, src: ['game/package.json'], dest: 'dist/package.json' }
        ]

    stylus:
      compile:
        options:
          paths: ['styles/includes']
          urlfunc: 'embedurl'
          use: [
            require 'fluidity'
          ]
        files:
          'dist/css/styles.css': 'stylus/*.styl'

    nodewebkit:
      options:
        build_dir: 'desktop'
        mac: true
        win: true
        linux32: true
        linux64: true
      src: ['dist/**/*']

  grunt.registerTask 'build', ['bower', 'browserify', 'uglify', 'stylus', 'copy']
  grunt.registerTask 'serve', ['build', 'connect', 'open', 'watch']
  grunt.registerTask 'desktop', ['build', 'nodewebkit']
  grunt.registerTask 'default', ['serve']
