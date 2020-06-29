 
document.body.onmousemove=quicktitle;   
document.body.onmouseover=gettitle;   
document.body.onmouseout=restoretitle;   
  
var temptitle='';   
  
function gettitle() {   
if(event.srcElement.title && (event.srcElement.title!='' || (event.srcElement.title=='' && temptitle!=''))) {   
titlelayer.style.left=event.x;   
titlelayer.style.top=event.y+20;   
titlelayer.style.visibility='visible';   
temptitle=event.srcElement.title;   
event.srcElement.title='';   
titlelayer.innerText=temptitle;   
}   
}   
  
function quicktitle() {   
 if(titlelayer.style.visibility=='visible') {   
titlelayer.style.left=event.x+document.body.scrollLeft;   
titlelayer.style.top=event.y+20+document.body.scrollTop;   
}   
}   
  
function restoretitle() {   
event.srcElement.title=temptitle;   
temptitle='';   
titlelayer.style.visibility='hidden';   
}   