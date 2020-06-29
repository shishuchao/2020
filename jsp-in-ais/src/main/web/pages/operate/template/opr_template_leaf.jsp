<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%-- <s:text id="title" name="'编辑审计事项'"></s:text> --%>
<html>
    <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
    <title>审计方案维护事项详细内容</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
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
<script language="javascript">
	$(document).ready(function(){
		$("#taskMethod").attr("maxlength",5000);
	});


	$(function (){
		$("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
	});
	function closeWindow(){
	  	//window.top.frames['f_left'].location.reload();
	  	//
	  	var pid='<%=request.getParameter("tid")%>';
	  	var type='<%=request.getParameter("type")%>';
	  	var tab='<%=request.getParameter("tab")%>';
	  	if(pid=='null'||pid==null){
	  	   pid='<%=request.getParameter("taskTemplateId")%>'
	  	}else{
	  	    
	  	}
	  	//alert("${contextPath}/operate/template/showContent.action?selectedTab=item&type=1&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid);
	  	///ais/operate/template/showContentType.action?selectedTab=item&type=1&taskTemplateId=01D2384E-CFE0-9204-F93C-070FEFDAD2BC&audTemplateId=C25943BC-110E-2727-CEF1-C996A6C17405
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=main&taskTemplateId=null&audTemplateId=<%=request.getParameter("audTemplateId")%>";
	  	//window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	if(tab=='proc'){
	  	window.parent.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}else if(tab=='item'){
	  	window.parent.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	window.parent.frames['childBasefrm'].basefrm2.location.href="${contextPath}/operate/template/showContentType.action?selectedTab=item&type=1&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	//    window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=item&type=1&taskPid="+pid+"&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}else if(tab=='main'){
	  	//    window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=main&type=0&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}
	  	
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&type=<%=request.getParameter("type")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	//window.top.frames['childBasefrm'].location.href="${contextPath}/operate/template/showContent.action?selectedTab=proc&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid+"&type"+type;
		//window.top.frames['f_left'].location.reload();
		//window.top.frames['childBasefrm'].location.reload();
		window.close();
	}
		function generateLeaf()
		  {
		     title="审计事项";
		     window.paramw = "模态窗口";
             //window.open('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>');
		     showPopWin('${contextPath}/operate/template/addLeaf.action?taskTemplateId=<%=request.getParameter("taskTemplateId")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>',720,600,title);
		     var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		     //window.showModalDialog('${contextPath}/operate/doubt/genDoubt.action?guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
		     //document.getElementsByName("newDoubt_type")[0].value=s;
             //myform.action = "${contextPath}/operate/doubt/genDoubt.action";
	         //myform.submit();
	                    
	} 
	 //生成
      function generate(s)
		  {
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
    function deleteRecord(){
		$.messager.confirm('提示信息','确认删除这条记录？',function(flag){
			if(flag){
				myform.action = "${contextPath}/operate/template/deleteType.action";
				$.ajax({
					type:"post",
					data:$('#myform').serialize(),
					url:"${contextPath}/operate/template/deleteType.action",
					async:false,
					success:function(){
				    	parent.parent.reloadChildTreeNode('delete');
				    	showMessage1('删除成功！');
					}
				});
			         //window.parent.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${audTaskTemplate.taskPid}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
			}
		});
	} 
	function exe(){
		if (confirm("是否设置为已处理状态?")) {
		document.getElementsByName("audTemplate.doubt_status")[0].value="050"
		//audTemplate.doubt_status
	         saveForm();
         }else{
	 
         } 
	}
	function law(){
	   window.open('${contextPath}/pages/assist/suport/comsys/view_lawslibFrame.jsp?zuoye=bs','law','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	}
	
	function regu(){
	   win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');if(win && win.open && !win.closed) win.focus();
	}
             
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&pro_id=${pro_id}";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
var url = "${contextPath}/operate/doubt/save.action";
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
  showMessage1("事项序号只能输入正整数,请重新输入!");
  return true ;   
 }
}

function check(){
	var v_3 = "audTaskTemplate.taskCode";  // field
	var title_3 = '事项编码';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>1000){
	showMessage1("事项编码的长度不能大于1000字！");
	document.getElementById(v_3).focus();
	return false;
	} 
	
	var v_3 = "audTaskTemplate.taskName";  // field
	var title_3 = '事项名称';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>1000){
	showMessage1("事项名称的长度不能大于1000字！");
	document.getElementById(v_3).focus();
	return false;
	} 

	var v_3 = "audTaskTemplate.taskOther";  // field
	var title_3 = '审计程序和方法';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>2000){
	showMessage1("审计程序和方法的长度不能大于2000字！");
	document.getElementById(v_3).focus();
	return false;
	} 

	var v_3 = "audTaskTemplate.law";  // field 
	var title_3 = '相关法律法规和监管规定';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>2000){
	showMessage1("相关法律法规和监管规定的长度不能大于2000字！");
	document.getElementById(v_3).focus();
	return false;
	} 

	var v_3 = "audTaskTemplate.taskMethod";  // field
	var title_3 = '审计查证要点';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>2000){
	showMessage1("审计查证要点的长度不能大于2000字！");
	document.getElementById(v_3).focus();
	return false;
	} 
	return true;
}

//模板生成----------保存表单
function saveFormLeaf(){
//alert("111");
	var accatcedTemp = document.getElementsByName("accatcedTemp");
	var tempsArray = new Array;
	for(var i = 0;i<accatcedTemp.length;i++){
	    tempsArray.push(accatcedTemp[i].value);
	}
	var v_3 = "audTaskTemplate.taskName";  // field
	var title_3 = '事项名称';// field name
	var notNull = 'true'; // notnull
	if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
			showMessage1(title_3+"不能为空!");
			 bool = false;
			document.getElementById(v_3).focus();
			return false;
	}
	if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
	        showMessage1(title_3+"不能为空!");
			bool = false;
			document.getElementById(v_3).focus();
			return false;
	}
	var v_2 =  "audTaskTemplate.taskOrder"
	var title_2 = '事项序号';// field name
	var notNull = 'true'; // notnull
	if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != ""){
			showMessage1(title_2+"不能为空!");
			bool = false;
			document.getElementById(v_2).focus();
			return false;
	}
	if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
	        showMessage1(title_2+"不能为空!");
			bool = false;
			document.getElementById(v_2).focus();
			return false;
	}
	var s = document.getElementById("taskOrderid").value;;
	if(onlyNumbers1(s)){
		document.getElementById("taskOrderid").focus();
	return false;
	}

	var url = "${contextPath}/operate/template/saveLeafDetail.action?tempsArray="+tempsArray+"&tid=<%=request.getParameter("tid")%>";
	myform.action = url;
	myform.submit();
	showMessage1('保存成功！');
	window.parent.frames['treeIframe'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
}


function saveForm1(){
var bool = true;//提交表单判断参数
//非空校验
 

	
 
	
 
	
var v_3 = "doubt.course_title";  // field
var title_3 = '课程名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         showMessage1(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         showMessage1(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         showMessage1(title_3+"不能为空!");
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
	function Upload(id,filelist,delete_flag,edit_flag)
		{
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
 					}
 					else if(window.ActiveXObject){ //微软IE 浏览器
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
 			};
 		function proce(layerName){
 			if(XMLHttpReq.readyState==4){ //对象状态
 				if(XMLHttpReq.status==200){//信息已成功返回，开始处理信息
 				var resText = XMLHttpReq.responseText;
 				document.getElementById(this.layerName).innerHTML=resText;
 				showMessage1("删除成功");
 				}else{
 					showMessage1("所请求的页面有异常");
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
		if(boolFlag==true)
		{
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
		{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
		xxx);
		function xxx(data){
		  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
		} 
		}
	}
</script>
	</head>
	<body class="easyui-layout"  style="overflow:auto;">
		<center>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post">

				<table class="ListTable">

					<tr>
						<td style="width: 20%"  class="EditHead">
							<font color="red">*</font>&nbsp;事项名称
						</td>
						<td  colspan=" 3" class="editTd">
							<s:textarea cssClass="noborder" name="audTaskTemplate.taskName" cssStyle="width:100%;overflow-y:hidden;" />
						</td>
					</tr>
					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<tr style='display:none;'>
						<s:if test="'enabled' == '${shenjichengxu}'">
							<td class="EditHead">
							  <font color="red"></font>&nbsp;&nbsp;&nbsp;程序编码
							 </td>
							<td class="editTd" colspan="3">
								<s:property value="audTaskTemplate.taskCode" />
								<s:hidden name="audTaskTemplate.taskCode" />
							</td>							 
						</s:if>
						<s:else >
							<td class="EditHead" >
						      <font color="red"></font>&nbsp;&nbsp;&nbsp;事项编码
						    </td>
						    <td class="editTd" colspan="3">
						    	<s:if test="${audTaskTemplate.templateId == null}">
						    		 <s:textfield cssClass="noborder" name="audTaskTemplate.taskCode" maxlength="20" />
						    	</s:if>
						    	<s:else>
						    		<s:property value="audTaskTemplate.taskCode" />
						    	</s:else>
							</td>
						</s:else>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead">

							<font color="red">*</font> &nbsp;事项序号
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audTaskTemplate.taskOrder" id="taskOrderid" maxlength="3" cssStyle='width:150px;'/>
							<!--一般文本框-->

						</td>
					</tr>
					<tr>
						<td class="EditHead">
							审计程序和方法
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTaskTemplate.taskOther"
								cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr>
				    <tr>
						<td class="EditHead">
							相关法律法规和监管规定
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTaskTemplate.law"
								cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr> 
					<tr>
						<td  class="EditHead">
							&nbsp;&nbsp;&nbsp;所需资料
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTaskTemplate.taskTarget" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;" />
						</td>
					</tr>
				    <tr>
						<td class="EditHead">
							审计查证要点
							<div><font color=DarkGray>(限5000字)</font></div>
						</td>
						<td class="editTd" colspan="3">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea cssClass="noborder" id="taskMethod" name="audTaskTemplate.taskMethod" 
								cssStyle="width:100%;overflow-y:hidden;" />

						</td>
					</tr>
					<tr>
						<td class="EditHead">
							重点关注内容
						</td>
						<td class="editTd" colspan=3>
							<s:textarea cssClass="noborder" name="audTaskTemplate.pointContent" 
								cssStyle="width:100%;overflow-y:hidden;" />
						</td>
					</tr>
					
<%-- 
					<!--  <tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计关注点:
						</td>
						<td class="titletable1" colspan="3">
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="4">
							<s:textarea name="audTaskTemplate.taskFile" cssStyle="width:100%;height:70;" />
						</td>
					</tr>

					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计风险:
						</td>
						<td class="titletable1" colspan="3">
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="4">
							<s:textarea name="audTaskTemplate.taskOther" cssStyle="width:100%;height:70;" />
						</td>
					</tr>-->

					<tr>
						<td class="EditHead">
							&nbsp;&nbsp;&nbsp;审计程序:
						</td>
						<td class="titletable1" colspan="3">
						</td>
					</tr>
					<tr>
						<td class="editTd" colspan="4">
							<s:textarea name="audTaskTemplate.taskMethod" cssStyle="width:100%;height:160;" />
						</td>
					</tr>
					--%>
					<%--因上传附件用金格控件打开时无法显示,暂时关闭此功能 --%>
					<%-- <tr>
						<td colspan="4">
							<input type='button' onclick="showShade()" value='上传模板附表'/>
						</td>
					</tr>
					<tr>
						<td colspan="2"  style="width:50%;text-align:center;" class="EditHead" >
						      模板名称
						</td>
						<td colspan="2" class="EditHead" style="width:50%;text-align:center;" >
						     操作
						</td>
					</tr>
					<s:iterator value="#session.allTemplateList" id="alltemp">
					    <tr id="<s:property value="#alltemp.templateid"/>">
					      <td class="editTd" colspan="2"><input type="hidden" name="accatcedTemp" value="<s:property value="#alltemp.templateid"/>"/><s:property value="#alltemp.templatename"/></td>
					      <td class="editTd" colspan="2"><a href="javascript:editAttached('<s:property value="#alltemp.templateid"/>','<s:property value="#alltemp.templatename"/>','<s:property value="#alltemp.filetype"/>')">编辑</a>&nbsp;&nbsp;<a href="javascript:delAttached('<s:property value="#alltemp.templateid"/>')">删除</a></td>
					    </tr>
					</s:iterator> --%>
				</table>

				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTaskTemplate.template_type" value="2" />
				<s:hidden name="audTaskTemplate.taskPcode" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<input type="text" name="textfield2" style="display: none;" />
			</s:form>
			<div style="text-align:right;margin-top:10px;margin-bottom:40px;padding-right:18px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-delete'" onclick="deleteRecord();">删除</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeaf();">保存</a>
			</div>
		</center>
	</body>

<div id="shade">
   
</div>	
<div id="showDiv">
        <tr  >请选择需要上传的模板<span  style="width:135px">&nbsp;</span><a onclick="closeShade()" style="cursor: pointer;">关闭</a></tr>
        <tr>
           <form action="<%=basePath%>attached/uploadfile/attacheduploadfile!vindicateUpload.action" method="post" enctype="multipart/form-data" id="attachedForm">
                <input type="file" name="file" id="uploadFile">&nbsp;&nbsp;&nbsp;<input type="button" onclick="doAttachedUpload()" value='提交'/>
                <input type="hidden" name="type" value="<s:property value="type"/>" >
                <input type="hidden" name="path" value="<s:property value="path"/>" >
                <input type="hidden" name="node" value="<s:property value="node"/>" >
                <input type="hidden" name="selectedTab" value="item" >
                <input type="hidden" name="taskPid" value="<s:property value="audTaskTemplate.taskPid"/>" >
                <input type="hidden" name="taskTemplateId" value="<s:property value="audTaskTemplate.taskTemplateId"/>" >
                <input type="hidden" name="audTemplateId" value="<s:property value="audTaskTemplate.templateId"/>" >
                <input type="hidden" name="allTempates" id="allTempates">
           </form>
        </tr>
</div>
<script type="text/javascript">
//isUp为“1”是表示上传附件后返回的附表数据需要重新保存一下，如果为“0”则表示是从aud_task_template表中获取数据无需再次保存，但是需要刷新左边的树
var isUp = '<s:property value="#session.isUp"/>';
if(1 == isUp){
  saveFormLeaf();//如果是模板数据是通过上传文件返回的，则提交保存用来更新一下审计事项模板表里的附表模板字段
}else{
  <%-- window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${taskTemplateId}&audTemplateId=<%=request.getParameter("audTemplateId")%>'; --%>
}
//提交上传附件模板
function doAttachedUpload(){
   var uploadFile = jQuery("#uploadFile").val();
    if("" == uploadFile){
      showMessage1("上传文件不能为空！");
      return;
    }
   var fileType = uploadFile.substring(uploadFile.lastIndexOf(".")+1); //判断上传文件后缀是否是excel格式
   if("xls" != fileType){
      showMessage1("请上传后缀为\".xls\"格式的excel模板！");
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
 if(confirm("确定要删除当前模板么？")){
   jQuery.ajax({
   type: "POST",
   url: "<%=basePath%>attached/file/attachedfile!delTemplate.action",
   data: {"templateid":attachedid},
   success: function(msg){
     if( 1 == msg){
       jQuery("#"+attachedid).remove();
       saveFormLeaf();//删除后重新保存一下更新审计事项模板表里的附表模板字段
     }
   }
});
}
}

function editAttached(attachedid,attachedname,type){
    window.open("<%=basePath%>attached/file/attachedfile!audVindicateTemplate.action?recordId='+attachedid+'&filename='+encodeURI(encodeURI(attachedname))+'&type="+type,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
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
