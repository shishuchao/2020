<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<s:head />
	</head>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<!-- 引入dwr的js文件 -->
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<s:if test="${audTaskTemplate.taskTemplateId==null}">
	<s:text id="title" name="'增加审计程序'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'编辑审计程序'"></s:text>
</s:else>


<html>
	<script language="javascript">  
	jQuery(document).ready(function(){
		jQuery('#taskOther').attr('maxlength',2000);	
		jQuery('#taskName').attr('maxlength',500);	
		jQuery('#pointContent').attr('maxlength',2000);	
		jQuery('#taskTarget').attr('maxlength',2000);	
		jQuery('#law').attr('maxlength',2000);	
		jQuery('#taskMethod').attr('maxlength',2000);
		jQuery("#myform").find("textarea").each(function(){
			autoTextarea(this);
		});
	});
	function closeWindow(){
		
		//window.top.frames['f_left'].location.reload();
		//window.top.frames['childBasefrm'].location.reload();
		//window.top.frames['f_left'].location.href='${contextPath}/operate/template/showTreeList.action?node=${node}&audTemplateId=<%=request.getParameter("audTemplateId")%>';
		//window.close();
		parent.$('#addLeaf_div').window('close');
	
	}
	function closeWindow11(){
	  	//window.top.frames['f_left'].location.reload();
	  	//
	  	var pid='<%=request.getParameter("pid")%>';
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
	  	window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	}else if(tab=='item'){
	  	window.top.frames['childBasefrm'].basefrm3.location.href="${contextPath}/operate/template/showContentLeafList.action?selectedTab=proc&type=2&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
	  	window.top.frames['childBasefrm'].basefrm2.location.href="${contextPath}/operate/template/showContentType.action?selectedTab=item&type=1&taskPid=<%=request.getParameter("taskPid")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>&taskTemplateId="+pid;
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
      function deleteRecord()
		  {
		  	if(confirm("确认删除这条记录?")){
				myform.action = "${contextPath}/operate/doubt/delete.action";
	            myform.submit();
	      }
	                    
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
	
	function addLeaf(){
	   //win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu');if(win && win.open && !win.closed) win.focus();
	   window.showModalDialog('${contextPath}/operate/item/query.action', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
	   //window.open('${contextPath}/operate/item/list.action','regu123');
	}
	
	function addValue(name,cname,code,ct,cf,cm,co){
	document.getElementsByName("audTaskTemplate.taskName")[0].value=name;
	document.getElementsByName("audTaskTemplate.cat_name")[0].value=cname;
	document.getElementsByName("audTaskTemplate.cat_code")[0].value=code;
	document.getElementsByName("audTaskTemplate.taskTarget")[0].value=ct;
	document.getElementsByName("audTaskTemplate.taskFile")[0].value=cf;
	document.getElementsByName("audTaskTemplate.taskMethod")[0].value=cm;
	document.getElementsByName("audTaskTemplate.taskOther")[0].value=co;
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
  showMessage1("程序序号只能输入正整数,请重新输入!");
  return true ;   
 }
}

function check(){

	var v_3 = "audTaskTemplate.taskName";  // field
	var title_3 = '程序名称';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>100){
	showMessage1("程序名称的长度不能大于100字！");
	document.getElementById(v_3).focus();
	return false;
	} 
	var v_3 = "audTaskTemplate.taskOther";  // field
	var title_3 = '审计程序和方法';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	/* if(t.length>2000){
	showMessage1("审计程序和方法的长度不能大于2000字！");
	document.getElementById(v_3).focus();
	return false;
	} 
	 */
	var v_3 = "audTaskTemplate.law";  // field
	var title_3 = '相关法律法规和监管规定';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	/* if(t.length>2000){
	showMessage1("相关法律法规和监管规定的长度不能大于2000字！");
	document.getElementById(v_3).focus();
	return false;
	}  */
	
	var v_3 = "audTaskTemplate.taskMethod";  // field
	var title_3 = '审计查证要点';// field name
	var notNull = 'true'; // notnull
	var t=document.getElementsByName(v_3)[0].value;
	if(t.length>2000){
	showMessage1("审计查证要点的长度不能大于5000字！");
	document.getElementById(v_3).focus();
	return false;
	} 
	 
	return true;
}

//模板生成----------保存表单
function saveFormLeaf(){
//showMessage1("111");
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


	var s = document.getElementsByName(v_2)[0].value;
	if(onlyNumbers1(s)){
		 document.getElementById(v_2).focus();
		return false;
	}
	if(!check()){
		return false; 
	}


	var tab='<%=request.getParameter("tab")%>';
	var url = "${contextPath}/operate/template/saveLeaf.action?tab="+tab+"&addleaf=true";
	
	$.ajax({
		type:"post",
		data:$('#myform').serialize(),
		url:"${contextPath}/operate/template/saveLeaf.action?tab="+tab+"&addleaf=trues",
		async:false,
		success:function(){
			closeWindow();
	    	showMessage1('保存成功！');
	    	parent.parent.parent.reloadChildTreeNode();
		}
	});
	//document.getElementsByName("root")[0].disabled=true;
	//document.getElementsByName("root2")[0].disabled=true;
	//myform.action = url;
	//myform.submit();
	//var parentNode = '<%=request.getParameter("taskTemplateId")%>';
	//parent.parent.reloadChildTree();
	//parent.parent.$('#auditPlanTree').tree('reload',parentNode.target);
	//alert('${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>');
	//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
	//window.parent.frames['treeIframe'].location.href='${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
	//alert(window.top.frames['f_left']);
	 
}

//模板生成----------保存表单
function saveFormLeafAgain(){
//alert("111");
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
	var s = document.getElementsByName(v_2)[0].value;
	if(onlyNumbers1(s)){
		document.getElementById(v_2).focus();
		return false;
	}
	if(!check()){
		return false; 
	}
	var tab='<%=request.getParameter("tab")%>';
	//var url = "${contextPath}/operate/template/saveLeafAgain.action?tab="+tab+"&addleaf=true";
	$.ajax({
		type:"post",
		data:$('#myform').serialize(),
		url:"${contextPath}/operate/template/saveLeafAgain.action?tab="+tab+"&addleaf=true",
		async:false,
		success:function(){
	    	showMessage1('保存成功！');
	    	parent.generateLeaf2();
	    	parent.parent.parent.reloadChildTreeNode();
		}
	});
	//document.getElementsByName("root")[0].disabled=true;
	//document.getElementsByName("root2")[0].disabled=true;
	//myform.action = url;
	//myform.submit();
	//alert('${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>');
	//parent.location.href='${contextPath}/operate/template/main.action?audTemplateId='+<%=request.getParameter("audTemplateId")%>;
	//window.parent.frames['treeIframe'].location.href='${contextPath}/operate/template/showTreeList.action?audTemplateId=<%=request.getParameter("audTemplateId")%>';
	//alert(window.top.frames['f_left']);
	 
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
	<body>
		<center class="easyui-layout"  style="overflow:auto;">

			<div id="aa">
			<s:form id="myform" name="myform" onsubmit="return true;"
				action="/ais/operate/template" method="post">

				<table class="ListTable">
					<tr>
						<td class="EditHead" style="width: 20%">
							<font color="red">*</font>&nbsp;事项名称
						</td>
						<td class="editTd" colspan=3>
							<s:textarea name="audTaskTemplate.taskName" title="事项名称" id="taskName" cssClass="noborder"
								cssStyle="width:100%;overflow-y:hidden;" />
							<!--一般文本框-->
						</td>
					</tr>
					<s:hidden name="audTaskTemplate.taskTemplateId" />
					<s:hidden name="audTaskTemplate.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTaskTemplate.templateId" />
					<s:hidden name="audTaskTemplate.template_type" value="2" />
					<tr style='display:none;'>
						<td class="EditHead" >
							<font color="red">*</font> &nbsp;事项序号
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="4">
							<s:textfield name="audTaskTemplate.taskOrder" cssClass="noborder" maxlength="3"
								cssStyle='width:150px;' />
							<!--一般文本框-->
						</td>
					</tr>
					<tr style='display:none;'>
						<td class="EditHead">
							事项编码
						</td>
						<!--标题栏-->
						<td class="editTd" colspan="3">
							<s:property value="audTaskTemplate.taskCode" />
							<s:hidden name="audTaskTemplate.taskCode" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							审计程序和方法
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" id="taskOther" rows="3" name="audTaskTemplate.taskOther" cssStyle="width:100%;overflow-y:hidden;" title="审计程序和方法" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" nowrap>
							相关法律法规和监管规定
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" id="law" rows="3" name="audTaskTemplate.law" cssStyle="width:100%;overflow-y:hidden;" title="相关法律法规和监管规定" />
						</td>
					</tr>
					<tr>
						<td  class="EditHead">
							&nbsp;&nbsp;&nbsp;所需资料
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" name="audTaskTemplate.taskTarget" rows="3" title="所需资料" id="taskTarget" cssStyle="width:100%;overflow-y:hidden" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							审计查证要点
							<br/><div style="text-align:right"><font color=DarkGray>(限5000字)</font></div>
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" id="taskMethod" rows="3" name="audTaskTemplate.taskMethod" cssStyle="width:100%;overflow-y:hidden;" title="审计查证要点" />
							<%--<input type="hidden" id="audTask.pointContent.maxlength" value="2000">--%>
						</td>
					</tr> 
					 <tr>
						<td class="EditHead">
							重点关注内容
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" id="pointContent" rows="3" name="audTaskTemplate.pointContent" cssStyle="width:100%;overflow-y:hidden;" title="重点关注内容" />
							<%--<input type="hidden" id="audTask.pointContent.maxlength" value="2000">--%>
						</td>
					</tr> 
				</table>
				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTaskTemplate.taskPcode" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="pro_id" />
				<s:hidden name="path" />
				<s:hidden name="node" />
				<!-- <a class="easyui-linkbutton" data-options="iconCls:'icon-save'"
					onclick="saveFormLeaf()">保存</a> -->
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'"
					onclick="saveFormLeafAgain()">保存并增加</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					onclick="closeWindow();">关闭</a>
			</s:form>
			</div>
		</center>
	</body>
</html>
