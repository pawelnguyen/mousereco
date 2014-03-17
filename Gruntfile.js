module.exports = function(grunt) {
    'use strict';

    var config = {};
    config.src = 'app/assets/src/';
    config.common = config.src + 'common/';
    config.tracker = config.src + 'tracker/';
    config.app = config.src + 'app/';
    config.tmp = config.src + 'tmp/';

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        indent: {
            dist: {
                src: [
                    config.common + '*.js',
                    config.app + '*.js'
                ],
                dest: config.tmp,
                options: {
                    style: 'space',
                    size: 4,
                    change: 1
                }
            },
            tracker: {
                src: [
                    config.common + '*.js',
                    config.tracker + '*.js'
                ],
                dest: config.tmp,
                options: {
                    style: 'space',
                    size: 4,
                    change: 1
                }
            }
        },
        concat: {
            options: {
                separator: '\n\n'
            },
            dist: {
                src: [
                    config.src + 'intro.js',
                    config.tmp + '*.js',
                    config.src + 'outro.js'
                ],
                dest: 'built.js'
            },
            tracker: {
                src: [
                    config.src + 'intro.js',
                    config.tmp + '*.js',
                    config.tmp + 'run.js',
                    config.src + 'outro.js'
                ],
                dest: 'tracker.js'
            }
        },
        jshint: {
            beforeconcat: {
                files: {
                    src: [
                        config.app + '*.js',
                        config.common + '*.js',
                        config.tracker + '*.js'
                    ]
                },
                options: {
                    jshintrc: 'dev.jshintrc'
                }
            },
            afterconcat: {
                files: {
                    src: ['built.js', 'tracker.js', 'Gruntfile.js']
                },
                options: {
                    jshintrc: true
                }
            }
        },
        clean: [config.tmp],
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
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-indent');

    grunt.registerTask('default', ['watch']);
    grunt.registerTask('build', [
        'clean',
        'jshint:beforeconcat',
        'indent:tracker',
        'concat:tracker',
        'clean',
        'indent:dist',
        'concat:dist',
        'jshint:afterconcat'
    ]);
};