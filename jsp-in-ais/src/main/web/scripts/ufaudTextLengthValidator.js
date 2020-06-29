
addEventSimple(window, "load", addEventSimpleLoad);
function addEventSimpleLoad() {
	addEventSimple(window.document.body, "keyup", validateLengthForInput);
	addEventSimple(window.document.body, "paste", validateLengthForPaste);
}
function validateLengthForPaste(e) {
	validateLengthBase(e, clipboardData.getData("Text"));
}

function validateLengthForInput(e) {
	var evt = e || window.event;
	if(evt.ctrlKey)return false;
	if(evt.altKey)return false;
	if(evt.keyCode<=47&&!(evt.keyCode==32||evt.keyCode==13||evt.keyCode==16))return false;
	if(evt.keyCode>=106&&!((evt.keyCode>=186&&evt.keyCode<=192)||(evt.keyCode>=219&&evt.keyCode<=222)))return false;
	var eventSrc = evt.target || evt.srcElement;
	validateLengthBase(evt, "1");
}

/*
 * 自定义属性isAlerted，防止多次提醒
 * 自定义属性maxlen，在开始录入数据时将maxlen=maxLength，然扣将maxlength+=1，防止在输入最大长度时就提醒
 */
function validateLengthBase(e, inputStr) {
	var evt = e || window.event;
	var eventSrc = evt.target || evt.srcElement;
	var selText = getFieldSelection(eventSrc);
	if (eventSrc.nodeName == "INPUT" || eventSrc.nodeName == "TEXTAREA") {
		if(!eventSrc.maxLen&&eventSrc.maxLength > 0){
			eventSrc.maxLen = eventSrc.maxLength;
			eventSrc.maxLength = eventSrc.maxLength+1;
		}
		var maxlen = eventSrc.maxLen;
		var maxlenEvt = document.getElementById(eventSrc.name + ".maxlength");
		if (maxlen == null && maxlenEvt) {
			maxlen = parseInt(maxlenEvt.value);
		}
		if (maxlen > 0 && evt.isAlerted != 1 && (eventSrc.value.length - selText.length + inputStr.length) > maxlen+1) {
			alertContent(eventSrc.title, maxlen);
			eventSrc.value = eventSrc.value.substring(0,maxlen);
			evt.isAlerted = 1;
			evt.returnValue = false;
		}
	}
}
function alertContent(title, maxlen) {
	/*if (title) {
		alert(title + "\u957f\u5ea6\u4e0d\u80fd\u8d85\u8fc7" + maxlen + "\uff01");
	} else {
		alert("\u8f93\u5165\u5b57\u7b26\u957f\u5ea6\u4e0d\u80fd\u8d85\u8fc7" + maxlen + "\uff01");
	}*/
	var title = title == '' || title == null ? "我的消息" : title
	window.parent.$.messager.show({
		title:'提示信息',
		msg:"\u957f\u5ea6\u4e0d\u80fd\u8d85\u8fc7" + maxlen + "\uff01"
	});
}
function addEventSimple(obj, evt, fn) {
	if (obj.addEventListener) {
		obj.addEventListener(evt, fn, false);
	} else {
		if (obj.attachEvent) {
			obj.attachEvent("on" + evt, fn);
		}
	}
}
function getFieldSelection(select_field) {
	var word = "";  //IE
	if (document.selection) {
		var sel = document.selection.createRange();
		if (sel.text.length > 0) {
			word = sel.text;
		}
	} else {
		if (select_field.selectionStart || select_field.selectionStart == "0") {//FF 
			var startP = select_field.selectionStart;
			var endP = select_field.selectionEnd;
			if (startP != endP) {
				word = select_field.value.substring(startP, endP);
			}
		}
	}
	return word;
}

