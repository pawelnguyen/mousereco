/**
 * MouseRecorder.Util
 */
(function(namespace) {
    namespace.Util = {
        addEventListener: function(el, event, callback, scope) {
            var _callback = function() {
                callback.apply(scope, arguments);
            };
            if(el.addEventListener !== undefined) {
                el.addEventListener(event, _callback, false);
            }
            else if(el.attachEvent !== undefined) {
                el.attachEvent('on' + event, _callback);
            }
            else {
                el['on' + event] = _callback;
            }
        },
        getUID: function() {
            return ((((1+Math.random())*0x10000)|0).toString(16) + (new Date().getTime()).toString(16)).substring(1);
        },
        getUrl: function() {
            return document.URL;
        },
        toString: function(obj, index) {
            var params = [];
            for(var i in obj) {
                var key = (index === undefined) ? i : index + '[' + i + ']';
                if(Array.isArray(obj[i])) {
                    params.push(this.toString(obj[i], key));
                }
                else if(typeof obj[i] === 'object') {
                    params.push(this.toString(obj[i], key));
                }
                else {
                    params.push(key + '=' + obj[i]);
                }
            }
            return params.join('&');
        },
        getHTML: function() {
            var html = document.documentElement.outerHTML.replace(/\s+/g, ' ').replace(/\r?\n|\r/g, ' ').replace(
                /<head>(.*)<\/head>/, '<base href="' + this.getUrlRoot() + '">' + document.getElementsByTagName('head')[0].innerHTML);
            return encodeURIComponent(html.replace(/\s+/g, ' ').replace(/\r?\n|\r/g, ' '));
        },
        getUrlRoot: function() {
            return this.getUrl().match(/(.*\/)/)[0];
        },
        getWindowSize: function() {
            return {width: window.innerWidth, height: window.innerHeight};
        }
    };
})(MouseRecorder);