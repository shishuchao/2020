<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<%@page import="ais.framework.util.MyProperty"%>

<s:text id="title" name="'增加审计事项'"></s:text>





<html>
	<script language="javascript">

	function check(){

		var v_3 = "audTask.taskName";  // field
		var title_3 = '程序名称';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>200){
		alert("程序名称的长度不能大于200字！");
		document.getElementById(v_3).focus();
		return false;
		} 

		var v_3 = "audTask.taskTarget";  // field
		var title_3 = '审计目的';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计目的的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 

		var v_3 = "audTask.taskMethod";  // field
		var title_3 = '审计程序内容';// field name
		var notNull = 'true'; // notnull
		var t=document.getElementsByName(v_3)[0].value;
		if(t.length>2000){
		alert("审计程序内容的长度不能大于2000字！");
		document.getElementById(v_3).focus();
		return false;
		} 
		 
		return true;
	}
		function closeWindow(){
	  	//window.top.frames['f_left'].location.reload();
	  	//
	  	 if('enabled' == '${shenjichengxu}'){
	  	var pid='<%=request.getParameter("pid")%>';
	  	var type='<%=request.getParameter("type")%>';
	  	var tab='<%=request.getParameter("tab")%>';
	  	if(pid=='null'||pid==null){
	  	   pid='<%=request.getParameter("taskTemplateId")%>'
	  	}else{
	  	    
	  	}
	  	
	   
	  	
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
		
		}else{
		  //window.top.frames['f_left'].location.reload();
		  window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
		window.top.frames['childBasefrm'].location.reload();
		}
		window.close();
		
		
	}
		function addValue(name,cname,code,ct,cf,cm,co){
	document.getElementsByName("audTask.taskName")[0].value=name;
	document.getElementsByName("audTask.cat_name")[0].value=cname;
	document.getElementsByName("audTask.cat_code")[0].value=code;
	document.getElementsByName("audTask.taskTarget")[0].value=ct;
	document.getElementsByName("audTask.taskFile")[0].value=cf;
	document.getElementsByName("audTask.taskMethod")[0].value=cm;
	document.getElementsByName("audTask.taskOther")[0].value=co;
	}
		function addLeaf(){
	   //win=window.open('${contextPath}/pages/operate/manu/law_redirect.jsp','regu');if(win && win.open && !win.closed) win.focus();
	   window.showModalDialog('${contextPath}/operate/item/query.action', window, 'dialogWidth:720px;dialogHeight:600px;status:yes');
	   //window.open('${contextPath}/operate/item/list.action','regu123');
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
  alert("只能输入正整数,请重新输入");
  return true ;   
 }
}
		//模板生成----------保存表单
function saveFormLeaf(){
//alert("111");


var v_3 = "audTask.taskName";  // field
var title_3 = '程序名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }





var v_2 =  "audTask.taskOrder"



var title_2 = '程序序号';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_2+"不能为空!");
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
document.getElementsByName("root")[0].disabled=true;
document.getElementsByName("root2")[0].disabled=true;
var tab='<%=request.getParameter("tab")%>';

var h='<%=request.getParameter("new")%>'
if(h=='old'){
var url = "${contextPath}/operate/task/saveLeaf.action?node=${node}&path=${path}&tab="+tab+"&addleaf=true";
myform.action = url;
myform.submit();
}else {
var url = "${contextPath}/operate/task/saveLeaf.action?node=${node}&path=${path}&new=true&tab="+tab+"&addleaf=true";
myform.action = url;
myform.submit();

}


window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
	 
	 
}

function saveFormLeafAgain(){
//alert("111");


var v_3 = "audTask.taskName";  // field
var title_3 = '程序名称';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_3+"不能为空!");
				         bool = false;
				         document.getElementById(v_3).focus();
				         return false;
                   }





var v_2 =  "audTask.taskOrder"



var title_2 = '程序序号';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_2+"不能为空!");
				         bool = false;
				         document.getElementById(v_2).focus();
				         return false;
		           }
                 if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
                        window.alert(title_2+"不能为空!");
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
document.getElementsByName("root")[0].disabled=true;
document.getElementsByName("root2")[0].disabled=true;
var tab='<%=request.getParameter("tab")%>';

var h='<%=request.getParameter("new")%>'
if(h=='old'){
var url = "${contextPath}/operate/task/saveLeafAgain.action?node=${node}&path=${path}&tab="+tab+"&addleaf=true";
myform.action = url;
myform.submit();
}else {
var url = "${contextPath}/operate/task/saveLeafAgain.action?node=${node}&path=${path}&new=true&tab="+tab+"&addleaf=true";
myform.action = url;
myform.submit();

}


window.top.frames['f_left'].location.href='${contextPath}/operate/task/showTreeListEdit.action?node=${node}&path=${path}&project_id=<%=request.getParameter("project_id")%>';
	 
	 
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
             
function backList(){
	myform.action = "${contextPath}/operate/doubt/search.action?type=${type}&project_id=${project_id}";
	myform.submit();
}



//模板生成----------保存表单
function saveForm(){
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
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }


var v_3 = "doubt.doubted_staff";  // field
var title_3 = '适用人员';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
				         bool = false;
				         return false;
		           }

var v_3 = "doubt.staff_str";  // field
var title_3 = '适用人员描述';// field name
var notNull = 'true'; // notnull
	           if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != "")
		           {
				         window.alert(title_3+"不能为空!");
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
 				window.alert("删除成功");
 				}else{
 					window.alert("所请求的页面有异常");
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
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css"
		rel="stylesheet" type="text/css" />
	<!-- 引入dwr的js文件 -->
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/csswin/subModal.js"></script>
	<SCRIPT type="text/javascript" src="${contextPath}/scripts/calendar.js"></SCRIPT>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>



	<body>
		<center>
		 <s:if test="'enabled' == '${shenjichengxu}'">
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
        </s:if>
			<s:form id="myform" onsubmit="return true;"
				action="/ais/operate/task" method="post">

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">



					<tr class="titletable1">
						<td style="width: 20%">

							<font color="red">*</font> 程序名称:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="audTask.taskName" cssStyle="width:80%" />
							<!--一般文本框-->

						</td>

						<td style="width: 20%">
							<font color="red">*</font> 程序序号:
						</td>
						<!--标题栏-->



						<td style="width: 30%">


							<!--  s:property value="audTemplate.doubt_status" /-->
							<s:textfield name="audTask.taskOrder" cssStyle="width:80%"
								maxlength="3" />
						</td>
					</tr>


					<s:hidden name="audTask.taskTemplateId" />
					<s:hidden name="audTask.taskPid" />
					<s:hidden name="audTemplateId" />
					<s:hidden name="taskTemplateId" />
					<s:hidden name="audTask.templateId" />
					<s:hidden name="audTask.id" />
					<s:hidden name="audTask.project_id" />

					<tr class="titletable1">
						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;程序编码:
						</td>
						<td>
							<s:property value="audTask.taskCode" />
							<s:hidden name="audTask.taskCode" />
						</td>

						<td>

							<font color="red"></font>&nbsp;&nbsp;&nbsp;执行人:
						</td>
						<!--标题栏-->
						<td>
							<s:textfield name="audTask.taskAssignName" cssStyle="width:80%"
								readonly="true" />
							<img
								src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showPopWin('/ais/pages/system/search/searchdatamuti.jsp?url=<%=request.getContextPath()%>/operate/task/selectTaskAssign.action&a=a&taskId=${audTask.id}&taskPid=${taskPid}&project_id=${project_id}&paraname=audTask.taskAssignName&paraid=audTask.taskAssign',420,300,'执行人选择')"
								border=0 style="cursor: hand">
							<s:hidden name="audTask.taskAssign" />
						</td>
					</tr>





					<tr class="titletable1">




						<td>
							&nbsp;&nbsp;&nbsp;是否必做:
						</td>
						<!--标题栏-->
						<td>
							<s:if test="${audTask.taskMust=='1'}">
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust">否
                        </s:if>
							<s:else>
								<input type="radio" value="1" name="audTask.taskMust"
									checked="checked">是&nbsp;<input type="radio" value="0"
									name="audTask.taskMust" checked="checked">否
						</s:else>
						</td>

						<td>


						</td>
						<td>

						</td>
					</tr>
					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计目的:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.taskTarget"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>

					</tr>


					<tr>
						<td class="titletable1">
							&nbsp;&nbsp;&nbsp;审计程序内容:
						</td>
						<td class="titletable1" colspan="3">

						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->

							<s:textarea name="audTask.taskMethod"
								cssStyle="width:100%;height:70;" />

						</td>
					</tr>



				</table>

				<s:hidden name="newDoubt_type" />
				<s:hidden name="audTemplate.doubt_id" />
				<s:hidden name="audTask.template_type" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />
				 
                <s:hidden name="audTask.taskPcode" />
				<s:button value="保存" onclick="saveFormLeaf();" name="root" />&nbsp;&nbsp;
				<s:button value="保存并增加" onclick="saveFormLeafAgain();" name="root2" />&nbsp;&nbsp;
                <s:button value="关闭" onclick="closeWindow();" />&nbsp;&nbsp; 
				 
				 

			</s:form>

		</center>
	</body>
</html>
