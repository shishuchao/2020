/**
 * COMMON DHTML FUNCTIONS
 * These are handy functions I use all the time.
 *
 * By Seth Banks (webmaster at subimage dot com)
 * http://www.subimage.com/
 *
 * Up to date code can be found at http://www.subimage.com/dhtml/
 *
 * This code is free for you to use anywhere, just keep this comment block.
 */

/**
 * X-browser event handler attachment and detachment
 * TH: Switched first true to false per http://www.onlinetools.org/articles/unobtrusivejavascript/chapter4.html
 *
 * @argument obj - the object to attach event to
 * @argument evType - name of the event - DONT ADD "on", pass only "mouseover", etc
 * @argument fn - function to call
 */
function addEvent(obj, evType, fn){
 if (obj.addEventListener){
    obj.addEventListener(evType, fn, false);
    return true;
 } else if (obj.attachEvent){
    var r = obj.attachEvent("on"+evType, fn);
    return r;
 } else {
    return false;
 }
}
function removeEvent(obj, evType, fn, useCapture){
  if (obj.removeEventListener){
    obj.removeEventListener(evType, fn, useCapture);
    return true;
  } else if (obj.detachEvent){
    var r = obj.detachEvent("on"+evType, fn);
    return r;
  } else {
    alert("Handler could not be removed");
  }
}

/**
 * Code below taken from - http://www.evolt.org/article/document_body_doctype_switching_and_more/17/30655/
 *
 * Modified 4/22/04 to work with Opera/Moz (by webmaster at subimage dot com)
 *
 * Gets the full width/height because it's different for most browsers.
 */
function getViewportHeight() {
	if (window.innerHeight!=window.undefined) return window.innerHeight;
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientHeight;
	if (document.body) return document.body.clientHeight; 

	return window.undefined; 
}
function getViewportWidth() {
	var offset = 17;
	var width = null;
	if (window.innerWidth!=window.undefined) return window.innerWidth; 
	if (document.compatMode=='CSS1Compat') return document.documentElement.clientWidth; 
	if (document.body) return document.body.clientWidth; 
}

/**
 * Gets the real scroll top
 */
function getScrollTop() {
	if (self.pageYOffset) // all except Explorer
	{
		return self.pageYOffset;
	}
	else if (document.documentElement && document.documentElement.scrollTop)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollTop;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollTop;
	}
}
function getScrollLeft() {
	if (self.pageXOffset) // all except Explorer
	{
		return self.pageXOffset;
	}
	else if (document.documentElement && document.documentElement.scrollLeft)
		// Explorer 6 Strict
	{
		return document.documentElement.scrollLeft;
	}
	else if (document.body) // all other Explorers
	{
		return document.body.scrollLeft;
	}
}

/*
            window.attachEvent("onload", function(){
                var inputArr = document.getElementsByTagName('input');
                for(var i=0; i<inputArr.length; i++){
                    var input = inputArr[i];
                    var type  = input.getAttribute('type');
                    var valuelen = input.value.length;
                    if(input){
                        if(type === 'button' || type === 'submit' || type === 'reset'){
                            input.className = 'button';
                            input.title = input.value;
                            if(valuelen > 4){
                            	input.style.width = 16*valuelen + "px";
                            }
                            input.attachEvent("onmouseover", function(e){
                            	var et = e||window.event;
                            	var ele = et.srcElement || et.target;
                            	if(ele && ele.nodeName.toLowerCase() == 'input'){
                            		ele.className = 'buttonOver';
                            	}
                            });
                            input.attachEvent("onmouseout", function(e){
                            	var et = e||window.event;
                            	var ele = et.srcElement || et.target;
                            	if(ele && ele.nodeName.toLowerCase() == 'input'){
                            		ele.className = 'button';
                            	}
                            });
                        }else if(type === 'text' || type === 'file' || type === 'password'){
                            input.className = 'text';
                        }
                    }
                }
                var buttonArr = document.getElementsByTagName('button');
                for(var i=0; i<buttonArr.length; i++){
                	if(buttonArr[i].className &&  buttonArr[i].className.indexOf('easyui-linkbutton')!=-1) continue;
                    buttonArr[i].className = 'button';
                    var valuelen = buttonArr[i].innerText.length;
                    if( valuelen > 4){
                    	buttonArr[i].style.width = 16*valuelen + "px";
                    }
                }
                var tableArr = document.getElementsByTagName('table');
                for(var i=0; i<tableArr.length; i++){
                    var t = tableArr[i];
                    t.removeAttribute('border');
                    t.setAttribute('cellSpacing','0');
                    t.setAttribute('cellPadding','0');
                }
            });
            */
            
 //window.open()���� 
            function winopen(url,height,width){
    	    	window.open(url,"","height="+height+"px, width="+width+"px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
    	    }
            
