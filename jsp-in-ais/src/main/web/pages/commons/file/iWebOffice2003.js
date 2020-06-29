var host = document.location.host;
var codebase = 'http://' + host + '/ais/pages/commons/file/iWebOffice2009.cab#version=10.0.0.0';
var str = '';
str += '<div id="DivID" style="height:100%;">';
str += '<OBJECT id="WebOffice" name="WebOffice" width="100%" height="100%" classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase='+codebase+' >';
str += '</object>';
str += '</div>';
document.write(str);