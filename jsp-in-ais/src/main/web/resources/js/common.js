function getParameter(str)
{
   var tmp=str.split("?");
   var para_str=tmp[1];
   var array=new Array();
   
   if (para_str.indexOf("&")!=-1)
   {
     var para_array=para_str.split("&");
     
     for (var i=0;i<para_array.length;i++)
     {
        var res=para_array[i].split("=");
	array[i]=new Parameter(res[0],res[1]);     
	
     }
   }
   else
   {
      var res=para_str.split("=");
      array[0]=new Parameter(res[0],res[1]);  
   }
   return array;
}

function Parameter(name,value)
{
  this.name=name;
  this.value=value;
}
function trim(str){
	return str.replace(/(^\s*)|(\s*$)/g,"");
}

//加载页面时调含有下面class页面高度
function loadPage(){
	var h = $(window).height();
	var w = $(window).width();
	$('.pageContent').css({"height":h-32,"width":w});
}
//当缩小或者放大浏览器时，重新定义含有下面class的标签高度
function resizePage(){
	$(window).resize(function() {
	  	var h = $(window).height();
		var w = $(window).width();
		$('#toolbar').datagrid("resize",{width:'100%'})
		$('.pageContent').css({"height":h-32,"width":w});
	});
}
//生成窗口
function generateWin(div_id){
	$('#'+div_id).window({
		modal:true,
		title:"xxxx",
		collapsible: false,
		maximizable: true,
		minimizable: false,
		width:'800',
		shadow: false,
		closed: true
	});
	$('#'+div_id).css("overflow","hidden");
}

//调用此方法，将div加载成弹框，除查询弹框外，内容都可以加载为iframe
function showWin(div_id,title){
	var title = title == '' || title == null ? "查询条件" : title;
	var winContent = "<iframe src=\"\" style=\"width: 100%;height: 100%;overflow:hidden;border:0px;\"></iframe>";
	if (title.indexOf("查询条件") < 0) {
		$('#'+div_id).window({
			content:winContent
		});
	}
	$('#'+div_id).window({
		modal:true,
		title:title,
		href:'',
		collapsible: false,
		maximizable: true,
		minimizable: false,
		width:'800',
		shadow: true,
		closed: true,
		onResize:function(w,h){//重置查询窗口后，需要对内容宽度与高度重新定义
			var width = ($(window).width()-w)*0.5;
		    var height = ($(window).height()-h)*0.5;
		    $(".serch_foot").css("width",w-14.5);
		    $(".search_head").css("width",w-14.5).css("height",h-78);
		},
		onClose:function(){//触发关闭方法后，需要对内容清空
			$('#'+div_id).find('iframe:first').attr('src',"");
		}
	});
	$('#'+div_id).css("overflow","hidden");
}

//设置select高度，此方法不完善，谨慎使用
function setSelectH(div_id,num){
	var options = $("#"+div_id).children();
	var num = num == '' || num == null ? 7 : num;
	if (options.length > num) {
		$(this).parent().combobox({
			panelHeight : 200
		});
	} else {
		$(this).parent().combobox({
			panelHeight : 'auto'
		});
	}
}

//加载js时调用此方法，可对select中内容动态生成的下拉框设置高度，产生滚动条，需要在select标签中加入panelHeight='auto'属性，变为自适应
function loadSelectH(){
	$('select').each(function(index,obj){
		var options = $(obj).children();
		if (options.length > 7) {
			$(obj).combobox({
				panelHeight : 200
			});
		}
	});
}

//点击查询按钮，弹出查询弹框，只适用于查询
function searchWindShow(div_id,width,height){
	var w = width == "" || width == null ? 700 : width;
	var h = height == "" || height == null ? 250 : height;
	var width = ($(window).width()-w)*0.5;
    var height = ($(window).height()-h)*0.5;
    $(".serch_foot").css("width",w-14.5);
    $('#'+div_id).window({width:'800'});
    $('#'+div_id).window("open").window("resize",{width:w,height:h,left:width,top:height});
}

//将远程内容加载到window中，适用于静态页面
function allWindShow(div_id,url,width,height){
	var w = width == "" || width == null ? 700 : width;
	var h = height == "" || height == null ? 300 : height;
	var width = ($(window).width()-w)*0.5;
    var height = ($(window).height()-h)*0.5;
    $(".serch_foot").css("width",w-14.5);
    //设置标题属性
    //$('#'+div_id).window("setTitle","xxxx");
    $('#'+div_id).window("open").window("resize",{width:w,height:h,left:width,top:height}).window('refresh',url);
}

//将远程内容加载到window中，适用于动态页面
function showWinIf(div_id,url,title,width,height){
	var w = width == "" || width == null ? $(window).width()*0.9 : width;
	var h = height == "" || height == null ? $(window).height()*0.9 : height;
	var width = ($(window).width()-w)*0.5;
    var height = ($(window).height()-h)*0.5;
    //设置标题属性
	$('#'+div_id).window({cache:false});
    $('#'+div_id).window("setTitle",title);
    $('#'+div_id).find('iframe:first').attr('src',url);
    $('#'+div_id).window("open").window("resize",{width:w,height:h,left:width,top:height});
}

//打开窗口时，可让窗口居中于屏幕，宽高可随屏幕分辨率的大小调节
function openWin(div_id,title,width,height){
	var w = width == "" || width == null ? $(window).width()*0.9 : width;
	var h = height == "" || height == null ? $(window).height()*0.9 : height;
	var width = ($(window).width()-w)*0.5;
    var height = ($(window).height()-h)*0.5;
    //设置标题属性
    $('#'+div_id).window("setTitle",title);
    $('#'+div_id).window("open").window("resize",{width:w,height:h,left:width,top:height});
}

//关闭弹出窗口方法
function closeWin(win_id) {
	$("#"+win_id).window('close');
}
//刷新页面列表方法
function datagridReload(id){
	$('#'+id).datagrid('reload');
}

//弹出提示框
function showMessage1(msg,title,time,type){
	var title = title == '' || title == null ? "提示信息" : title
	top.$.messager.show({
		title:title,
		msg:msg,
		height:'auto',
		timeout:time == '' || time == null ? 4000 : time,
		showType:type == '' || type == null ? 'slide' : type
	});
}
//调用父页面弹出提示框
function showMessage2(msg,title,time,type){
	var title = title == '' || title == null ? "提示信息" : title
	top.$.messager.show({
		title:title,
		msg:msg,
		timeout:time == '' || time == null ? 4000 : time,
		showType:type == '' || type == null ? 'slide' : type
	});
}
//将日期类型转换为字符串
function getDate(str){
	var date = new Date(str);
	var year = date.getFullYear();
	var month = parseInt(date.getMonth())+1 ;
	var day = date.getDate() < 9 ? "0"+date.getDate() : date.getDate();
	if (str == '' || str == null) {
		return str;
	} else if (str == 'dateTime') {
		return year+"-"+(month > 9 ? month :"0"+month)+"-"+day;
	} else {
		return year+"-"+(month > 9 ? month :"0"+month)+"-"+day;
	}
}

//去除字符串两边的空格
String.prototype.trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
};

//<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="query()">查询</a>
//["查询,query,id-btnrule-"]
/**/
//生成操作后的button
function ganerateBtn(arr){
	try{
		var arrs = arr.split('-btnrule-');
		var btns = "";
		for (var i=0; i< arrs.length;i++) {
			var btnStr = arrs[i].split(',');
			var icon = "";
			var param = "";
			if (btnStr[0].indexOf("修改")>=0 || btnStr[0].indexOf("调整")>=0 || btnStr[0].indexOf("Edit")>=0|| btnStr[0].indexOf("处理")>=0|| btnStr[0].indexOf("填报")>=0 ) {
				icon = "icon-edit";
			} 
			//liululu
			else if (btnStr[0].indexOf("新增")>=0 || btnStr[0].indexOf("添加资料")>=0) {
				icon = "icon-add";
			}else if (btnStr[0].indexOf("删除")>=0) {
				icon = "icon-delete";
			} else if (btnStr[0].indexOf("查看")>=0) {
				icon = "icon-view";
			} else if (btnStr[0].indexOf("消除")>=0  || btnStr[0].indexOf("注销")>=0) {
				icon = "icon-cancel";
			} else if (btnStr[0].indexOf("恢复")>=0) {
				icon = "icon-recover"; 
			} else if (btnStr[0].indexOf("查询")>=0) {
				icon = "icon-search";
			}else if(btnStr[0].indexOf("启动")>=0) {
				icon = "icon-start";
			} else if (btnStr[0].indexOf("文件")>=0 || btnStr[0].indexOf("标签")>=0) {
				icon = "icon-file";
			}else if (btnStr[0].indexOf("资料管理")>=0) {
				icon = "icon-file";
			}else if (btnStr[0].indexOf("导出")>=0  || btnStr[0].indexOf("下载")>=0) {
				icon = "icon-export";
			}else if (btnStr[0].indexOf("设置")>=0 || btnStr[0].indexOf("设计字段")>=0) {
				icon = "icon-config";
			}else if (btnStr[0].indexOf("发布")>=0) {
				icon = "icon-publish";
			}else if (btnStr[0].indexOf("复制")>=0) {
				icon = "icon-copy";
			}else if (btnStr[0].indexOf("扩展选项")>=0) {
				icon = "icon-import";
			}else if (btnStr[0].indexOf("导入")>=0  || btnStr[0].indexOf("上传模板")>=0) {
				icon = "icon-import";
			}else if (btnStr[0].indexOf("装载")>=0) {
				icon = "icon-mini-refresh";
			}
			var params = [];
			for (var j = btnStr.length-1; j>1;j--){
				param += "'"+btnStr[j]+"',";
			}
			if (param != '' && param != null) {
				param = param.substring(0,param.length-1);
				param = param.split(',').reverse().join(',');
			}
			
			btns += "<a href=\"javascript:void(0)\" class=\"l-btn l-btn-small l-btn-plain\" onclick=\""+btnStr[1]+"("+param.trim()+");\">"
			+"<span class=\"l-btn-left l-btn-icon-left\">"
			+"<span class=\"l-btn-text\">"+btnStr[0]+"</span>"
			+"<span class=\"l-btn-icon "+icon+"\">&nbsp;</span>"
			+"</span>"
			+"</a>";
		}
		return btns;
		
	}catch(e){
		alert("ganerateBtn:\n"+e.message);
	}
}

//显示溢出文本内容
function getOverflowTextContent(value){
	if(value!= null && value!=''){
		if(value.length>20) 
			return '<span title='+value+'>'+value.substring(0,20)+"..."+'</span>';
		else 
			return '<span title='+value+'>'+value+'</span>';
	}
}
function validataForm(str){
	var objarr = $('#'+str).find('font');
	var fontLength = '</font>';
	var bol = true;
	for (var i= 0; i < objarr.length;i++) {
		var fontFlag = $(objarr[i]).html().trim();
		if (fontFlag == '*') {
			var element = $(objarr[i]).parent().next().find('input:first');
			var elementvalue = $(element).val().trim();
			var elementname = $(objarr[i]).parent().html().trim();
			var elementnamelength = elementname.indexOf(fontLength)+fontLength.length
			var elementname = elementname.substring(elementnamelength,elementname.length)
			if (elementvalue == '' || elementvalue == null) {
				bol = false;
				showMessage1(elementname+'不能为空！'+elementvalue);
				return;
			}
		}
	}
	return bol;
}

function getWindowW(num,tableW){
	
}
function getWindowH(num,tableW){
	
}

function helpView(){
	showWinIf('helpView',"",'温馨提示',500,300);
	$("#showInfo").text("");
	$("#showInfo").append($('div').data('tipCon'));
}

var helpBtn = {
	text:'提示',
	iconCls:'icon-tip',
	id:'tipBtn',
	handler:function () {
		tipMaintain();
	}
};

function tipMaintain() {
	var parentdiv=$('<div></div>');
	parentdiv.attr('id','helpView');
	var childText=$('<text></text>');
	childText.attr('id','showInfo');
	childText.appendTo(parentdiv);
	parentdiv.appendTo('body');
	helpView();
}

function initHelpBtn() {
	var url = window.location.href;
	url = url.substring(url.indexOf("/ais"));
	$.ajax({
		url:'/ais/project/prepare/getSystemHelp.action',
		type:'post',
		cache:false,
		async:false,
		data:{
			'url':url
		},
		success:function(data){
			if(data.msg != '' && data.msg != null) {
				$('div').data('tipCon',data.msg);
				$('#tipBtn').attr('title',data.msg);
			} else {
				$('#tipBtn').hide();
			}
		}
	});
}

//单元格tooltip提示
function doCellTipShow(div_id){
	$('#'+div_id).datagrid('doCellTip', {
		onlyShowInterrupt:true,
		position : 'bottom',
		maxWidth : '200px',
		tipStyler : {
			'backgroundColor' : '#EFF5FF',
			borderColor : '#95B8E7',
			boxShadow : '1px 1px 3px #292929'
		}

	});
}
/**
 * 输入框获取焦点是添加样式
 */
$(function () {

	$('input[type=text]').focus(function(){
		$(this).removeClass('noborder');
		$(this).addClass('hasborder');
	});
	$('input[type=text]').blur(function(){
		$(this).addClass('noborder');
		$(this).removeClass('hasborder');
	});
	$('textarea').focus(function(){
		$(this).removeClass('noborder');
		$(this).addClass('hasborder');
	});
	$('textarea').blur(function(){
		//$(this).addClass('noborder');
		$(this).removeClass('hasborder');
	});
	//不可编辑文本域,不显示光标
	$('input[type=text]').each(function(){
		if($(this).attr('readonly')=='readonly'){
			$(this).attr('unselectable','on');
		}
	});
	//不可编辑文本域,不显示光标
	$('textarea').each(function(){
		if($(this).attr('readonly')=='readonly'){
			$(this).attr('UNSELECTABLE','on');
		}
	});
});