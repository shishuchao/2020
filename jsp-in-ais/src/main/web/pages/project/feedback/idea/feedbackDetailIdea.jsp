<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>明细反馈意见</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
  function saveDetailIdea(){
  		var audit_unit = document.getElementsByName('feedbackDetailIdea.audit_unit')[0].value;
  		var feedback_content = document.getElementsByName('feedbackDetailIdea.feedback_content')[0].value;
  		var audit_man = document.getElementsByName('feedbackDetailIdea.audit_man')[0].value;
  		var feedback_time = document.getElementsByName('feedbackDetailIdea.feedback_time')[0].value;
  		if(audit_unit==null || audit_unit==''){
  			alert("被审单位不能为空!");
  			return;
  		}
  		if(feedback_content==null || feedback_content==''){
  			alert("反馈内容不能为空!");
  			return;
  		}
  		if(audit_man==null || audit_man==''){
  			alert("请指定审计人员!");
  			return;
  		}
  		if(feedback_time==null || feedback_time==''){
  			alert("请填写反馈时间!");
  			return 
  		}
		DWREngine.setAsync(false);
		DWRActionUtil.execute(
			{ namespace:'/project/feedback/idea', action:'saveFeedbackDetailIdea', executeResult:'false' },
			{'id':'${feedbackDetailIdea.id}','project_id':'${project_id}','processType':'${processType}','audit_unit':audit_unit,'feedback_content':feedback_content,
			'audit_man':audit_man,'feedback_time':feedback_time,'state':'${feedbackDetailIdea.state}','detail_state':'${detail_state}'},
			xxx1
		);
		
		function xxx1(data){
			if(data['detailIdeaListStr'] != null && data['detailIdeaListStr']!=''){
				var flag = data['detailIdeaListStr'].split("|");
				if(flag[0] != "true"){
					window.alert("保存失败！");
				}else{
					window.alert("保存成功！");
				 	window.returnValue=data['detailIdeaListStr'].substr(5,data['detailIdeaListStr'].length);
				 	window.close();
				}
			}else{
				window.alert("保存失败！");
			}
	}
  }
 

  </script>
  <body>
    <s:form action="" method="post">
    <table 
					class="its" align="center">
					<tr class="listtablehead">
						<td colspan="7" align="center" class="edithead">
							&nbsp;被审计单位明细反馈意见管理
						</td>
					</tr>
					<tr>
						<td align="right" class="ListTableTr11">
							<font color="red">*</font>被审计单位:
						</td>
						<td align="right" class="ListTableTr22">
							<s:select list="audit_objectMap" listKey="key" listValue="value" name="feedbackDetailIdea.audit_unit"/>
						</td>	
						<td align="right" class="ListTableTr11">
							<font color="red">*</font>指定审计人:
						</td>
						<td align="right">
							<s:select list="team_MemberMap" listKey="key" listValue="value" name="feedbackDetailIdea.audit_man"/>
						</td>	
						<td align="right" class="ListTableTr11">
							<font color="red">*</font>反馈日期:
						</td>	
						<td align="right">
									<s:textfield id="feedback_Sdate"
									name="feedbackDetailIdea.feedback_time" readonly="true"
									 maxlength="20" title="单击选择日期"
									onclick="calendar()" theme="ufaud_simple"
									templateDir="/strutsTemplate"></s:textfield>
						</td>																																	
					</tr>
					<tr>
						<td align="right" class="ListTableTr11">
							<font color="red">*</font>反馈意见:
						</td>	
						<td align="right" class="ListTableTr22" colspan="6">
							<s:textarea name="feedbackDetailIdea.feedback_content" cssStyle="width:100%" />
							<input type="hidden" id="feedbackDetailIdea.feedback_content.maxlength" value="500">
						</td>	
					</tr>
					<tr>
						
						<td align="right" width="11%" class="ListTableTr1" style="text-align: right" colspan="7">
							<s:button value="保 存" onclick="saveDetailIdea()"/>
							<s:reset value="重 置"/>
						</td>
					</tr>
				</table>
 	</s:form>
  </body>
</html>
