/**
 * @fileoverview 生成extjs菜单
 * @author 王远
 */

function onAllLoad(){}

this.onAllLoad = Ext.onReady;

function createToolbar(id){
	var mytoolbar = new Ext.Toolbar();
	mytoolbar.render(id);
	return mytoolbar;
}

function insDefaultMenu(tb, text, url, target){
	var bt = new Ext.Toolbar.Button();
	bt.text = text;
	bt.on("click", function(){window.open(url, target);});
	tb.add(bt);
}

function showMessage(date){
	if(date == null || date == ""){
		date = new Date().format("ymd");
	}
	Ext.Msg.show({
		title: '关于',
		msg: '<font size=5>审计信息一体化系统 A5.' + date + '</font><br><br><br><br>版权所有：北京用友审计软件有限公司 2008',
		width: 400,
		buttons: {ok:'确认'}
	});
}

function insSubMenu(tb, text, frame, url, target, date){
	var bt = new Ext.Toolbar.Button();
	bt.text = text;
	bt.menu = new Ext.menu.Menu();
	bt.menu.minWidth=0;
	bt.menu.on("beforeshow", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(frame)[0], true);});
	bt.menu.on("beforehide", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(frame)[0], false);});
	var item1 = new Ext.menu.Item();
	item1.text = "手册";
	item1.on("click", function(){window.open(url, target);});
	bt.menu.addItem(item1);
	var item2 = new Ext.menu.Item();
	item2.text = "关于";
	item2.on("click", function(){showMessage(date);});
	bt.menu.addItem(item2);
	tb.add(bt);
}

function setFrameDisabled(frame, flag){
	if(typeof(frame) != "undefined"){
		frame.disabled = flag;
		try{
			var frameList1 = frame.contentWindow.document.getElementsByTagName("frame");
			var frameList2 = frame.contentWindow.document.getElementsByTagName("iframe");
			for(var i=0; i<frameList1.length; i++){
				frameList1[i].disabled = flag;
			}
			for(var i=0; i<frameList2.length; i++){
				frameList2[i].disabled = flag;
			}
		}catch(e){
			return false;
		}
	}else{
		return false;
	}
}

function insMainMenu1(tb, text, child,url, frame ,isEnabled){
	var newTarget=getTarget(text,frame);
	var bt = new Ext.Toolbar.Button();
	bt.text = text;
	bt.disabled = !eval("isEnabled");
	if(child){
		bt.menu = new Ext.menu.Menu();
		bt.menu.minWidth=0;
		bt.menu.on("beforeshow", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], true);});
		bt.menu.on("beforehide", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], false);});
	}
	else{
	bt.on("click", function(){window.open(url, newTarget);});
	}
	tb.add(bt);
	return bt;
}

function insMainMenu4protal(tb, text, child,url, frame){
	var newTarget=getTarget(text,frame);
	var bt = new Ext.Toolbar.Button();
	bt.text = text;
	if(child){
		bt.menu = new Ext.menu.Menu();
		bt.menu.minWidth=0;
		bt.menu.on("beforeshow", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], true);});
		bt.menu.on("beforehide", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], false);});
	}
	else{
	bt.on("click", function(){window.parent.location=url});
	}
	tb.add(bt);
	return bt;
}

function insMainMenu(tb, text, child,url, frame){
	var newTarget=getTarget(text,frame);
	var bt = new Ext.Toolbar.Button();
	bt.text = "<font style=\"font-size: 14px\">"+text+"</font>";
	if(child){
		bt.menu = new Ext.menu.Menu();
		bt.menu.minWidth=0;
		bt.menu.on("beforeshow", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], true);});
		bt.menu.on("beforehide", function(){setFrameDisabled(Ext.getDom(document).getElementsByName(newTarget)[0], false);});
	}
	else{
	bt.on("click", function(){window.open(url, newTarget);});
	}
	tb.add(bt);
	return bt;
}
function getTarget(text,target){
return target;
}
function insMenu(bt, text, child, url, target){
var newTarget=getTarget(text,target);
	if(bt.menu == null){
		bt.menu = new Ext.menu.Menu();
		bt.menu.minWidth=0;
	}
	var item = new Ext.menu.Item();
	item.style="text-align:left;font-size:14px;";
	item.text = text;
	if(!child && url != ""){
		item.on("click", function(){window.open(url, newTarget);});
	}
	bt.menu.addItem(item);
	return item;
}
