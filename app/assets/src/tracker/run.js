window.onload = function() {
    if(!(window.parent && window.parent.mouseRecorder && window.parent.mouseRecorder.TRACK === false)) {
        MouseRecorder.Tracker.instance();
    }
};