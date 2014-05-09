jQuery(function($){
    var options = foswiki.LinkSymbolsPlugin;
    if(!options || !(options.map)) {
        window.console && console.log('Preferences for LinkSymbolsPlugin not found');
        return;
    }
    var extensionRegexp = /\.([a-zA-Z0-9]{1,4})$/;
    var regexpns = {};
    for(check in options.map) {
        if(!check || !(options.map[check])) continue;
        regexpns[check] = new RegExp("^(" + check + ")$");
    }
    var check = function() {
        var $this = $(this);
        var href = $this.attr('href');
        if(!href) return;
        var m = extensionRegexp.exec(href);
        if(!m) return;
        var check;
        for(check in regexpns) {
            if(regexpns[check].exec(m[1])) {
                if(options.append) $this.append(options.append.replace(/\$IMAGE/g, options.map[check]));
                if(options.prepend) $this.prepend(options.prepend.replace(/\$IMAGE/g, options.map[check]));
                break;
            }
        }
    }
    $(options.selector).livequery(check);
});
