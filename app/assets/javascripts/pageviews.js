(function(namespace) {

    var EVENTS = {
        MOVE: 'mousemove',
        SCROLL: 'scroll'
    },
    Player = function(events, $iframe){
        this.events = events;
        this.$iframe = $iframe;
        this.$mouse = null;
        this.now = events[0].timestamp - 1000;//(new Date()).getTime();
        this.current = 0;
    };
    Player.prototype = {
        play: function() {
            if(this.events[this.current]) {
                var self = this,
                    event = this.events[this.current],
                    timeout = event.timestamp - this.now;
                setTimeout(function() {
                    self.current++;
                    self.now = event.timestamp;
                    self.showEvent(event);
                    self.play();
                }, timeout);
            }
        },
        showEvent: function(event) {
            event.type = event.type.toLowerCase();
            switch(event.type) {
                case EVENTS.SCROLL:
                    this.$iframe.scrollTop(event.y);
                    this.$iframe.scrollLeft(event.x);
                    break;
                case EVENTS.MOVE:
                    this.moveMouse(event.x, event.y);
                    break
                default:
                    this.moveMouse(event.x, event.y);
                    this.$iframe.append('<div style="position:absolute;top:' + event.y + 'px;left:' + event.x + 'px;color:red;">' + this.current + '-' + event.type + '</div>');
                    break;
            }
        },
        moveMouse: function(x, y) {
            if(!this.$mouse) {
                this.$iframe.append('<div id="mouse" style="position:absolute;top:' + y + 'px;left:' + x + 'px;color:blue;font-size:50px;">Mouse</div>');
                this.$mouse = this.$iframe.find('#mouse');
            }
            this.$mouse.css({top: x, left: y});
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
                player.play();
//                var $iframeBody = $('iframe').contents().find('body')
//                $.each(data, function(i, o) {
//                    createPoint(o.x, o.y, o.type.toLowerCase(), i, $iframeBody);
//                });
            });
        }
    });
})();