<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<base target="_self">

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>反馈意见</title>
		<!-- 引入css和js -->
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
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
			
			




<script type="text/javascript">

//查看反馈用户账号
function view_feedbackUser(){
var formId = '<s:property  value="formId" />';
var processType = '<s:property  value="processType" />';
	var num=Math.random();
	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
	var url = "${contextPath}/project/feedback/idea/viewFeedbackUser.action?formId="+formId+"&&processType="+processType;
	//window.showModelessDialog(url,window,'dialogWidth:500px;dialogHeight:450px;status:yes');
	window.open(url,"","height=500,width=800,top=80,left=200,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no");

} 

		




//附件详细窗口
 		function fileOpen(feedback_idea_file,processType){
 		var fileGUID = feedback_idea_file; 
 		 var url ="${contextPath}/project/feedback/idea/getFeedbackFileList.action?fileGUID="+fileGUID+"&&processType="+processType;
 		 window.open (url,"","height=400,width=600,top=300,left=300,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no");
 		}
 		
 		
 		
 		

 			
</script>

	</head>



	<body>
		<center>

			<s:form action="saveFeedback" namespace="/project/feedback/idea"
				name="form1">



               
					

				<!-- 引入项目的信息 -->
				<table class="its">
					 <!-- 选择的附件信息 -->
               <tr >
						<td colspan="7" align="center" class="listtabletr11">
							&nbsp;可供反馈查看附件信息
						</td>
					</tr>
					<s:if test="fileDetailList.size!=0">
					<tr class="listtablehead">
						<td align="center" class="listtabletr1" colspan="3">
							<center>附件名称</center>
						</td>
						<td align="center" class="listtabletr1" colspan="2">
							<center>上传人</center>
						</td>
						<td align="center" class="listtabletr1" >
							<center>上传时间</center>
						</td>
					</tr>
					<s:iterator value="fileDetailList" status="index">
						<tr>
							<td align="center" class="listtabletr2" colspan="3">
								<center><s:property value="fileName" /></center>
							</td>
							<td align="center" class="listtabletr2" colspan="2">
								<center><s:property value="uploader_name" /></center>
							</td>
							<td align="center" class="listtabletr2" colspan="2">
								<center><s:property value="fileTime" /></center>
							</td>
					     </tr>
				     </s:iterator>
				     </s:if>
					
					<tr>
						<td colspan="7" align="center" class="listtabletr11">
							&nbsp;征求单位/人员信息
						</td>
					</tr>
					
					<s:if test="feedbackInFlowList.size!=0">
					<tr class="listtablehead">
						<td align="center" class="listtabletr1" colspan="3">
							<center>被审计单位</center>
						</td>
						<td align="center" class="listtabletr1" colspan="2">
							<center>反馈人</center>
						</td>
						<td align="center" class="listtabletr1" >
							<center>征求状态</center>
						</td>
					</tr>
					</s:if>
					
					<s:iterator value="feedbackInFlowList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2" colspan="3">
								<center><s:property value="feedback_unit_name" /></center>
							</td>
							<td align="center" class="listtabletr2" colspan="2">
								<center><s:property value="feedback_man_name" /></center>
							</td>
							<td align="center" class="listtabletr2" >
							<center>
								<s:if test="feedback_status==0">
								<font color="red">未征求</font>
								</s:if>
								<s:if test="feedback_status==1">
								开始征求
								</s:if>
								<s:if test="feedback_status==2">
								延期征求
								</s:if>
								</center>
							</td>
						</tr>
					</s:iterator>
					
					<tr class="listtablehead">
						<td colspan="7" align="center" class="edithead">
							&nbsp;征求期间
						</td>
					</tr>
					<tr class="listtablehead">
						<td align="right" width="11%" class="ListTableTr1">
							开始日期:
						</td>
						<td class="ListTableTr2" width="17%"  align="left">
						<s:property  value="feedbackObject.feedback_Sdate" />
						</td>
						<td align="right" width="11%" class="ListTableTr1">
							结束日期:
						</td>
						<td class="ListTableTr2" width="18%" align="left">
						<s:property  value="feedbackObject.feedback_Edate" />
						</td>
					     <td align="right" width="11%" class="ListTableTr1">
							延期结束日期:
						</td>
						<td class="ListTableTr2"  width="20%" align="left">
						<s:property  value="feedbackObject.feedback_Ddate" />
						</td>
					</tr>
				</table>





				<table
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="6" align="left" class="edithead">
							&nbsp;反馈意见列表
						</td>
					</tr>
                    <s:if test="ideaList.size!=0">
					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							<center>反馈意见内容</center>
						</td>
						<td align="left" class="listtabletr1">
							<center>被审计单位</center>
						</td>
						<td align="left" class="listtabletr1">
							<center>反馈人</center>
						</td>
						<td align="left" class="listtabletr1">
							<center>附件信息</center>
						</td>
					</tr>
					</s:if>
					
					<s:iterator value="ideaList" status="index">
						<tr class="listtablehead">
							<td align="left" class="listtabletr2">
								<center><s:property value="feedback_content" /></center>
							</td>
							<td align="left" class="listtabletr2">
								<center><s:property value="feedback_unit_name" /></center>
							</td>
							<td align="left" class="listtabletr2">
								<center><s:property value="userName" /></center>
							</td>
							<td align="left" class="listtabletr2">
<center>
                                <s:if test="file_link !=null && file_link=='true'">
								<a href="javascript:;" onclick="fileOpen('${feedback_idea_file }')"
									title="查看被审计单位提交附件列表"> 详细 </a>
								</s:if>
								<s:else>
								无附件
								</s:else>

</center>
							</td>
						</tr>
					</s:iterator>
				</table>

<div align="right">

				<s:if test="feedbackInFlowList.size!=0">	
				<s:button value="查看帐户" 
					onclick="view_feedbackUser()" />
				</s:if><s:else>	
				<s:button value="查看帐户" disabled="true"
					onclick="view_feedbackUser()" />
				</s:else>
				&nbsp;&nbsp;&nbsp;&nbsp;
</div>


<s:hidden name="formId"/><!-- 表单id -->
<s:hidden name="project_id"/><!-- 项目id -->
<s:hidden name="processType"/><!-- 流程名称 -->
<s:hidden name="isFeedback"/>














			</s:form>

		</center>
	</body>
</html>
