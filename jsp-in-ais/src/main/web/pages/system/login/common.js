var highlightcolor="#fc3";
var ns6=document.getElementById&&!document.all;
var previous='';
var eventobj;

// SET FOCUS TO FIRST ELEMENT AND HIDE/SHOW ELEMENTS IF JAVASCRIPT ENABLED
	function init(){
		if(document.forms[1] != null && document.forms[1].elements[0] != null) {
			document.forms[1].elements[0].focus();
			document.forms[1].elements[0].select();
		}
		redirectToTop();
	}

 function redirectToTop() {
        if (top.header != null) {
            top.location = document.location.href;
        }
         if (top.basefrm != null) {
            top.location = document.location.href;
        }
        // if in the command assistant window, redirect to the main window
        if (window.name != null &&
            window.name.indexOf("wsadminCAWindow")==0 ) {
           
            if (window.opener != null) {
                window.opener.top.location = document.location.href;
                window.close();
            }
        }
    }
// REGULAR EXPRESSION TO HIGHLIGHT ONLY FORM ELEMENTS
	var intended=/INPUT|TEXTAREA|SELECT|OPTION/

// FUNCTION TO CHECK WHETHER ELEMENT CLICKED IS FORM ELEMENT
	function checkel(which){
		if (which.style && intended.test(which.tagName)){return true}
		else return false
	}

// FUNCTION TO HIGHLIGHT FORM ELEMENT
	function highlight(e){
		if(!ns6){
			eventobj=event.srcElement
			if (previous!=''){
				if (checkel(previous))
				previous.style.backgroundColor=''
				previous=eventobj
				if (checkel(eventobj)) eventobj.style.backgroundColor=highlightcolor
			}
			else {
				if (checkel(eventobj)) eventobj.style.backgroundColor=highlightcolor
				previous=eventobj
			}
		}
	}

