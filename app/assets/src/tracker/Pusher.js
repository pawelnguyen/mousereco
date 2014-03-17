/**
 * MouseRecorder.Pusher
 */
(function (namespace) {

    var eventsPath = '<%= Mousereco::Engine.routes.url_helpers.api_v1_events_path %>',
        htmlPath = '<%= Mousereco::Engine.routes.url_helpers.api_v1_pageviews_path %>',
        cookie = 'MouseRecorder_visitorKey',
        pushTimeout = 2500,
        Pusher = function () {
            this.url = MouseRecorder.Util.getUrl();
            this.visitorKey = this.getVisitorKey();
            this.pageviewKey = MouseRecorder.Util.getUID();
            this.events = [];
            this.pushTimer = undefined;
        };
    Pusher.prototype = {
        preflight: function () {
            //@TODO this.push(this.basicData(), preflightUrl);
        },
        html: function () {
            var data = this.basicData();
            var window_size = MouseRecorder.Util.getWindowSize();
            data.window_height = window_size.height;
            data.window_width = window_size.width;
            data.page_html = MouseRecorder.Util.getHTML();
            this.push(data, htmlPath);
        },
        receive: function (event, type) {
            var eventType = type || MouseRecorder.Events.CLICK,
                push = (eventType === MouseRecorder.Events.CLICK);
            this.events.push({
                x: event.pageX,
                y: event.pageY,
                timestamp: (new Date()).getTime(),
                type: eventType
            });
            if (push) {
                this.prePush();
            }
            else {
                var self = this;
                if (!this.pushTimer) {
                    this.pushTimer = setTimeout(function () {
                        clearTimeout(self.pushTimer);
                        self.pushTimer = undefined;
                        self.prePush();
                    }, pushTimeout);
                }
            }
        },
        prePush: function () {
            var data = this.basicData();
            data.events = this.events;
            this.events = [];
            this.push(data, eventsPath);
        },
        push: function (data, url, callback) {
            var request = false,
                self = this;
            if (window.ActiveXObject) {
                var types = ['MSXML2.XmlHttp.5.0', 'MSXML2.XmlHttp.4.0', 'MSXML2.XmlHttp.3.0', 'MSXML2.XmlHttp.2.0', 'Microsoft.XmlHttp'];
                for (var i in types) {
                    try {
                        request = new ActiveXObject(types[i]);
                        break;
                    } catch (e) {
                    }
                }
            }
            else if (window.XMLHttpRequest) {
                request = new XMLHttpRequest();
            }

            if (request) {
                request.open('POST', url, true);
                if (callback) {
                    request.onreadystatechange = function () {
                        if (this.status === 200 && this.readyState === 4) {
                            callback.apply(self, JSON.parse(this.responseText));
                        }
                    };
                }
                request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                if (request.readyState !== 4) {
                    request.send(MouseRecorder.Util.toString(data));
                }
            }
        },
        basicData: function () {
            return {
                url: this.url,
                visitor_key: this.visitorKey,
                pageview_key: this.pageviewKey,
                timestamp: (new Date()).getTime()
            };
        },
        getVisitorKey: function () {
            var visitorKeyCookie = MouseRecorder.CookieMonster.get(cookie);
            if (visitorKeyCookie === null || visitorKeyCookie === undefined || visitorKeyCookie.length === 0) {
                visitorKeyCookie = MouseRecorder.Util.getUID();
            }
            MouseRecorder.CookieMonster.set(cookie, visitorKeyCookie, 60 * 60, '/');
            return visitorKeyCookie;
        }
    };

    namespace.Pusher = Pusher;
})(MouseRecorder);