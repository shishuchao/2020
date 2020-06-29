<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
   <%--  <s:text id="title" name="'编辑审计事项'"></s:text> --%>
 	  <%	
	    String s = (String)request.getParameter("edit");
	    %>
<html>

<head>
<title>准备阶段审计事项修改</title>
<style>
#showDiv {
	padding: 10px;
	position: absolute;
	background-color:#A1C7F9;
	width:300px;
	height:50px;
	bottom: 2px;
	left: 65%;
	margin-left: -300px;
	margin-bottom: 100px;
	z-index: 20001;
	display: none;
}

#shade {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	z-index: 20000;
	filter: Alpha(Opacity = 10);
	background-color: gray;
	display: none;
}
    
    
    </style>
 <script type="text/javascript" src="<%=basePath%>scripts/WebCalendar.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	
</head>
<script language="javascript">
$(function(){
	
	$("#myform").find("textarea").each(function(){
		autoTextarea(this);
	});
	if('${param.saveFlag}'=='1'){
		showMessage1("保存成功");
	}
	var flag = '<%=request.getAttribute("flag")%>';
	//缓存事项名称
	var taskName=document.getElementsByName("audTask.taskName")[0].value;
	document.getElementsByName("taskNamehidden")[0].value=taskName;
	if(flag != "1"){
		test(<%=s%>);
	}
	
});

function test(s){
  if(s==true){
  window.parent.parent.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
  }else{
	  
	}		  
}
	
function closeWindow(){
	//window.top.frames['f_left'].location.reload();
	var pid='<%=request.getParameter("taskPid")%>';
	var type='<%=request.getParameter("type")%>';
	var tab='proc';
	if(pid=='null'||pid==null){
	   pid='<%=request.getParameter("taskTemplateId")%>'
	}else{}	  		   
		  	
	 //alert(pid);
	 //&taskPid=90FA5FB1-3E5F-E67E-70AF-FEC64D7400C1&taskTemplateId=5B294137-3D96-494C-4812-618FD59DF3C8&project_id=62AC552B-1366-BBB4-8198-A4DF4F584884
	 //window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=main&taskTemplateId=null&audTemplateId=<%=request.getParameter("audTemplateId")%>";
	 if(tab=='proc'){
	   window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/task/showContentLeafEditList.action?selectedTab=proc&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=<%=request.getParameter("type")%>&taskTemplateId="+pid;
	 }else if(tab=='item'){
	   window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/task/showContentLeafEditList.action?selectedTab=proc&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=<%=request.getParameter("type")%>&taskTemplateId="+pid;
	  window.top.frames['childBasefrm'].basefrm2.location.href="${contextPath}/operate/task/showContentTypeEdit.action?selectedTab=item&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>&type=1&taskTemplateId="+pid;     
	 }else if(tab=='main'){
	  	  //  window.top.frames['childBasefrm'].location.href="${contextPath}/operate/task/showContentEdit.action?selectedTab=main&project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>";
	 }
	  	
	  //window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&type=<%=request.getParameter("type")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  //window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid+"&type"+type;
	  //window.top.frames['f_left'].location.reload();
	  //window.top.frames['childBasefrm'].location.reload();
	 window.close();
}

function check(){
 var v_3 = "audTask.taskName";  // field
 var title_3 = '事项名称';// field name
 var notNull = 'true'; // notnull
 var t=document.getElementsByName(v_3)[0].value;
 if(t.length>1200){
   top.$.messager.alert('提醒',"事项名称的长度不能大于1200字！",'error');
   document.getElementById(v_3).focus();
   return false;
  } 
	var v_3 = "audTask.taskTarget";  // field
	var title_3 = '所需资料';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>2000){
	  top.$.messager.alert('提醒',"所需资料的长度不能大于2000字！",'error');
	  document.getElementById(v_3).focus();
	  return false;
	} 
	 
	 var v_3 = "audTask.taskOther";  // field
	 var title_3 = '审计程序和方法';// field name
	 var notNull = 'true'; // notnull
	 var t=document.getElementsByName(v_3)[0].value;
	 if(t.length>2000){
		top.$.messager.alert('提醒',"审计程序和方法的长度不能大于2000字！",'error');
		document.getElementById(v_3).focus();
		return false;
	 } 
	 var v_3 = "audTask.taskMethod";  // field
	 var title_3 = '审计查证要点';// field name
	 var notNull = 'true'; // notnull
	 var t=document.getElementsByName(v_3)[0].value;
		if(t.length>5000){
		top.$.messager.alert('提醒',"审计查证要点的长度不能大于5000字！",'error');
		document.getElementById(v_3).focus();
		return false;
	 } 
		
		 var v_3 = "audTask.pointContent";  // field
		 var title_3 = '重点关注内容';// field name
		 var notNull = 'true'; // notnull
		 var t=document.getElementsByName(v_3)[0].value;
		 if(t.length>2000){
			top.$.messager.alert('提醒',"重点关注内容的长度不能大于2000字！",'error');
			document.getElementById(v_3).focus();
			return false;
		 } 
			 var v_3 = "audTask.law";  // field
			 var title_3 = '相关法律法规和监管规定';// field name
			 var notNull = 'true'; // notnull
			 var t=document.getElementsByName(v_3)[0].value;
			 if(t.length>2000){
				top.$.messager.alert('提醒',"相关法律法规和监管规定的长度不能大于2000字！",'error');
				document.getElementById(v_3).focus();
				return false;
		 	}	 
		return true;
	}
		
function generateLeaf(){
  var title="增加事项";
  window.paramw = "模态窗口";
  //window.open('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>');
  showPopWin('${contextPath}/operate/task/addLeaf.action?type=2&taskTemplateId=<%=request.getParameter("taskTemplateId")%>&project_id=<%=request.getParameter("project_id")%>',720,600,title);
  var num=Math.random();
  var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     
  //type=2&taskTemplateId=43917C5D-4745-7041-BD03-56243A457B3C&project_id=62AC552B-1366-BBB4-8198-A4DF4F584884
  //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
  //document.getElementsByName("newDoubt_type")[0].value=s;
  //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
  //myform.submit();
	                    
}

function onlyNumbers1(s){
 re = /^\d+\d*$/
 var str=s.replace(/\s+$|^\s+/g,"");
 if(str==""){
 return false;
 }
 if(!re.test(str))
 {
  top.$.messager.alert('提醒',"只能输入正整数,请重新输入",'error');
  return true ;   
 }
}
//模板生成----------保存表单
function saveFormLeaf(){
	//调用上层change方法
	parent.change();
	var fromAdjust='<%=request.getParameter("fromAdjust")%>';
	if('yes'==fromAdjust){
		if(!checkManu()){
			return false;
		} 
	}
	var flag = "";
	var taskName=document.getElementsByName("audTask.taskName")[0].value;
	var hiddenName=document.getElementsByName("taskNamehidden")[0].value;
	if(taskName==hiddenName){
		flag = "1";
	}
//top.$.messager.alert('提醒',"111",'error');
<%--
var taskStart = document.getElementById("taskStart").value;
var taskEnd = document.getElementById("taskEnd").value;
var myregex = new RegExp("\\d{4}-\\d{2}-\\d{2}");
if(taskStart != "" || taskEnd != ""){
	if(!(taskStart.match(myregex))){
   		top.$.messager.alert('提醒',"事项开始时间不符合\"yyyy-MM-dd\"格式,请重新填写或者选择！",'error');
   		return;
	}
	if(!(taskEnd.match(myregex))){
   		top.$.messager.alert('提醒',"事项结束时间不符合\"yyyy-MM-dd\"格式,请重新填写或者选择！",'error');
   		return;
	}
}
--%>
var accatcedTemp = document.getElementsByName("accatcedTemp");
var tempsArray = new Array;
for(var i = 0;i<accatcedTemp.length;i++){
    tempsArray.push(accatcedTemp[i].value);
}
var taskOrder = document.getElementsByName("audTask.taskOrder")[0].value;
if(onlyNumbers1(taskOrder)){
	  ocument.getElementsByName("audTask.taskOrder").focus();
	return false;
	}	 

var v_3 = "audTask.taskName";  // field
var title_3 = '事项名称';// field name
var notNull = 'true'; // notnull
if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	top.$.messager.alert('提醒', title_3+"不能为空!",'error');
	bool = false;
	document.getElementById(v_3).focus();
	return false;
}
if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
    top.$.messager.alert('提醒',title_3+"不能为空!",'error');
	bool = false;
	document.getElementById(v_3).focus();
	return false;
}

	var a = $('#taskStartTime').val();
	var b = $('#taskEndTime').val();
	if(a>b){
		top.$.messager.alert('提醒','[结束日期]应大于等于[开始日期]','error');
		$('#taskStartTime').val('').focus();
		return false;
	}
	
<%--
var v_2 =  "audTask.taskOrder"

var title_2 = '事项序号';// field name
var notNull = 'true'; // notnull
if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != ""){
		top.$.messager.alert('提醒',title_2+"不能为空!",'error');
		bool = false;
		document.getElementById(v_2).focus();
		return false;
}
if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
        top.$.messager.alert('提醒',title_2+"不能为空!",'error');
		bool = false;
		document.getElementById(v_2).focus();
		return false;
}

var s = document.getElementsByName(v_2)[0].value;
if(onlyNumbers1(s)){
 document.getElementById(v_2).focus();
return false;
}
--%>
if(!check()){
 return false;
}
var url = "${contextPath}/operate/task/saveLeafDetail.action?fromAdjust="+fromAdjust+"&tempsArray="+tempsArray+"&taskPid=<%=request.getParameter("taskPid")%>&flag="+flag+"";
myform.action = url;
	myform.submit();
}
	
function onlyNumbers1(s)
{
	 re = /^\d+\d*$/
	 var str=s.replace(/\s+$|^\s+/g,"");
	 if(str==""){
	 return false;
	 }
	 if(!re.test(str))
	 {
	top.$.messager.alert('提醒','事项序号只能输入正整数,请重新输入!','error');
	  return true ;   
	 }
}
//生成
function generate(s){
	d_id=document.getElementsByName("doubt_id")[0].value;
	n_type=s;
	d_type=document.getElementsByName("type")[0].value;
	window.paramw = "模态窗口";
    window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?doubt_id='+d_id+'&&newDoubt_type='+n_type+'&&type='+d_type, window, 'dialogWidth:700px;dialogHeight:450px;status:yes');
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	//window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	//document.getElementsByName("newDoubt_type")[0].value=s;
    //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	//myform.submit();
	                    
} 
	 
//删除
function deleteRecord2(){
	if(confirm("确认删除这条记录?")){
        myform.action = "${contextPath}/operate/task/deleteLeaf.action";
        myform.submit();
        window.top.location.href='${contextPath}/operate/task/mainReadyEdit.action?project_id=<%=request.getParameter("project_id")%>';
	}	                    
} 
	
function checkManu(){
	var resullt=''; 
	var s='${project_id}';
	var taskPid='${audTask.taskPid}';
	var taskId='${audTask.taskTemplateId}';
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'checkManu', executeResult:'false' }, 
		{'project_id':s,'taskPid':taskPid,'taskId':taskId},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	if(result=='10'){
	   top.$.messager.alert('提醒',"请先删除该审计事项下的审计底稿！",'error');
	   return false;
	}else if(result=='01'){
	   top.$.messager.alert('提醒',"请先删除该审计事项下的审计疑点！",'error');
	      return false;
	  }else if(result=='11'){
	    top.$.messager.alert('提醒',"请先删除该审计事项下的审计底稿和审计疑点！",'error')
	      return false;
	  }else{
	      return true;
	  }
	  
	}
		
		
function checkDoubt(){
var resullt=''; 
var s='${project_id}';
var taskPid='${audTask.taskPid}';
var taskId='${audTask.taskTemplateId}';
	DWREngine.setAsync(false);
	DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'doubtListByPid', executeResult:'false' }, 
		{'project_id':s,'taskPid':taskPid,'taskId':taskId},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
if(result=='1'){
	//top.$.messager.alert('提醒',"请先删除该审计事项下的疑点！",'error');
	return false;
}else{
	return true;
}	  
}
		 
//删除
function deleteRecord(){	
	if(!checkManu()){
		//top.$.messager.alert('提醒',"请先删除该审计事项下的审计底稿和审计疑点！",'error')
		return false;
	} 
	
    top.$.messager.confirm('提醒',	"确认删除这条记录?", function(r){
        if(r){
            myform.action = "${contextPath}/operate/task/deleteLeaf.action";
            myform.submit();
            //window.parent.parent.frames['f_left'].location.reload();
            window.parent.parent.location.reload();
        }
    });
        
/*        
	if(confirm("确认删除这条记录?")){
		myform.action = "${contextPath}/operate/task/deleteLeaf.action";
	    myform.submit();
	}                    
   window.parent.parent.frames['f_left'].location.reload();
*/
} 

function exe(){
 if(confirm("是否设置为已处理状态?")) {
	document.getElementsByName("audTemplate.doubt_status")[0].value="050"
	//audTemplate.doubt_status
	saveForm();
 }else{} 
}
	
function law(){
   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
}
	
function regu(){
    win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
}
             
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&project_id=${project_id}";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
//top.$.messager.alert('提醒',"111",'error');
var url = "${contextPath}/operate/doubt/save.action";
myform.action = url;
	myform.submit();
	
	 
}

function saveForm1(){
var bool = true;//提交表单判断参数
//非空校验
 	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	top.$.messager.alert('提醒',title_3+"不能为空!",'error');
	bool = false;
	return false;
}

var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
		top.$.messager.alert('提醒',title_3+"不能为空!",'error');
		bool = false;
		return false;
}

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
	top.$.messager.alert('提醒',title_3+"不能为空!",'error');
	bool = false;
	return false;
}

//保存表单
if(bool){
  var flag=window.confirm('确认操作吗?');//isSubmit
  if(flag==true){
  var url = "${contextPath}/mng/doubt/save.action";
  myform.action = url;
  myform.submit();
  }else{
     return false;
   }
 }
}
				
//上传附件
function Upload(id,filelist,delete_flag,edit_flag){
	var guid=document.getElementById(id).value;
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+guid+'&param='+rnm+'&deletePermission='+delete_flag+'&isEdit='+edit_flag,filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
}

</script>
<script>
var XMLHttpReq=false;
//创建一个XMLHttpRequest对象
function createXMLHttpRequest(){
 	if(window.XMLHttpRequest){ //Mozilla 浏览器
 		XMLHttpReq=new XMLHttpRequest();
 	}else if(window.ActiveXObject){ //微软IE 浏览器
 	  try{
 		XMLHttpReq=new ActiveXObject("Msxml2.XMLHTTP");//IE 6.0及6.0以上版本
 	  }catch(e){
 			try{
 				XMLHttpReq=new ActiveXObject("Microsoft.XMLHTTP");
				//IE 5.0版本
 			}catch(e){}
 	  }
 	}
}
 		
var layerName="";//指定删除之后回显的DIV标签对的id属性
//发送请求函数
function send(url,guid){
 	createXMLHttpRequest();
 	XMLHttpReq.open("GET",url,true);
 			
 	this.layerName=document.getElementById(guid).parentElement.id;
 			
 	XMLHttpReq.onreadystatechange=proce;//指定响应的函数
 	XMLHttpReq.send(null);  //发送请求
}

function proce(layerName){
 	if(XMLHttpReq.readyState==4){ //对象状态
 		if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
 			var resText = XMLHttpReq.responseText;
 			document.getElementById(this.layerName).innerHTML=resText;
 			window.top.$.messager.alert('提醒',"删除成功",'error');
 		}else{
 			window.top.$.messager.alert('提醒',"所请求的页面有异常",'error');
 		}
 	}
}
 		
//删除方法
/*
 	1.第一个参数是附件表的主键ID，第二个参数是该类附件的删除权限，第三个参数是附件的应用类型
 	2.该方法的参数由ais.file.service.imp.FileServiceImpl中的
 	getDownloadListString(String contextPath, String guid,String bool, String appType)生成的HTML产生
*/
function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
  var boolFlag=window.confirm("确认删除吗?");
  if(boolFlag==true){
	DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},xxx);
	function xxx(data){
		 document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
	 } 
   }
}
</script>
	
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		
		<s:if test="'enabled' == '${shenjichengxu}'">
         <title><s:property value="#title" />
 
        </s:if>
		
		</title>
		<s:head />
	</head>
	<body class='easyui-layout' border="0" style="padding:0px;margin:0px;overflow:hidden;">
	  <div region="north" id='pnorth' border="0" style="overflow:hidden;text-align:right; height:35px; ">
	      <div class="EditHead" style="padding-top:4px;overflow:hidden;">
			<s:if test="${teamAuth=='1'}">
				<a  onclick="deleteRecord();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-delete'">删除</a>
				<a  onclick="saveFormLeaf();" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
			</s:if>
		  </div>
	  </div>
	  <div region="center" id='pcenter' border="0" style="overflow:auto; ">

		<s:if test="'enabled' == '${shenjichengxu}'">
            <table class="ListTable">
				<tr>
					<td colspan="5" align="left" class="editTd">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
         </s:if>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/task" method="post" >
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							<font color="red">*</font>&nbsp;事项名称
						</td>
						<td  class="editTd" colspan="3">
							<%-- <s:textarea id="taskName" cssClass="noborder" name="audTask.taskName"
								cssStyle="width:100%;height:60;"/> --%>
								<input id="taskName" name="audTask.taskName" value="${audTask.taskName}" type='text'  class='noborder' style="width:100%;height:27px;"/>
								<s:hidden name="taskNamehidden"></s:hidden>
						</td>
						 
					</tr>
                     <s:hidden name="audTask.taskTemplateId" />
                     <s:hidden name="audTask.taskPid" />
                     <s:hidden name="audTemplateId" />
                     <s:hidden name="taskTemplateId" />
                     <s:hidden name="audTask.templateId" />
                      <s:hidden name="audTask.id" />
                      <s:hidden name="audTask.project_id" />
                      <s:hidden name="audTask.taskAssignName" />
                       <s:hidden name="audTask.taskAssign" />
					<tr style='display:none;'>
						<td class="EditHead">
						<font color="red">*</font>&nbsp;&nbsp;事项序号
						</td>
						<td class="editTd">
 					       <s:textfield cssClass="noborder" name="audTask.taskOrder" maxlength="5" />
						</td>						
						<td class="EditHead">事项编码
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audTask.taskCode" readonly="true" maxlength="20"  cssStyle='border-width:0px;'/>
						</td>					
					</tr>
<%-- 					<tr>
						<td class="EditHead">
							<font color="red"></font>&nbsp;&nbsp;执行人														
						</td>
						<td class="editTd" colspan="3">
							<input id='audTask_taskAssignName' name='audTask.taskAssignName' value="${audTask.taskAssignName}" type='text' class='noborder'/>
							<input id='audTask_taskAssign' 	   name='audTask.taskAssign'     value="${audTask.taskAssign}"  type='hidden'/>
							<img  style="cursor:pointer;border:0;vertical-align:middle;"
						        src="/ais/resources/images/s_search.gif" 
						    	onclick="showSysTree(this,{
				                                  title:'请选择执行人',
				                                  treeTabTitle1:'小组成员',
										          queryBox:false,
										          checkbox:true,
										          noMsg:true,
										          allleaf:true,
												  param:{
												  	isOracle:false,
												  	serverCache:false,
												  	'rootParentId': 'notnull',
												  	'whereHql':'proInfo.formId=\'${project_id}\'',
								                    'beanName':'ProMember',
								                    'treeId'  :'userId',
								                    'treeText':'userName',
								                    'treeParentId':'role',
								                    'treeOrder':'role',
					                                'customRoot':'项目小组成员'
								                  }
												})"></img>					 						
						</td>
					</tr>  --%>
					<tr>
							<td class="EditHead" style="width: 130px">
								&nbsp;&nbsp;&nbsp;事项开始时间
							</td>
							<td class="editTd">
							<input type="text"  id="taskStartTime" name="audTask.taskStartTime" class="easyui-datebox" style="width: 150px"
								value="${audTask.taskStartTime}" editable="false"/>
							</td>
							<td class="EditHead" style="width: 130px">
								&nbsp;&nbsp;&nbsp;事项结束时间
							</td>
							<td class="editTd">
							<input type="text"  id="taskEndTime" name="audTask.taskEndTime" class="easyui-datebox" style="width: 150px"
									value="${audTask.taskEndTime}" editable="false"/>
							</td>
						</tr>
						
					 <s:if test="'enabled' == '${shenjichengxu}'">	
                  <tr >
						<td class="EditHead">
                                    是否必做
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="3">
						<s:if test="${audTask.taskMust=='1'}">
							 <input type="radio" value="1" name="audTask.taskMust" checked="checked" >是&nbsp;<input type="radio" value="0" name="audTask.taskMust">否
                        </s:if><s:else> 
                         <input type="radio" value="1" name="audTask.taskMust" checked="checked" >是&nbsp;<input type="radio" value="0" name="audTask.taskMust" checked="checked">否
						</s:else> 
						</td>
					</tr>
                   
                    </s:if>
                   
					<tr>
						<td class="EditHead">
							审计程序和方法
							<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTask.taskOther"
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
								<input type="hidden" id="audTask.taskOther.maxlength" value="2000">
						</td>
					</tr>
				    <tr>
						<td class="EditHead" nowrap>
							相关法律法规和监管规定
							<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTask.law"
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
								<input type="hidden" id="audTask.law.maxlength" value="2000">
						</td>
					</tr> 
					<tr>
						<td class="EditHead">
							所需资料
							<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTask.taskTarget" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
								<input type="hidden" id="audTask.taskMethod.maxlength" value="2000">
						</td>
					</tr>
				    <tr>
						<td class="EditHead">
							审计查证要点
							<br/><div style="text-align:right"><font color=DarkGray>(限5000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTask.taskMethod" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
								<input type="hidden" id="audTask.taskMethod.maxlength" value="5000">

						</td>
					</tr>
					<tr>
						<td class="EditHead">
							重点关注内容
							<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
						</td>
						<td class="editTd" colspan=3>
							<s:textarea cssClass="noborder" name="audTask.pointContent" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
								<input type="hidden" id="audTask.pointContent.maxlength" value="2000">
						</td>
					</tr>
					 <s:if test="${fromAdjust=='yes'}">
					<tr>
						<td class="EditHead">
							调整说明
							<br/><div style="text-align:right"></div>
						</td>
						<td class="editTd" colspan=3>
							<s:textarea cssClass="noborder" name="audTask.taskFile" 
								cssStyle="width:100%;height:80px;overflow-y:hidden;" />
						</td>
					</tr>
					</s:if>
				</table>
                <s:hidden name="audTask.template_type"/>
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="audTask.haveLevel" />
				<s:hidden name="doubt_id" />
				<s:hidden name="audTask.taskProgress" />
				<s:hidden name="audTask.taskPcode" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
                <s:hidden name="path" />
                <s:hidden name="node" />
			</s:form>
		</div>
	</body>
<div id="shade">
   
</div>	
<div id="showDiv">
        <tr>请选择需要上传的模板<span  style="width:135px">&nbsp;</span><a onclick="closeShade()" style="cursor: pointer;">关闭</a></tr>
        <tr>
           <form action="<%=basePath%>attached/uploadfile/attacheduploadfile!prepareUpload.action" method="post" enctype="multipart/form-data" id="attachedForm">
                <input type="file" name="file" id="uploadFile">&nbsp;&nbsp;&nbsp;<button type="button" onclick="doAttachedUpload()">提交</button>
                <input type="hidden" name="type" value="<s:property value="type"/>" >
                <input type="hidden" name="path" value="<s:property value="path"/>" >
                <input type="hidden" name="node" value="<s:property value="node"/>" >
                <input type="hidden" name="selectedTab" value="item" >
                <input type="hidden" name="taskPid" value="<s:property value="audTask.taskPid"/>" >
                <input type="hidden" name="taskTemplateId" value="<s:property value="audTask.taskTemplateId"/>" >
                <input type="hidden" name="project_id" value="<s:property value="project_id"/>" >
                <input type="hidden" name="allTempates" id="allTempates">
           </form>
        </tr>
</div>
<script type="text/javascript">
//isUp为“1”是表示上传附件后返回的附表数据需要重新保存一下，如果为“0”则表示是从aud_task_template表中获取数据无需再次保存，但是需要刷新左边的树
var isUp = '<s:property value="#session.isTaskUp"/>';
if(1 == isUp){
  saveFormLeaf();//如果是模板数据是通过上传文件返回的，则提交保存用来更新一下审计事项模板表里的附表模板字段
}else{
  //window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
}

//提交上传附件模板
function doAttachedUpload(){
   var uploadFile = jQuery("#uploadFile").val();
    if("" == uploadFile){
      top.$.messager.alert('提醒',"上传文件不能为空！",'error');
      return;
    }
   var fileType = uploadFile.substring(uploadFile.lastIndexOf(".")+1); //判断上传文件后缀是否是excel格式
   if("xls" != fileType){
      top.$.messager.alert('提醒',"请上传后缀为\".xls\"格式的excel模板！",'error');
      return;
   }

   var accatcedTemp = document.getElementsByName("accatcedTemp");
   var tempsArray = new Array;
   for(var i = 0;i<accatcedTemp.length;i++){
      tempsArray.push(accatcedTemp[i].value);
    }
   jQuery("#allTempates").val(tempsArray);
   jQuery("#attachedForm").submit();
}

//删除附件模板
function delAttached(attachedid){
  jQuery.ajax({
    type: "POST",
    url: "<%=basePath%>attached/file/attachedfile!delTaskTemplate.action",
    data: {"templateid":attachedid},
    success: function(msg){
     if( 1 == msg){
       jQuery("#"+attachedid).remove();
       saveFormLeaf();//删除后重新保存一下更新审计事项模板表里的附表模板字段
     }
   }
});
}

function editAttached(attachedid,attachedname,type){
    window.open("<%=basePath%>attached/file/attachedfile!audPrepareTemplate.action?recordId='+attachedid+'&filename='+encodeURI(encodeURI(attachedname))+'&type="+type,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
}

//显示上传div
function showShade(){
    document.getElementById("showDiv").style.display = "block";
    document.getElementById("shade").style.display = "block";
}

//关闭上传div
function closeShade(){
	 document.getElementById("showDiv").style.display = "none";
    document.getElementById("shade").style.display = "none";
}
</script>
</html>
