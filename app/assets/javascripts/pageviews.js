mouseRecorder = mouseRecorder || {};
mouseRecorder.modules = mouseRecorder.modules || {};
mouseRecorder.views = mouseRecorder.views || {};



(function(namespace) {

    var EVENTS = {
        MOVE: 'mousemove',
        SCROLL: 'scroll'
    },
    playDelay = 500,
    Player = function(events, $iframe){
        this.mouseEvents = [];
        this.scrollEvents = [];
        this.currentMouseEvent = 0;
        this.currentScrollEvent = 0;

        this.currentMouseEventTimestamp = events[0].timestamp - playDelay;
        this.mouseRealTimestamp = 0;
        this.mousePauseTimeout = 0;

        this.currentScrollEventTimestamp = events[0].timestamp - playDelay;
        this.scrollRealTimestamp = 0;
        this.scrollPauseTimeout = 0;

        this.$iframe = $iframe;
        this.$mouse = null;

        this.groupEvents(events);
        this.createMouse();
    };
    Player.prototype = {
        groupEvents: function(events) {
            for(var i in events) {
                events[i].type = events[i].type.toLowerCase();
                if(events[i].type == EVENTS.SCROLL) {
                    this.scrollEvents.push(events[i]);
                }
                else {
                    this.mouseEvents.push(events[i]);
                }
            }
        },
        createMouse: function() {
            if(!this.$mouse) {
                this.$iframe.append('<div id="mouse" style="max-width:50px;min-width:10px;position:absolute;top:' + 0 + 'px;left:' + 0 + 'px;color:blue;font-size:10px;z-index:99999;background-color:black;">Mouse</div>');
                this.$mouse = this.$iframe.find('#mouse');
            }
        },
        play: function() {
            this.paused = false;
            this.playScroll();
            this.playMouse();
        },
        pause: function() {
            this.paused = true;
            clearTimeout(this.scrollTimeout);
            clearTimeout(this.mouseTimeout);
            this.$mouse.stop();
            this.mousePauseTimeout += (new Date()).getTime() - this.mouseRealTimestamp;
            this.scrollPauseTimeout += (new Date()).getTime() - this.scrollRealTimestamp;
        },
        playMouse: function() {
            if(!this.paused && this.mouseEvents[this.currentMouseEvent]) {
                var self = this;
                if(this.currentMouseEvent === 0) {
                    var event = this.mouseEvents[this.currentMouseEvent],
                        timeout = event.timestamp - this.currentMouseEventTimestamp;
                    this.mouseRealTimestamp = (new Date()).getTime();
                    this.mouseTimeout = setTimeout(function() {
                        if(!self.paused) {
                            self.currentMouseEvent++;
                            self.currentMouseEventTimestamp = event.timestamp;
                            self.showEvent(event);
                            self.playMouse();
                        }
                    }, timeout);
                }
                else {
                    var currentEvent = this.mouseEvents[this.currentMouseEvent],
                        previousEvent = this.mouseEvents[this.currentMouseEvent - 1],
                        tmpPauseTimestamp = this.mousePauseTimeout;
                    this.mouseRealTimestamp = (new Date()).getTime();
                    this.$mouse.animate({
                        top: currentEvent.y,
                        left: currentEvent.x
                    }, currentEvent.timestamp - previousEvent.timestamp - tmpPauseTimestamp, function() {
                        if(!self.paused) {
                            self.mousePauseTimeout = 0;
                            self.currentMouseEvent++;
                            self.currentMouseEventTimestamp = currentEvent.timestamp;
                            self.showEvent(currentEvent);
                            self.playMouse();
                        }
                    });
                }
            }
        },
        playScroll: function() {
            if(!this.paused && this.scrollEvents[this.currentScrollEvent]) {
                var self = this,
                    event = this.scrollEvents[this.currentScrollEvent],
                    timeout = event.timestamp - this.currentScrollEventTimestamp - this.scrollPauseTimeout;
                this.scrollRealTimestamp = (new Date()).getTime();
                this.scrollTimeout = setTimeout(function() {
                    if(!self.paused) {
                        self.scrollPauseTimeout = 0;
                        self.currentScrollEvent++;
                        self.currentScrollEventTimestamp = event.timestamp;
                        self.showEvent(event);
                        self.playScroll();
                    }
                }, timeout);
            }
        },
        showEvent: function(event) {
            switch(event.type) {
                case EVENTS.SCROLL:
                    this.$iframe.scrollTop(event.y);
                    this.$iframe.scrollLeft(event.x);
                    break;
                default:
                    this.$iframe.append('<div style="position:absolute;top:' + event.y + 'px;left:' + event.x + 'px;color:red;z-index:99998;">' + this.currentMouseEvent + '-' + event.type + '</div>');
                    break;
            }
        }
    };

    namespace.Player = Player;
})(mouseRecorder.modules);


(function(namespace) {

    var EVENTS = 'data-events',
        WIDTH = 'data-window-width',
        HEIGHT = 'data-window-height',
        URL = 'data-url',
    Pageviews = function(events) {
        this.$events = $(events);
        this.$iframe = this.getIframe();
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
        init: function() {
            var player;
            this.$iframe.on('load', $.proxy(function() {
                this.player = player = new mouseRecorder.modules.Player(this.events, this.$iframe.contents().find('body'));
            }, this));
            $('button.play').on('click', function() {
                if(player) {
                    var $el = $(this);
                    if($el.hasClass('play')) {
                        $el.toggleClass('play').text('pause');
                        player.play()
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
})(mouseRecorder.views);


$(document).on('ready', function() {
    if($('body').hasClass('pageviews')) {
        var pageviews = new mouseRecorder.views.Pageviews('#events');
    }
});