<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
	<!-- 注意：在模态窗口里面提交必须有这个 -->
    
    <title>整体反馈意见</title>
    
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		
		<!--  引入DWR包 -->
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>	
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/util.js'></script>	
		<!-- 长度验证 -->
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
  </head>
  <script type="text/javascript">
  		   /*
			*   删除附件
			*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					} 
				}
			}
  /*
   * 保存整体意见
   */		
  function saveAllIdea(){
  		//非空验证
  		var feedback_man_name = document.getElementsByName('feedbackAllIdea.feedback_man_name')[0].value;
  		var feedback_time = document.getElementsByName('feedbackAllIdea.feedback_time')[0].value;
  		var audit_unit = document.getElementsByName('feedbackAllIdea.audit_unit')[0].value;
  		var feedback_result = document.getElementsByName('feedbackAllIdea.feedback_result')[0].value;
  		
  		if(feedback_man_name==null||feedback_man_name ==''){
  			alert("反馈人不能为空!");
  			return;
  		}
  		if(feedback_time==null||feedback_time ==''){
  			alert("请填写反馈时间!");
  			return;
  		}
  		if(audit_unit==null||audit_unit==''){
  			alert("被审单位不能为空!");
  			return;
  		}
  		
		if(feedback_result==null || feedback_result==''){
  			alert("反馈结果不能为空!");
  			return;
  		}
  			
  		document.getElementsByName('strList')[0].value=
  						document.getElementsByName('feedbackAllIdea.id')[0].value  //0
  					+":"+document.getElementsByName('project_id')[0].value//1	
					+":"+document.getElementsByName('processType')[0].value//2
					+":"+ audit_unit//3
					+":"+ feedback_man_name//4
					+":"+ feedback_man_name//5
					+":"+ feedback_time//6
					+":"+ feedback_result//7
					+":"+document.getElementsByName('feedbackAllIdea.file_guid')[0].value//8 
					+":"+document.getElementsByName('state')[0].value//9 用strList带参数到后台
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/project/feedback/idea', action:'saveFeedbackAllIdeas', executeResult:'false' },
		'strList',
		xxx1
		);
  }
   
 function xxx1(data){
 	var flag = data['allIdeaListStr'].split("*");
	if(flag[0] != "true"){
		window.alert("保存失败！");
	}else{
		window.alert("保存成功！");
	 	window.returnValue=data['allIdeaListStr'].substr(5,data['allIdeaListStr'].length);
	 	window.close();
	 	
	}
}
   /*
	*上传附件
	*/
	function Upload(id,filelist){
	
		var guid=document.getElementById(id).value;
		var num=Math.random();
		var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_feedback_all_idea&table_guid=file_guid&guid=<s:property value="feedbackAllIdea.file_guid"/>&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
	    //parent.setAutoHeight();
	}
  </script>
  <body>
    <s:form action="" method="post">
    	<s:hidden name="state"/>
    	<s:hidden name="feedbackAllIdea.id"/>
   	 	<s:hidden name="processType"/>
   	 	<s:hidden name="strList" id="strList"/>
   	 	<s:hidden name="file_guid"/>
   	 	<s:hidden name="project_id"/>
    <table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce"
					class="ListTable" align="center">
					<tr class="listtablehead">
						<td colspan="7" align="center" class="edithead">
							&nbsp;被审计单位整体反馈意见管理
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="right" width="11%" class="ListTableTr1">
							<font color="red">*</font>被审计单位:
						</td>
						<td align="right" width="11%" class="ListTableTr1">
						 	<s:select list="audit_objectMap" listKey="key" listValue="value" name="feedbackAllIdea.audit_unit"/>
						</td>	
						<td align="right" width="11%" class="ListTableTr1">
							<font color="red">*</font>反馈人:
						</td>
						<td align="right" width="11%" class="ListTableTr1">
							<s:textfield name="feedbackAllIdea.feedback_man_name" value="${feedbackAllIdea.feedback_man_name}"/>
						</td>	
						<td align="right" width="11%" class="ListTableTr1">
							<font color="red">*</font>反馈日期:
						</td>	
						<td align="right" width="11%" class="ListTableTr1">
									<s:textfield id="feedback_Sdate"
									name="feedbackAllIdea.feedback_time" readonly="true"
									cssStyle="width:100%" maxlength="20" title="单击选择日期"
									onclick="calendar()" theme="ufaud_simple"
									templateDir="/strutsTemplate"></s:textfield>
						</td>																																	
					</tr>
					<tr>
						<td align="right" width="11%" class="ListTableTr1">
							<font color="red">*</font>反馈结果:
						</td>	
						<td align="right" width="11%" class="ListTableTr1" colspan="5">
							<s:textarea name="feedbackAllIdea.feedback_result" />
							<input type="hidden" id="feedbackAllIdea.feedback_result.maxlength" value="500">
						</td>	
					</tr>
					<tr>
						
						<td align="right" width="11%" class="ListTableTr1">
							<s:button 
								disabled="!(varMap['uploadw_fileWrite']==null?true:varMap['uploadw_fileWrite'])"
								display="${varMap['uploadw_fileRead']}" 
								onclick="Upload('feedbackAllIdea.file_guid',accelerys)" value="上传反馈意见文档" />
							<s:hidden name="feedbackAllIdea.file_guid" />
						</td>	
						<td align="right" width="11%" colspan="5" class="ListTableTr1">
							<div id="accelerys" align="center">
								<s:property escape="false" value="accessoryList"/>
							</div>
						</td>
					</tr>
					<tr align="right">
						<td align="right" width="11%" class="ListTableTr1" colspan="6" style="text-align: right">
							<s:button value="保 存" onclick="saveAllIdea()"/>
							<s:reset value="重 置"/>
						</td>	
					</tr>
				</table>
    </s:form>
  </body>
</html>
