/**
 * MouseRecorder.Pageviews
 */
(function(namespace) {

    var EVENTS = 'data-events',
        WIDTH = 'data-window-width',
        HEIGHT = 'data-window-height',
        URL = 'data-url',
    Pageviews = function(events) {
        this.$events = $(events);
        this.$iframe = this.getIframe();
        this.$progressbar = $('.progress-bar');
        this.events = this.parseEvents();
        this.init();

    };
    Pageviews.prototype = {
        parseEvents: function() {
            return $.parseJSON(this.$events.attr(EVENTS));
        },
        getIframe: function() {
            var $iframe = $('#pageview_window');
            $iframe.attr('src', this.$events.attr(URL));
            $iframe.attr('width', this.$events.attr(WIDTH));
            $iframe.attr('height', this.$events.attr(HEIGHT));
            return $iframe;
        },
        formatTime: function(timeMs) {
            var time = timeMs / 100,
                h = Math.floor(time / (10 * 60 * 60)),
                m = Math.floor(time / (10 * 60)) % 60,
                s = Math.floor(time / 10) % 60,
                ms = Math.floor(time % 10);

            return this.padTime(m) + ':' + this.padTime(s) + ':' + ms;
        },
        padTime: function(time) {
            return time < 10 ? '0' + time : time;
        },
        getTime: function(current, duration) {
            return this.formatTime(current) + ' / ' + this.formatTime(duration);
        },
        init: function() {
            var player,
                self = this;
            this.$iframe.on('load', $.proxy(function() {
                this.player = player = new namespace.Player(this.events, this.$iframe.contents().find('body'), self.$iframe.data('style'));
                var duration = player.getDuration(),
                    $label = self.$progressbar.next();
                $label.text(self.getTime(0, duration));
                $(this.player).on('duration.update', function() {
                    self.$progressbar.width(Math.round((this.getPlayPosition() / this.getDuration() * 100 * 100))/100 + '%');
                    $label.text(self.getTime(this.getPlayPosition(), duration));
                });
            }, this));
            $('button.play').on('click', function() {
                if(player) {
                    var $el = $(this);
                    if($el.hasClass('play')) {
                        $el.toggleClass('play').text('pause');
                        player.play();
                    }
                    else {
                        $el.toggleClass('play').text('play');
                        player.pause();
                    }
                }
            });
        }
    };

    namespace.Pageviews = Pageviews;
})(MouseRecorder);