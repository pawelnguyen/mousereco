(function() {
        $(document).on('ready', function() {
            if($('body').hasClass('pageviews')) {
                var createIframe = function(url) {
                    return $('body').append('<iframe src="' + url + '" width="100%" height="600"></iframe>').find('iframe');
                },
                createPoint = function(x, y, i, $el) {
                    $el.append('<div style="position:absolute;top:'+y+'px;left:'+x+'px;">'+i+'</div>');
                }

                var $iframe = createIframe($('#events').attr('data-url')),
                    data = $.parseJSON($('#events').attr('data-events')),
                    offsetX = $iframe.offset().left,
                    offsetY = $iframe.offset().top;

                $('iframe').on('load', function() {
                    var $iframeBody = $('iframe').contents().find('body')
                    $.each(data, function(i, o) {
                        createPoint(o.x, o.y, i, $iframeBody);
                    });
                });
//                setTimeout(function(){
//                    var $iframeBody = $('iframe').contents().find('body');
//                    $.each(data, function(i, o) {
//                        createPoint(o.x, o.y, i, $iframeBody);
//                    });
//                }, 2000);
            }
        });
})();