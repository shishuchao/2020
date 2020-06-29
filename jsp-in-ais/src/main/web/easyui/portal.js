__CreateJSPath = function (js) {
    var scripts = document.getElementsByTagName("script");
    var path = "";
    for (var i = 0, l = scripts.length; i < l; i++) {
        var src = scripts[i].src;
        if (src.indexOf(js) != -1) {
            var ss = src.split(js);
            path = ss[0];
            break;
        }
    }
    var href = location.href;
    href = href.split("#")[0];
    href = href.split("?")[0];
    var ss = href.split("/");
    ss.length = ss.length - 1;
    href = ss.join("/");
    if (path.indexOf("https:") == -1 && path.indexOf("http:") == -1 && path.indexOf("file:") == -1 && path.indexOf("\/") != 0) {
        path = href + "/" + path;
    }
    return path;
}

var portalPath = __CreateJSPath("portal.js");


document.write('<link href="' + portalPath + 'portal/css/bootstrap.min.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/font-awesome.min.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/style-metro.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/style.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/style-responsive.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + portalPath + 'portal/css/light.css" rel="stylesheet" type="text/css" id="style_color"/>');
document.write('<script src="' + portalPath + 'portal/js/app.js" type="text/javascript" ></script>');
document.write('<script src="' + portalPath + 'portal/js/bootstrap.min.js" type="text/javascript" ></script>');
document.write('<script src="' + portalPath + 'portal/js/jquery.slimscroll.min.js" type="text/javascript" ></script>');
document.write('<script src="' + portalPath + 'portal/js/jquery.cookie.min.js" type="text/javascript" ></script>');


