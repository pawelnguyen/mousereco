(function(){
    var MouseRecorder = {};

    /**
     * MouseRecorder.Tracker
     */
    (function(namespace){

        var instance,
        Tracker = function() {
            this.pusher = new MouseRecorder.Pusher();
            MouseRecorder.Util.AddEventListener(document, 'click', this.pusher.receive, this.pusher);
        };
        Tracker.prototype = {};

        namespace.Tracker = {
            instance: function() {
                if(!instance) {
                    instance = new Tracker();
                }
                return instance;
            }
        };
    })(MouseRecorder);


    /**
     * MouseRecorder.Pusher
     */
    (function(namespace) {

        var url = 'http://mouse-recorder.herokuapp.com/api/v1/events',
        Pusher = function(){
            this.pageviewKey = MouseRecorder.Util.GetPageviewKey();
        };
        Pusher.prototype = {
            receive: function(event) {
                this.push({
                    url: 'http://test.com',
                    user_key: '4k5n245j625k23nrg',
                    visitor_key: '49tuhiarf9q834tn34k3t',
                    page_view_key: this.pageviewKey,
                    events: [
                        {
                            x: event.pageX,
                            y: event.pageY,
                            timestamp: (new Date()).getTime()
                        }
                    ]
                });
            },
            push: function(data) {
                var request = false;
                if (window.ActiveXObject) {
                    request = new ActiveXObject('Microsoft.XMLHTTP');
                }
                else if (window.XMLHttpRequest) {
                    request = new XMLHttpRequest();
                }
                if(request) {
                    request.open('POST', url, true);
                    request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                    request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                    if(request.readyState != 4) {
                        request.send(MouseRecorder.Util.ToString(data));
                    }
                }
            }
        };

        namespace.Pusher = Pusher;
    })(MouseRecorder);


    /**
     * MouseRecorder.Util
     */
    (function(namespace) {
        namespace.Util = {
            AddEventListener: function(el, event, callback, scope) {
                var _callback = function() {
                    callback.apply(scope, arguments);
                };
                if(el.addEventListener != undefined) {
                    el.addEventListener(event, _callback, false);
                }
                else if(el.attachEvent != undefined) {
                    el.attachEvent('on' + event, _callback);
                }
                else {
                    el['on' + event] = _callback;
                }
            },
            GetPageviewKey: function() {
                return ((((1+Math.random())*0x10000)|0).toString(16) + (new Date().getTime()).toString(16)).substring(1);
            },
            ToString: function(obj, index) {
                var params = [];
                for(var i in obj) {
                    var key = (index == undefined) ? i : index + '[' + i + ']';
                    if(Array.isArray(obj[i])) {
                        params.push(this.ToString(obj[i], key));
                    }
                    else if(typeof obj[i] === 'object') {
                        params.push(this.ToString(obj[i], key));
                    }
                    else {
                        params.push(key + '=' + obj[i]);
                    }
                }
                return params.join('&');
            }
        };
    })(MouseRecorder);


    MouseRecorder.Tracker.instance();
})();