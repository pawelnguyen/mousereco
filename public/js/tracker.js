(function(){
    var MouseRecorder = {};

    /**
     * MouseRecorder.Helper
     */
    (function(namespace) {
        namespace.Helper = {
            AddEventListener: function(el, event, callback) {
                if(el.addEventListener != undefined) {
                    el.addEventListener(event, callback, false);
                }
                else if(el.attachEvent != undefined) {
                    el.attachEvent('on' + event, callback);
                }
                else {
                    el['on' + event] = callback;
                }
            },
            AjaxRequest: function(url, data) {
                console.log($.post);
                $.post(url, data);
//                var request = false,
//                    send = true;
//                if (window.ActiveXObject) {
//                    request = new ActiveXObject('Microsoft.XMLHTTP');
//                }
//                else if (window.XMLHttpRequest) {
//                    request = new XMLHttpRequest();
//                }
//                if(request) {
//                    request.open('POST', url, true);
//                    request.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
//                    request.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
//                    if(request.readyState != 4) {
//                        var result = '',
//                        encode = function(data) {
//                            if (typeof data === "string") {
//                                result = data;
//                            } else {
//                                var e = encodeURIComponent;
//                                for (var k in data) {
//                                    if (data.hasOwnProperty(k)) {
//                                        if(typeof data[k] === 'array') {
//                                            result += encode(data[k]);
//                                        }
//                                        else {
//                                            result += '&' + k + '=' + e(data[k]);
//                                        }
//                                    }
//                                }
//                                result = result.substring(1);
//                            }
//                            return result;
//                        };
//                        request.send(JSON.stringify(encode(data)));
//                    }
//                }
            }
        };
    })(MouseRecorder);

    /**
     * MouseRecorder.Tracker
     */
    (function(namespace){

        var instance,

        Tracker = function() {
            this.pusher = new MouseRecorder.Pusher();
            MouseRecorder.Helper.AddEventListener(document, 'click', this.pusher.push);
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

        Pusher = function(){};
        Pusher.prototype = {
            push: function(event) {
                data = {
                    url: 'http://test.com',
                    user_key: '4k5n245j625k23nrg',
                    visitor_key: '49tuhiarf9q834tn34k3t',
                    events: [
                        {
                            x: event.pageX,
                            y: event.pageY,
                            timestamp: (new Date()).getTime()
                        }
                    ]
                }
                console.log(data);
                MouseRecorder.Helper.AjaxRequest(url, data);
            }
        };

        namespace.Pusher = Pusher;
    })(MouseRecorder);


    MouseRecorder.Tracker.instance();
})();