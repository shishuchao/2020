
function OpenNewWindow(url,width,height)
{
  var win=window.open(url,"_blank","resizable=0,scrollbars=1,width=0,height=0");
  x=(window.screen.width-width)/2;
  y=(window.screen.height-height)/2;
  win.moveTo(x,y);
  win.resizeTo(width,height);
  
}
function showMDialog(url,obj,args,width,height)
{
var win=window.showModalDialog(url,obj,args,"unadorned:yes;help:no;dialogHide:yes;center:yes;scroll:auto;status:no;dialogWidth="+width+"px;dialogHeight="+height+"px");
x=(window.screen.width-width)/2;
  y=(window.screen.height-height)/2;
  win.moveTo(x,y);
  win.resizeTo(width,height);
window.showModalDialog
				(url,window,"unadorned:yes;help:no;dialogHide:yes;center:yes;scroll:auto;status:no;dialogWidth=300px;dialogHeight=400px");
				
}