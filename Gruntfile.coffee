module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'public/main.js': 'src/main.coffee'
    less:
      screen:
        files:
          'public/screen.css': 'src/screen.less'
    template:
      html:
        src: 'src/index.jade'
        dest: 'public/index.html'
        variables:
          pretty: false
    watch:
      scripts:
        files: 'src/*.coffee'
        tasks: ['coffee']
      styles:
        files: 'src/*.less'
        tasks: ['less']
      templates:
        files: 'src/*.jade'
        tasks: ['template:html']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-templater'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'less', 'template:html', 'watch']
