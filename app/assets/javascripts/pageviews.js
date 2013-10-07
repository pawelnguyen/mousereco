(function() {
        $(document).on('ready', function() {
            if($('body').hasClass('pageviews')) {
                var createIframe = function(url) {
                    return $('body').append('<iframe src="' + url + '" width="100%" height="600"></iframe>').find('iframe');
                },
                createPoint = function(x, y, i) {
                    $('body').append('<div style="position:absolute;top:'+y+'px;left:'+x+'px;">'+i+'</div>');
                }

                var $iframe = createIframe($('#events').attr('data-url')),
                    data = $.parseJSON($('#events').attr('data-events')),
                    offsetX = $iframe.offset().left,
                    offsetY = $iframe.offset().top;
                $.each(data, function(i, o) {
                    createPoint(o.x + offsetX, o.y + offsetY, i);
                });
            }
        });
})();