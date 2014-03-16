module.exports = function(grunt) {
    'use strict';

    var config = {};
    config.src = 'app/assets/src/';
    config.common = config.src + 'common/';
    config.tracker = config.src + 'tracker/';
    config.app = config.src + 'app/';

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        concat: {
            options: {
                separator: '\n\n'
            },
            dist: {
                src: [config.src + 'intro.js', config.common + '*.js', config.app + '*.js', config.src + 'outro.js'],
                dest: 'built.js'
            },
            tracker: {
                src: [
                    config.src + 'intro.js',
                    config.common + '*.js',
                    config.tracker + '*.js',
                    config.tracker + 'run.js',
                    config.src + 'outro.js'
                ],
                dest: 'tracker.js'
            }
        },
        jshint: {
            beforeconcat: {
                files: {
                    src: [config.tracker + '*.js']
                }//add dev.jshintrc
            },
            afterconcat: {
                files: {
                    src: ['built.js', 'tracker.js', 'Gruntfile.js']
                }//,
//                options: {
//                    jshintrc: true
//                }
            }
        },
        watch: {
            scripts: {
                files: ['**/*.js'],
                tasks: ['concat'],
                options: {
                    spawn: false
                }
            }
        }
    });
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-jshint');

    grunt.registerTask('default', ['watch']);
    grunt.registerTask('build', ['jshint:beforeconcat', 'concat', 'jshint:afterconcat']);
};