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
    
    <title>审计部门处理意见</title>
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
	    <script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
  </head>
 <script type="text/javascript">
  function saveResultIdea(){
  	var result_idea = document.getElementsByName('feedbackResultIdea.result_idea')[0].value;
  	var do_time = document.getElementsByName('feedbackResultIdea.do_time')[0].value
  	
    var isWorkUpdate = "";
    
    if(result_idea==null || result_idea==''){
    	alert("处理结果不能为空!");
    	return; 
    }
    if(do_time==null || do_time==''){
    	alert("处理时间不能为空!");
    	return;
    }
  	    if(${isWorkUpdate!=null || isWorkUpdate!=""}){    
    	 var obj=document.getElementsByName('isWorkUpdate');
		    if(obj!=null){
		        var i;
		        for(i=0;i<obj.length;i++){
		            if(obj[i].checked){
		                isWorkUpdate = obj[i].value;            
		            }
		        }
		    }
	    }
  	    DWREngine.setAsync(false);
		DWRActionUtil.execute(
			{ namespace:'/project/feedback/idea', action:'saveFeedbackResultIdea', executeResult:'false' },
			{'result_id':'${feedbackResultIdea.id}','do_man':'${feedbackResultIdea.do_man}','do_man_name':'${feedbackResultIdea.do_man_name}',
			'pro_role':'${feedbackResultIdea.pro_role}','pro_role_name':'${feedbackResultIdea.pro_role_name}','result_idea':result_idea,
			'do_time':do_time,'result_state':'${result_state}','idea_id':'${idea_id}','project_id':'${project_id}','isWorkUpdate':isWorkUpdate},
			xxx1
		);
		
		function xxx1(data){
			if(data['resultIdeaListStr'] != null && data['resultIdeaListStr']!=''){
				var flag = data['resultIdeaListStr'].split("|");
				if(flag[0] != "true"){
					window.alert("保存失败！");
				}else{
					window.alert("保存成功！");
				 	window.returnValue=data['resultIdeaListStr'].substr(5,data['resultIdeaListStr'].length);
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
    <table class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="center" class="edithead">
							&nbsp;审计部门处理意见管理
						</td>
					</tr>
					<tr>
						<td class="ListTableTr11">
							<font color="red">*</font>处理人:
						</td>
						<td class="ListTableTr22">
							<s:textfield name="feedbackResultIdea.do_man_name" readonly="true"/>
							<s:hidden name="feedbackResultIdea.do_man"/>
						</td>	
						<td class="ListTableTr11">
							<font color="red">*</font>处理日期: 
						</td>
						<td class="ListTableTr22">
								<s:textfield id="feedbackResultIdea.do_time"
									name="feedbackResultIdea.do_time" readonly="true"
									 maxlength="20" title="单击选择日期"
									onclick="calendar()" theme="ufaud_simple"
									templateDir="/strutsTemplate"></s:textfield>
						</td>																																
					</tr>						
					<tr>
						<td class="ListTableTr11">
							<font color="red">*</font>处理意见:
						</td>	
						<td  class="ListTableTr22" colspan="3">
							<s:textarea name="feedbackResultIdea.result_idea" cssStyle="width:90%" />
							<input type="hidden" id="feedbackResultIdea.result_idea.maxlength" value="500">
						</td>	
					</tr>
							
					<tr>
						<td align="right" class="ListTableTr1" style="text-align: right" colspan="4">
							<s:button value="保 存" onclick="saveResultIdea()"/>
							<s:reset value="重 置"/>
						</td>
					</tr>
				</table>
 	</s:form>
  </body>
</html>
