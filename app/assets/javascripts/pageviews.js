(function(namespace) {

    var EVENTS = {
        SCROLL: 'scroll'
    },
    Player = function(events, $iframe){
        this.events = events;
        this.$iframe = $iframe;
        this.$iframeBody = this.$iframe.contents().find('body');
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
            this.$iframeBody.append('<div style="position:absolute;top:' + event.y + 'px;left:' + event.x + 'px;color:red;">' + this.current + '-' + event.type + '</div>');
            switch(event.type) {
                case EVENTS.SCROLL:
                    this.$iframeBody.scrollTop(event.y);
                    this.$iframeBody.scrollLeft(event.x);
                    break;
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
                player = new window.Player(data, $('iframe'));
                player.play();
//                var $iframeBody = $('iframe').contents().find('body')
//                $.each(data, function(i, o) {
//                    createPoint(o.x, o.y, o.type.toLowerCase(), i, $iframeBody);
//                });
            });
        }
    });
})();