window.mouseRecorder =  {
    TRACK: false
};
$(document).on('ready', function() {
    if($('body').hasClass('pageviews')) {
        var pageviews = new MouseRecorder.Pageviews('#events');
    }
});