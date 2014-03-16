/**
 * MouseRecorder.Tracker
 */
(function(namespace){

    var instance,
        mousePositionTrackInterval = 100,
        mouseScrollTrackInterval = 100,
        mouseOverTrackInterval = 250,
        body = document.getElementsByTagName('body')[0],
        Tracker = function() {
            this.pusher = new MouseRecorder.Pusher();
            this.pusher.html();

            this.coords = {};
            this.initListeners();
        };
    Tracker.prototype = {
        on: {},
        initListeners: function() {
            MouseRecorder.Util.addEventListener(window, MouseRecorder.Events.OVER, this.withInterval(MouseRecorder.Events.OVER, mouseOverTrackInterval, MouseRecorder.Events.MOVE), this);
            MouseRecorder.Util.addEventListener(window, MouseRecorder.Events.SCROLL, this.withInterval(MouseRecorder.Events.SCROLL, mouseScrollTrackInterval), this);
            MouseRecorder.Util.addEventListener(document, MouseRecorder.Events.MOVE, this.withInterval(MouseRecorder.Events.MOVE, mousePositionTrackInterval), this);
            MouseRecorder.Util.addEventListener(document, MouseRecorder.Events.CLICK, this.pusher.receive, this.pusher);
        },
        withInterval: function(eventType, interval, asEvent) {
            var self = this,
                sourceEvent = eventType,
                destEvent = (asEvent === undefined ? eventType : asEvent);
            setInterval(function() {
                if(self.coords[sourceEvent] && self.coords[sourceEvent].update === true) {
                    self.coords[sourceEvent].update = false;
                    self.pusher.receive(self.coords[sourceEvent], destEvent);
                }
            }, interval);
            return function(event) {
                var data = self.on[sourceEvent](event);
                self.coords[sourceEvent] = self.coords[sourceEvent] || {};
                self.coords[sourceEvent].update = true;
                self.coords[sourceEvent].pageX = data[0];
                self.coords[sourceEvent].pageY = data[1];
            };
        }
    };
    Tracker.prototype.on[MouseRecorder.Events.SCROLL] = function(event) {
        return [body.scrollLeft, body.scrollTop];
    };
    Tracker.prototype.on[MouseRecorder.Events.MOVE] = function(event) {
        return [event.pageX, event.pageY];
    };
    Tracker.prototype.on[MouseRecorder.Events.OVER] = function(event) {
        return [event.pageX, event.pageY];
    };

    namespace.Tracker = {
        instance: function() {
            if(!instance) {
                instance = new Tracker();
            }
            return instance;
        }
    };
})(MouseRecorder);