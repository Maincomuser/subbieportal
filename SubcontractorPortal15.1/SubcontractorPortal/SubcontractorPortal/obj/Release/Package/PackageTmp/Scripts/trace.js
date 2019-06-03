function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function getCookie(name) { var match = new RegExp(name + '\s?=\s?([^;]*);?', 'g').exec(document.cookie) || []; return match.length > 1 ? unescape(match[1]) : null; }
function eraseCookie(name) {
    createCookie(name, "", -1);
}

function GetHeight() {
    var myHeight = 0;
    if (typeof (window.innerWidth) == 'number') {
        //Non-IE
        myHeight = window.innerHeight;
    } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        //IE 6+ in 'standards compliant mode'
        myHeight = document.documentElement.clientHeight;
    } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
        //IE 4 compatible
        myHeight = document.body.clientHeight;
    }
    var new_h = (myHeight - 35);
    //alert(new_h);
    createCookie('bheight', new_h, 10);
    //alert(getCookie('bheight'));
    return myHeight;
}

function setIframeHeight(iframeName) {
    var iframeEl = document.getElementById ? document.getElementById(iframeName) : document.all ? document.all[iframeName] : null;
    if (iframeEl) {
        iframeEl.style.height = "auto"; // helps resize (for some) if new doc shorter than previous            
        var new_h = getCookie('bheight');
        iframeEl.style.height = new_h + "px";
    }
}
function setMiniIframeHeight(iframeName) {
    var iframeEl = document.getElementById ? document.getElementById(iframeName) : document.all ? document.all[iframeName] : null;
    if (iframeEl) {
        iframeEl.style.height = "auto"; // helps resize (for some) if new doc shorter than previous            
        var new_h = getCookie('bheight');
        var miniHeight = parseInt(new_h);
        miniHeight = miniHeight - 60;
        iframeEl.style.height = miniHeight + "px";
    }
}


