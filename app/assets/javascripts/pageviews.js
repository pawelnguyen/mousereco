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
                var $iframeBody = $('iframe').contents().find('body')
                $.each(data, function(i, o) {
                    createPoint(o.x, o.y, o.type.toLowerCase(), i, $iframeBody);
                });
            });
//            setTimeout(function() {
//                var $iframeBody = $('iframe').contents().find('body');
//                $.each(data, function(i, o) {
//                    createPoint(o.x, o.y, i, $iframeBody);
//                });
//            }, 2000);
        }
    });
})();