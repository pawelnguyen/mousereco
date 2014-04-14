module.exports = function(grunt) {
    'use strict';

    var config = {};
    config.src = 'app/assets/src/';
    config.common = config.src + 'common/';
    config.tracker = config.src + 'tracker/';
    config.app = config.src + 'app/';
    config.tmp = config.src + 'tmp/';
    config.dist = 'app/assets/javascripts/mousereco/';

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
                    config.tmp + 'run.js',
                    config.src + 'outro.js'
                ],
                dest: config.dist + 'pageviews.js'
            },
            tracker: {
                src: [
                    config.src + 'intro.js',
                    config.tmp + '*.js',
                    config.tmp + 'run.js',
                    config.src + 'outro.js'
                ],
                dest: config.dist + 'tracker.js.erb'
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
                    src: [
                        config.dist + 'dist.js',
                        config.dist + 'tracker.js',
                        'Gruntfile.js'
                    ]
                },
                options: {
                    jshintrc: true
                }
            }
        },
        clean: [config.tmp],
        watch: {
            scripts: {
                files: [
                    'Gruntfile.js',
                    'dev.jshintrc',
                    '.jshintrc',
                    config.common + '**/*.js',
                    config.app + '**/*.js',
                    config.tracker + '**/*.js',
                    config.src + '*ro.js'
                ],
                tasks: ['build'],
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
        'jshint:afterconcat',
        'clean'
    ]);
};