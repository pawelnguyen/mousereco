(function(namespace) {

    var EVENTS = {
        MOVE: 'mousemove',
        SCROLL: 'scroll'
    },
    Player = function(events, $iframe){
        this.mouseEvents = [];
        this.otherEvents = [];
        this.currentMouseEvent = 0;
        this.currentOtherEvent = 0;
        this.mouseTimestamp = events[0].timestamp - 1000;
        this.otherTimestamp = events[0].timestamp - 1000;

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
                    this.otherEvents.push(events[i]);
                }
                else {
                    this.mouseEvents.push(events[i]);
                }
            }
        },
        play: function() {
            this.paused = false;
            this.playOther();
            this.playMouse();
        },
        pause: function() {
            this.paused = true;
        },
        playMouse: function() {
            if(!this.paused && this.mouseEvents[this.currentMouseEvent]) {
                var self = this;
                if(this.currentMouseEvent === 0) {
                    var event = this.mouseEvents[this.currentMouseEvent],
                        timeout = event.timestamp - this.mouseTimestamp;
                    setTimeout(function() {
                        if(!self.paused) {
                            self.currentMouseEvent++;
                            self.mouseTimestamp = event.timestamp;
                            self.showEvent(event);
                            self.playMouse();
                        }
                    }, timeout);
                }
                else {
                    var currentEvent = this.mouseEvents[this.currentMouseEvent],
                        previousEvent = this.mouseEvents[this.currentMouseEvent - 1];
                    this.$mouse.animate({
                        top: currentEvent.y,
                        left: currentEvent.x
                    }, currentEvent.timestamp - previousEvent.timestamp, function() {
                        if(!self.paused) {
                            self.currentMouseEvent++;
                            self.mouseTimestamp = currentEvent.timestamp;
                            self.showEvent(currentEvent);
                            self.playMouse();
                        }
                    });
                }
            }
        },
        playOther: function() {
            if(!this.paused && this.otherEvents[this.currentOtherEvent]) {
                var self = this,
                    event = this.otherEvents[this.currentOtherEvent],
                    timeout = event.timestamp - this.otherTimestamp;
                setTimeout(function() {
                    if(!self.paused) {
                        self.currentOtherEvent++;
                        self.otherTimestamp = event.timestamp;
                        self.showEvent(event);
                        self.playOther();
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
                case EVENTS.MOVE:
                    this.$iframe.append('<div style="position:absolute;top:' + event.y + 'px;left:' + event.x + 'px;color:red;">' + this.currentMouseEvent + '-' + event.type + '</div>');
                    break;
                default:
                    this.$iframe.append('<div style="position:absolute;top:' + event.y + 'px;left:' + event.x + 'px;color:red;">' + this.currentMouseEvent + '-' + event.type + '</div>');
                    break;
            }
        },
        createMouse: function() {
            if(!this.$mouse) {
                this.$iframe.append('<div id="mouse" style="max-width:50px;min-width:10px;position:absolute;top:' + 0 + 'px;left:' + 0 + 'px;color:blue;font-size:10px;z-index:99999;background-color:black;">Mouse</div>');
                this.$mouse = this.$iframe.find('#mouse');
            }
        }
    };

    namespace.Player = Player;
})(window);

(function() {
    $(document).on('ready', function() {
        if ($('body').hasClass('pageviews')) {
            var createIframe = function(url, width, height) {
                    var pageview_window = $('#pageview_window');
                    pageview_window.attr('src', url);
                    pageview_window.attr('width', width);
                    pageview_window.attr('height', height);
                    return pageview_window;
                },
                createPoint = function(x, y, type, i, $el) {
                    var color = type == 'click' ? 'blue' : 'pink';
                    $el.append('<div style="position:absolute;top:' + y + 'px;left:' + x + 'px;color:' + color + '">' + i + '</div>');
                }

            var $iframe = createIframe($('#events').attr('data-url'), $('#events').attr('data-window-width'), $('#events').attr('data-window-height')),
                data = $.parseJSON($('#events').attr('data-events')),
                offsetX = $iframe.offset().left,
                offsetY = $iframe.offset().top;

            $('iframe').on('load', function() {
                player = new window.Player(data, $('iframe').contents().find('body'));
                window.pl = player;
//                player.play();
//                var $iframeBody = $('iframe').contents().find('body')
//                $.each(data, function(i, o) {
//                    createPoint(o.x, o.y, o.type.toLowerCase(), i, $iframeBody);
//                });
            });
        }
    });
})();