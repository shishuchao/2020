//全选、反选控制--Edit By LIHAIFENG 2008-05-06
//The Second arguments is name of the checkbox
function selectAll(myform) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.type == "checkbox"||el.type == "radio") {
			if (!el.checked) {
				el.checked = true;
			}
		}
	}
}
function selectAll2(myform,ck) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.name==ck&&(el.type == "checkbox"||el.type == "radio")) {
			if (!el.checked) {
				el.checked = true;
			}
		}
	}
}
function inverse(myform) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.type == "checkbox"||el.type == "radio") {
			if (!el.checked) {
				el.checked = true;
			} else {
				el.checked = false;
			}
		}
	}
}
function inverse2(myform,ck) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.name==ck&&(el.type == "checkbox"||el.type == "radio")) {
			if (!el.checked) {
				el.checked = true;
			} else {
				el.checked = false;
			}
		}
	}
}
function hasSelect(myform) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.type == "checkbox"||el.type == "radio") {
			if (el.checked) {
				return true;
			}
		}
	}
	return false;
}
function hasSelect2(myform,ck) {
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.name==ck&&(el.type == "checkbox"||el.type == "radio")) {
			if (el.checked) {
				return true;
			}
		}
	}
	return false;
}
//只能选择一条记录
function hasSelectOnlyOne(myform) {
	var flag = 0;
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.type == "checkbox"||el.type == "radio") {
			if (el.checked) {
				flag = flag + 1;
			}
		}
	}
	if (flag == 1) {
		return true;
	} else {
		return false;
	}
}
function hasSelectOnlyOne2(myform,ck) {
	var flag = 0;
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.name==ck&&(el.type == "checkbox"||el.type == "radio")) {
			if (el.checked) {
				flag = flag + 1;
			}
		}
	}
	if (flag == 1) {
		return true;
	} else {
		return false;
	}
}
//不能选择记录
function hasSelectNone(myform) {
	var flag = 0;
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.type == "checkbox"||el.type == "radio") {
			if (el.checked) {
				flag = flag + 1;
			}
		}
	}
	if (flag == 0) {
		return true;
	} else {
		return false;
	}
}
function hasSelectNone2(myform,ck) {
	var flag = 0;
	for (var i = 0; i < myform.elements.length; i++) {
		var el = myform.elements[i];
		if (el.name==ck&&(el.type == "checkbox"||el.type == "radio")) {
			if (el.checked) {
				flag = flag + 1;
			}
		}
	}
	if (flag == 0) {
		return true;
	} else {
		return false;
	}
}
//数字验证---LIHAIFENG 2007-09-18
function numberValidate(num, name) {
	var pcd = document.getElementsByName(num)[0].value;
	if (pcd != "") {
		if (pcd.indexOf("-") != -1 && pcd.indexOf("-") == 0) {
			pcd = pcd.replace(new RegExp("-", "gi"), "");
		}
		if (pcd.indexOf(".") != -1) {
			if (pcd.split(".")[1].indexOf(",") != -1) {
				window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
				document.getElementsByName(num)[0].focus();
				return false;
			}
		}
		var pcd1 = pcd.replace(new RegExp(",", "gi"), "");//过滤,号，g表示全部替换，i表示忽略大小写
		var temp = /^[0-9]+\.?[0-9]+$/g;
		if (!temp.test(pcd1)) {
			window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
			document.getElementsByName(num)[0].focus();
			return false;
		}
		if (!isNaN(parseFloat(pcd1))) {
			var pcd2 = pcd.split(",");
			for (var i = 0; i < pcd2.length; i++) {
				if (pcd2.length == 1) {
					break;
				}
				if (i == 0) {
					if (pcd2[i].length > 3) {
						window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
						document.getElementsByName(num)[0].focus();
						return false;
					}
				}
				if (i == pcd2.length - 1) {
					if (pcd2[i].indexOf(".") != -1) {
						if (pcd2[i].split(".")[0].length > 3) {
							window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
							document.getElementsByName(num)[0].focus();
							return false;
						}
					} else {
						if (pcd2[i].length > 3) {
							window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
							document.getElementsByName(num)[0].focus();
							return false;
						}
					}
				} else {
					if (pcd2[i].length > 3) {
						window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
						document.getElementsByName(num)[0].focus();
						return false;
					}
				}
			}
		} else {
			window.alert(name + "\u53ea\u80fd\u586b\u5199\u5f62\u5982\"123.123\"\u6216\u8005\"123,123.123\"\u7684\u6570\u5b57!");
			document.getElementsByName(num)[0].focus();
			return false;
		}
	} else {
		return true;
	}
}
//合并项目选取---LIHAIFENG 2008-03-11
function groupProject(tableId, plan_code) {
	var tbl_obj = document.getElementById(tableId);
	var pre_cell = null;
	var plan_code_cell = null;
	//清除以选中的项目
	for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
		plan_code_cell = tbl_obj.cells(i);
		if (plan_code_cell.firstChild != null && plan_code_cell.firstChild.type == "checkbox") {
			plan_code_cell.firstChild.checked = false;
		}
	}
	//选取同一计划编号的项目
	for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
		plan_code_cell = tbl_obj.cells(i).innerText;
		if (plan_code_cell.replace(/\s+$|^\s+/g, "") == plan_code.replace(/\s+$|^\s+/g, "")) {
			pre_cell = tbl_obj.cells(parseInt(i) - 1);
			if (pre_cell.firstChild.type == "checkbox") {
				pre_cell.firstChild.checked = true;
			}
		}
	}
	return true;
}
//项目合并选取---CNC
function groupProject2(tableId, plan_code,ck) {
	if(ck.checked){
		var tbl_obj = document.getElementById(tableId);
		var plan_code_cell = null;
		//清除以选中的项目
		for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
			plan_code_cell = tbl_obj.cells(i);
			if (plan_code_cell.firstChild != null && plan_code_cell.firstChild.type == "checkbox"&&plan_code_cell.firstChild!=ck) {
				plan_code_cell.firstChild.checked = false;
			}
		}
		//选取同一计划编号的项目
		for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
			plan_code_cell = tbl_obj.cells(i);
			if (plan_code_cell.firstChild != null && plan_code_cell.firstChild.type == "checkbox" && plan_code_cell.firstChild.plancode!=null&&plan_code_cell.firstChild.plancode.replace(/\s+$|^\s+/g, "") == plan_code.replace(/\s+$|^\s+/g, "")) {
				plan_code_cell.firstChild.checked = true;
			}
		}
	}
	else
	{
		var tbl_obj = document.getElementById(tableId);
		var plan_code_cell = null;
		//选取同一计划编号的项目
		for (var i = 0; i <= parseInt(tbl_obj.cells.length) - 1; i++) {
			plan_code_cell = tbl_obj.cells(i);
			if (plan_code_cell.firstChild != null && plan_code_cell.firstChild.type == "checkbox" && plan_code_cell.firstChild.plancode!=null&&plan_code_cell.firstChild.plancode.replace(/\s+$|^\s+/g, "") == plan_code.replace(/\s+$|^\s+/g, "")) {
				plan_code_cell.firstChild.checked = false;
			}
		}
	}
	return true;
}
//修改各个阶段的附件信息-可以保存---（可编辑的附件没有滚动条）
function editFile(fileId, contextPath) {
	var url = contextPath + "/pages/commons/file/iweb.jsp?fileId=" + fileId;
	window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes");
}
//修改各个阶段的附件信息-只读---（只读的附件也没有滚动条）
function readFile(fileId, contextPath) {
	var url = contextPath + "/pages/commons/file/iweb.jsp?fileId=" + fileId + "&&r=t";
	window.open(url, "", "width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes");
}
//实施阶段非OFFICE文件的打开---（可以预览的附件有滚动条）
function viewFileInActualize(fileId, contextPath) {
	var url = contextPath + "/commons/file/downloadFile.action?fileId=" + fileId;
	window.open(url, "", "width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}



//Archives修改各个阶段的附件信息-可以保存
function editFileInArchives(fileId,contextPath){
var url = contextPath+"/pages/commons/file/iweb.jsp?fileId="+fileId;
window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes");
}
//Archives修改各个阶段的附件信息-只读-但可以下载到本地
function readFileInArchives(fileId,contextPath){
	var url = contextPath+"/pages/commons/file/iweb.jsp?fileId="+fileId+"&r=t";
   	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes");
}
//Archives修改各个阶段的附件信息-只读-并且下载可以限制 u=0或空(不能下载)
function readInArchives(fileId,contextPath,u){
var url = contextPath+"/pages/commons/file/iweb.jsp?fileId="+fileId+"&r=t&u=" + u;
window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes");
}
//Archives用IE打开附件，不提供下载方式
function viewFileInArchives(fileId,contextPath){

	var url = contextPath+"/commons/file/downloadFile.action?fileId="+fileId;
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");

}
//档案阶段查看BS作业的工作底稿
function readMenuScriptInArchives(menuscript_id,contextPath){
var url = contextPath+"/pages/operate/manu/manuscript_view.jsp?manuscript_id="+menuscript_id+"&feedback_power=true&work_power=true&";
window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}

//只能看工作底稿   （修改  "feedback_power"和 "work_power" 参数的值均为 "true" zhangxl 2009-4-1 ）
function readMenuScriptMInArchives(menuscript_id,contextPath){
	var url = contextPath+"/operate/manu/viewAll.action?crudId="+menuscript_id;
    var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
 	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//只能看疑点
function readAudDoudt(doubt_id,contextPath){
	var url = contextPath + "/operate/doubt/view.action?type=YD&doubt_id=" + doubt_id;
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
function readDownFile(fileId,contextPath){
	var url = contextPath +"/commons/file/downloadFile.action?fileId="+fileId;
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//只能看日记 zhangxl  2009-3-9
function readDiaryMInArchives(diary_id,contextPath){
	var url = contextPath+"/operate/diary/view.action?diary_id="+diary_id;
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//只能看审计总结 zhangxl  2009-7-30
function readAudSummayMInArchives(summary_id,contextPath){
	var url = contextPath+"/pages/operate/summary/summary_view.jsp?id="+summary_id;
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//只能看证据
function readMenuScriptWInArchives(menuscript_id,work_power,contextPath){
var url = contextPath+"/pages/operate/manu/manuscript_view.jsp?manuscript_id="+menuscript_id+"&feedback_power=false&work_power=true&";
window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//只能看反馈意见
function readMenuScriptFInArchives(menuscript_id,feedback_power,contextPath){
	var url = contextPath+"/pages/operate/manu/manuscript_view.jsp?manuscript_id="+menuscript_id+"&feedback_power=true&work_power=false&";
	var openobj = window;
	if(typeof(window.dialogArguments) == "object")
	{
	    openobj =  window.dialogArguments;
	}
	openobj.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}
//all
function readMenuScriptALLInArchives(menuscript_id,work_power,feedback_power,contextPath){
var url = contextPath+"/pages/operate/manu/manuscript_view.jsp?manuscript_id="+menuscript_id+"&feedback_power=true&work_power=true&";
window.open(url,"","width=600,height=500,menubar=no,directories=no,status=no,location=no,scrollbars=yes,resizable=yes");
}

//added by yanan 2008-08-28
function pop_bpm_start_window(url,fun)
{
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	window.showModalDialog(url,fun,'dialogWidth:700px;dialogHeight:450px;status:yes');
}
function pop_bpm_submit_window(url,fun)
{
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	window.showModalDialog(url,fun,'dialogWidth:700px;dialogHeight:450px;status:yes');
}

/*
* 显示或隐藏项目基本信息
*/
function triggerProjectInfoDiv(){
	var evt = window.event;
	var eventSrc = evt.target || evt.srcElement;
	var proInfoDiv = document.getElementById('proInfoDiv');
	if(proInfoDiv.style.display=='none'){
		eventSrc.innerText="隐藏项目信息";
		proInfoDiv.style.display='';
	}else{
		eventSrc.innerText="展开项目信息";
		proInfoDiv.style.display='none';
	}
}
			
/*
*解决查询条件(easyui panel title)默认不显示的问题
*/
window.setTimeout(function(){
	
	(function($){
		var buttonDir = {north:'down',south:'up',east:'left',west:'right'};
		$.extend($.fn.layout.paneldefaults,{
			onBeforeCollapse:function(){
				var popts = $(this).panel('options');
				var dir = popts.region;
				var btnDir = buttonDir[dir];
				if(!btnDir) return false;
				
				setTimeout(function(){
					var pDiv = $('.layout-button-'+btnDir).closest('.layout-expand').css({
						textAlign:'center',lineHeight:'18px',fontWeight:'bold'
					});
					
					if(popts.title){
						var vTitle = popts.title;
						if(dir == "east" || dir == "west"){
							var vTitle = popts.title.split('').join('<br/>');
							//pDiv.find('.panel-body').html(vTitle);
						}else{
							$('.layout-button-'+btnDir).closest('.layout-expand').find('.panel-title')
							.css({textAlign:'left'})
							.html(vTitle)
						}
						
					}   
				},100);
				
			}
		});
	})(jQuery);	
},100);


	/*
	_showDlg(args,URLorHTML,parent)：创建并打开对话框
	args:easyUI的dialog参数
	URLorHTML:可以是一个url或html串
	parent：对话框的parent，默认是当前window
	返回值：自动创建的dialog的DIV id(带#)，可用于使用easyUI方法关闭及重新打开dialog
	*/
	function _showDlg(args,URLorHTML,parent){
		var dlg='_dlg'+Date.parse(new Date());
		if(!parent)parent=window;
		//if($(parent.document.body).find('#'+dlg).length==0)
		$(parent.document.body).append('<div id="'+dlg+'"></div>');
		dlg='#'+dlg;
		var odlg=$(parent.document.body).find(dlg);
		odlg.addClass("easyui-dialog");
		odlg.css("overflow","hidden");
		odlg.dialog(args);
		odlg.dialog({onClose:function(){$(this).dialog('destroy');}});
		if(URLorHTML.substr(0,7).toLowerCase()=="http://" || URLorHTML.substr(0,1).toLowerCase()=="/") {
			odlg.append('<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>');
			odlg.children()[0].src=URLorHTML;
		}else{
			odlg.append(URLorHTML);
		}
		odlg.dialog('open');
		return dlg;
	}
