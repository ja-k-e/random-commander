module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    bower_concat: {
      build: {
        dest: 'src/scripts/_bower.js'
      }
    },
    copy: {
      html: {
        files: [
          {expand: true, flatten: false, cwd: 'src/html', src: ['*'], dest: 'build', filter: 'isFile'}
        ]
      },
      templates: {
        files: [
          {expand: true, flatten: false, cwd: 'src/html/templates', src: ['*'], dest: 'build/templates', filter: 'isFile'}
        ]
      }
    },
    uglify: {
      app: {
        files: {
          'build/js/app.min.js': ['src/scripts/app.js']
        }
      },
      bower: {
        files: {
          'build/js/head.min.js': ['src/scripts/_bower.js']
        }
      }
    },
    coffee: {
      compile: {
        options: {
          join: true
        },
        files: {
          'src/scripts/app.js': ['src/scripts/app.coffee', 'src/scripts/**/*.coffee', 'src/scripts/*.coffee']
        }
      }
    },
    sass: {
      dist: {
        files: {
          'src/styles/main.css': 'src/styles/scss/main.scss'
        }
      }
    },
    autoprefixer: {
      overwrite: {
        src: 'src/styles/main.css'
      }
    },
    cssmin: {
      compile: {
        files: {
          'build/css/main.min.css': ['src/styles/main.css']
        }
      }
    },
    watch: {
      js: {
        files: ['src/scripts/**/*.coffee', 'src/scripts/*.coffee'],
        tasks: ['script'],
        options: {
          livereload: true
        }
      },
      bower: {
        files: ['bower_components/**/*.js'],
        tasks: ['bowerjs'],
        options: {
          livereload: true
        }
      },
      html: {
        files: ['src/html/*.html'],
        tasks: ['html'],
        options: {
          livereload: true
        }
      },
      templates: {
        files: ['src/html/templates/*.html'],
        tasks: ['templates'],
        options: {
          livereload: true
        }
      },
      css: {
        files: ['src/styles/scss/**/*.scss', 'src/styles/scss/*.scss'],
        tasks: ['style'],
        options: {
          livereload: true
        }
      }
    },
    connect: {
      server: {
        options: {
          livereload: true,
          base: 'build/',
          port: 9000
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-bower-concat');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('style',     ['sass:dist', 'autoprefixer:overwrite', 'cssmin:compile']);
  grunt.registerTask('script',    ['coffee:compile', 'uglify:app']);
  grunt.registerTask('html',      ['copy:html']);
  grunt.registerTask('templates', ['copy:templates']);
  grunt.registerTask('bowerjs',   ['bower_concat:build', 'uglify:bower']);

  grunt.registerTask('build',     [ 'style', 'script', 'html', 'templates', 'bowerjs' ]);
  grunt.registerTask('serve',     [ 'build', 'connect:server', 'watch' ]);

};