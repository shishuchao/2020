<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>反馈意见-选择被审计单位添加反馈人</title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
				<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>	
		<s:if test="${processType=='report'}">
			<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		</s:if>

<script type="text/javascript">  
	$(function(){
		initObjsFun();
		$('#auditObjectList').change(function(){
		 var selectauditobject = $("#auditObjectList").find("option:selected").val();
		 	//alert("selectauditobject:" + selectauditobject);
		 	$("#feedbackUserList").find("option").remove();
		 	initFun("",selectauditobject);
		});		
		
		/*通过反馈人定位被审计单位暂且注销
		$('#feedbackUserList').change(function(){
			var selectuser = $("#feedbackUserList").find("option:selected").val();
		 	//alert("selectuser:" + selectuser);
		 	$("#auditObjectList").find("option").remove();
		 	initFunObjsChange(selectuser,"");			
		});
		*/
		
	});
	//初始化被审计单位下拉列表
	function initObjsFun(){
		var returnValue='${audit_objects_name}'.split(",");
		var returnValue2='${audit_objects}'.split(",");
		
		initFun("",returnValue2[0]);
		
		$("#auditObjectList").find("option").remove();
		var productStra = $("#auditObjectList");
		//var option = "<option value=""></option>";
		for(var i=0;i<returnValue2.length;i++){
			var option="";
			 option = $("<option>").text(returnValue[i]).val(returnValue2[i]);
			 productStra.append(option);
			
		}		
	}
	//初始化反馈人下拉列表	
	function initFun(loginnameValue,audit_objectValue){
		$.post("${contextPath}/project/feedback/online/getfeedbackUserList.action?",{project_id:'<%=request.getParameter("project_id")%>',loginname:loginnameValue,audit_object:audit_objectValue}, function(returnValue2) {
			var jsonList=eval("("+returnValue2+")");
			if(null!=jsonList&&jsonList!=''){
			　　for(var i=0;i<jsonList.length;i++){
				var productStra = $("#feedbackUserList");
					for(var i=0;i<jsonList.length;i++){
						var option="";
						 option = $("<option>").text(jsonList[i].name).val(jsonList[i].loginname);
						 productStra.append(option);
						
					}
			 　　}				
			}
		});
	}
	//初始化反馈人下拉列表	
	function initFunObjsChange(loginnameValue,audit_objectValue){
		$.post("${contextPath}/project/feedback/online/getfeedbackUserList.action?",{project_id:'<%=request.getParameter("project_id")%>',loginname:loginnameValue,audit_object:audit_objectValue}, function(returnValue2) {
			var jsonList=eval("("+returnValue2+")");
			if(null!=jsonList&&jsonList!=''){
				$("#auditObjectList").find("option").remove();
				var productStra = $("#auditObjectList");
					var option="";
					 option = $("<option>").text(jsonList[0].audit_object_name).val(jsonList[0].audit_object);
					 productStra.append(option);
			}
		});
	}	
 var issues_files="";
/*
 * 添加
 */		
function saveIssues(){
	var feedback_unit = $("#auditObjectList").find("option:selected").val();
	//alert("feedback_unit:"+feedback_unit);
	var feedback_user = $("#feedbackUserList").find("option:selected").val();
	//alert("feedback_unit:"+feedback_unit);
	var feedback_user_name = $("#feedbackUserList").find("option:selected").text();
	//alert("feedback_user_name:"+feedback_user_name);
	if(feedback_unit == null  || feedback_unit == "" ){
		alert("请选择需要征求的被审计单位！");
		return false;
	}
	if(feedback_user_name == null || feedback_user_name == ""){
		alert("请填写需要征求的反馈人！");
		return false;
	}
	//是否选择征求意见稿
	if(${processType=='report'}){
		if(!checkFile()){return false};
	}
	document.getElementById("saveIs").disabled=true;
	//添加校验，判断被审计单位的反馈意见人是否已经存在
	DWREngine.setAsync(true);
	DWREngine.setAsync(false);DWRActionUtil.execute(
	{ namespace:'/project/feedback/online', action:'saveFeedbackUser', executeResult:'false' }, 
	{'project_id':'${project_id}','processType':'${processType}','feedback_unit':feedback_unit,'feedback_user':feedback_user,'feedback_user_name':feedback_user_name
	 ,'issue_start_time':'${issue_start_time}','issue_end_time':'${issue_end_time}','issue_delay_time':'${issue_delay_time}','issues_files':issues_files},
	xxx1);
  	function xxx1(data){
		if(data['is_exsit'] == "YES"){
			window.alert("增加成功！");
		 	window.returnValue="OK";
		 	window.close();
		}else{
			alert("增加失败！");
			document.getElementById("saveIs").disabled=false;
		    return;
		}
    }
    
}

//是否选择征求意见稿
function checkFile(){

	var len = document.getElementsByName("fileGUID").length;
	for(var i=0;i<len; i++){
		if(document.getElementsByName("fileGUID")[i].checked == true){
			issues_files += document.getElementsByName("fileGUID")[i].value + ','; 
		}
	} 
	issues_files = issues_files.substr(0, issues_files.length-1); 
	if(issues_files==''){
		 alert("请选择附件！"); 
		 return false;
	}
	return true;
	
}	 	
//选择被审计单位
var audit_unit;
var audit_unit_name;
function selectAudtObject(){
	document.getElementById("feedback_name_img").style.display='none';
	var fromList = document.getElementById('sl');
		for (var i = 1; i < fromList.options.length; i++) {
    	if (fromList.options[i].selected) {
	    	feedback_unit = fromList.options[i].value;
	    	
	    		DWREngine.setAsync(true);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/feedback/online', action:'getAuditCodeAndName', executeResult:'false' }, 
				{'feedback_unit':feedback_unit},
				xxx1);
			  	function xxx1(data){
					if(data['audit_unit'] != null && data['audit_unit']!="" && data['audit_unit_name']!=null && data['audit_unit_name']!=""){
						audit_unit = data['audit_unit'];
						audit_unit_name = data['audit_unit_name'];
						document.getElementById("feedback_name_img").style.display='inline';
					}
			   }
	    	break;
    	}
	}
}
/*
 * 被审计单位
 */
 function openAuditMan(){
 	var feedback_unit = document.getElementsByName("issuesObject.feedback_unit")[0].value;
 	if(feedback_unit == null  || feedback_unit == "" ){
		alert("请选择需要征求的被审计单位！");
		return false;
	}
    var url = '${contextPath}/pages/system/search/mutiselect.jsp?url=${contextPath}/pages/searchsystem/usersThisOrg.jsp'
    		+ '&paraname=issuesObject.feedback_user_name&paraid=issuesObject.feedback_user&p_issel=1&feedback_unit=' + audit_unit;
    		//alert(url);
 	showPopWin(url,600,350);
 }
	function addUserFun(){
 		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		 //var temp = '${contextPath}/operate/task/showContentLeafView.action?type=1&taskTemplateId='+'<%=request.getParameter("project_id")%>'+'&project_id='+crudObject_taskId;
		 var popstyle="dialogHeight:480px;dialogWidth:680px;status:no";
		    window.showModalDialog('${contextPath}/auditAccessoryList/addTempSysAccount.action?projectId=<%=request.getParameter("project_id")%>&&rnm='+ rnm,window,popstyle);
	   }
	 function reloadwin(){
	 	$("#feedbackUserList").find("option").remove();
		initObjsFun();
	 }  	
</script>
	</head>
	<body  onload="">
		<center>

		<s:form action="saveFeedbackUser" namespace="/project/feedback/online"
				name="form1">

			<table
				class="ListTable">
				<tr class="listtablehead">
					<td colspan="2" align="center" class="edithead">
						&nbsp;新增征求单位/人员
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="right" class="ListTableTr11">
						<font color="red">*</font>被审计单位:
					</td>
					<td align="right" class="ListTableTr22">
						<select id="auditObjectList" name="auditObjectList" style="width:160px;"></select>		
					</td>	
				</tr>
				<tr class="listtablehead">
					<td align="right" class="ListTableTr11">
						<font color="red">*</font>反馈人:
					</td>
					<td class="listtabletr22" align="right" >
					<select id="feedbackUserList" name="users" style="width:160px;"></select>	
						&nbsp;&nbsp;&nbsp;&nbsp;	
						<input type="button" id="addUser" onclick="addUserFun();" value="增加反馈人"/>			
					</td>
				</tr>
			</table>
			<s:if test="${processType=='report'}">
				<table class="its">
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							附件选择列表
						</td>
					</tr>
				</table>
				<display:table id="row" name="issueFileList" pagesize="10"
					class="its" requestURI="${contextPath}/project/feedback/online/feedbackUserAdd.action">
					<display:column title="选择" media="html" headerClass="center"
						class="center">
						<input type="checkbox" name="fileGUID" value="${row.file_id}"/>
					</display:column>
					<display:column title="附件名称" headerClass="center" class="center"
						property="file_name"  sortable="true"></display:column>
					<display:column title="上传人" headerClass="center" class="center"
						property="uploader_name"  sortable="true"></display:column>
					<display:column title="上传时间" headerClass="center" class="center"
						property="file_time" sortable="true"></display:column>
				</display:table>
			</s:if>
			<br>
			<div align="center">
			       <s:button onclick="return saveIssues()" id="saveIs" value="保 存" disabled=""/>
			</div>

		</s:form>

		</center>
	</body>
</html>
