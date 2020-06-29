<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="ais.project.feedback.util.DateUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="ais.project.start.model.ProjectStartObject"%>
<%@page import="ais.project.ProjectContant"%><html>
<html>
<base target="_self">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>征求及反馈信息</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
			<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/dwr/engine.js'></script>			
		<script type="text/javascript">	
			/*
			 *填写反馈意见
			 */
			function addFeedback(){
				var num=Math.random();
		      	var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
			
			    
			    var url ='${contextPath}/project/feedback/online/feedbackIdeaAdd.action?rnm='+rnm+'&issue_id=${issue_id}';
		 		var url1 = encodeURI(url);
		 		var urls = encodeURI(url1);
		        window.showModalDialog(urls,window,'dialogWidth:700px;dialogHeight:550px;status:yes');
		
		     }
		      /*
		       *删除反馈意见
		       */
		      function deleteFeedbackIdea(feedback_id){
		      
		       	if(confirm("确定删除反馈意见吗？")){
		       		DWREngine.setAsync(false);
		    		DWREngine.setAsync(false);DWRActionUtil.execute(
		    				{ namespace:'/project/feedback/online', action:'deleteFeedbackIdea', executeResult:'false' }, 
		    				{'feedback_ids':feedback_id},
		    				xxx1);
		   			function xxx1(data){
		   				if(data['flag'] == 'true'){
		        			alert("删除成功!");
		        			ref();
		       			}else{
		       				alert("删除失败!");
		       			}
		       			
		   			}
		       	}
		      }
		     /*
		      *更新反馈意见
		      */
		     function updateFeedbackIdea(feedback_id){
				var num=Math.random();
			    var rnm=Math.round(num*9000000000+1000000000);/*随机参数清除模态窗口缓存*/
			
			   	var url ='${contextPath}/project/feedback/online/feedbackIdeaAdd.action?rnm='+rnm+'&issue_id=${issue_id}&feedback_ids='+feedback_id ;
				var url1 = encodeURI(url);
				var urls = encodeURI(url1);
			    window.showModalDialog(urls,window,'dialogWidth:700px;dialogHeight:550px;status:yes');
		     }
		
			/*
			 *提交反馈意见
			 */
			function submitFeedbackIdea(feedback_id){
				if(confirm("确定提交吗？")){
					DWREngine.setAsync(false);
		    		DWREngine.setAsync(false);DWRActionUtil.execute(
		    				{ namespace:'/project/feedback/online', action:'updateFeedbackIdea', executeResult:'false' }, 
		    				{'feedback_ids':feedback_id},
		    				xxx1);
		   			function xxx1(data){
		   				if(data['flag']=='true'){
		       				alert("提交成功!");
		       				ref();
		       			}else{
		       				alert("提交失败!");
		       			}
		   			}
				}
			}
			
		/*
		 * 子窗体刷新本窗口
		 */	
		function ref(){
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
			var url = "${contextPath}/project/feedback/online/feedbackInfo.action?issue_id=${issue_id}";
			document.all.form1.action=url;
			document.all.form1.submit();
		}
		//返回
		function goback(){
			window.location.href="${contextPath}/project/feedback/online/issuesProjectList.action";
		}
		</script>

	</head>
	<body>
		<center>


			<s:form action="feedbackUserLink" namespace="/mng/feedback/idea" name="form1">

				<!-- 引入项目的信息 -->

				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							
							<s:if test="${issuesObject.processType=='report'}">
								报告阶段=>反馈意见
							</s:if>
							<s:else>
								整改跟踪阶段=>反馈意见
							</s:else>
							
						</td>
					</tr>

				</table>


				<% ProjectStartObject pso = (ProjectStartObject)request.getAttribute("projectStartObject");%>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							&nbsp;项目信息
						</td>
					</tr>
					
					<tr>
						<td class="listtabletr11">
						项目名称:
						</td>
						<td class="ListTableTr22" align="left" colspan="3">
							<s:property value="projectStartObject.project_name" />
						</td>

					</tr>
					<tr class="listtablehead">
						<td class="listtabletr11">
						项目组长:
						</td>

						<td class="ListTableTr22" align="left">
							<%
								if(pso!=null){
									out.println(pso.getMemberNameStringOfRole(ProjectContant.ZUZHANG));
								}
							%>
						</td>
						<td class="listtabletr11">
						项目副组长:
						</td>
						<td class="ListTableTr22" align="left">
							<%
								if(pso!=null){
									out.println(pso.getMemberNameStringOfRole(ProjectContant.FUZUZHANG));
								}
							%>
						</td>

					</tr>
					<tr class="listtablehead">
						<td class="listtabletr11">
						项目主审:
						</td>
						<td class="ListTableTr22" align="left">
							<%
								if(pso!=null){
									out.println(pso.getMemberNameStringOfRole(ProjectContant.ZHUSHEN));
								}
							%>
						</td>
						<td class="listtabletr11">
						项目组员:
						</td>

						<td class="ListTableTr22" align="left">
							<%
								if(pso!=null){
									out.println(pso.getMemberNameStringOfRole(ProjectContant.ZUYUAN));
								}
							%>
						</td>

					</tr>
					<tr class="listtablehead">
						<td class="listtabletr11">
						审计单位:
						</td>
						<td class="ListTableTr22" align="left">
							<s:property value="projectStartObject.audit_dept_name" />
						</td>
						<td class="listtabletr11" >
						被审计单位:
						</td>
						<td class="ListTableTr22" align="left">
							<s:property value="projectStartObject.audit_object_name" />
						</td>

					</tr>
					<s:if test="${issuesObject.processType=='report'}">
						<tr class="listtablehead">
							<td colspan="4" align="left" class="edithead">
								&nbsp;反馈文件
							</td>
						</tr>
						<tr align=center class=titletable1>
						<td align="center" class=1_lan nowrap="nowrap" style="width:350px;">文件名称</td>
						<td align="center" class=1_lan nowrap="nowrap" style="width:200px;">上传时间</td>
						<td align="center" class=1_lan nowrap="nowrap" colspan="2">上传人</td>
						</tr>
					
					<s:iterator value="issueFileList" status="index">
						<tr class="listtablehead">
							<td align="center" class="listtabletr2">
									<s:property value="file_name" escape="false"/>
							</td>
							<td align="center" class="listtabletr2">
								<s:property value="file_date" />
							</td>
							<td align="center" class="listtabletr2" colspan="2">
								<s:property value="uploader_name" />
							</td>
						</tr>
					</s:iterator>
					</s:if>
					<tr class="listtablehead">
						<td colspan="4" align="left" class="edithead">
							&nbsp;反馈时间表
						</td>
					</tr>
					<tr align=center class=titletable1>
					<td align="center" class=1_lan nowrap="nowrap">开始时间</td>
					<td align="center" class=1_lan nowrap="nowrap">结束时间</td>
					<td align="center" class=1_lan nowrap="nowrap" colspan="2">延期时间</td>
					</tr>
					<tr class="listtablehead">
					<td align="center" class="listtabletr2">
							<s:property value="issuesObject.issue_start_time" />
					</td>
										<td align="center" class="listtabletr2">
							<s:property value="issuesObject.issue_end_time" />
					</td>
										<td align="center" class="listtabletr2" colspan="2">
							<s:property value="issuesObject.issue_delay_time" />
					</td>
					
				</table>






				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" >
					
					<tr class="listtablehead">
						<td colspan="11" align="left" class="edithead">
							&nbsp;反馈信息列表
						</td>
					</tr>
					<tr class="listtablehead">					
						<td align="left" class="listtabletr1"
							rowspan="<s:property value="${row}"/>" >
							反馈意见
							<font color="red">*</font>
						</td>
						<td align="left" class="listtabletr1"
							nowrap="nowrap">
							提交状态
						</td>
						<td align="left" class="listtabletr1" >
							意见内容
						</td>
						<td align="left" class="listtabletr1" >
							反馈单位
						</td>
						<td align="left" class="listtabletr1" >
							反馈人
						</td>
						<td align="left" class="listtabletr1" >
							附件
						</td>
						<td align="left" class="listtabletr1" >
							<center>
								反馈时间
							</center>
						</td>
						<td align="left" class="listtabletr1" >
							<center>
								是否有纸质意见
							</center>
						</td>
						<td align="left" class="listtabletr1" >
							<center>
								电子意见与纸质意见是否相符
							</center>
						</td>
						<td align="left" class="listtabletr1" >
							<center>
								纸质反馈意见是否盖章签字
							</center>
						</td>
						<td align="left" class="listtabletr1" >
							<center>操作</center>
						</td>
					</tr>
					<s:iterator value="feedbackList" status="index" id="feedback_issues">
						<tr class="listtablehead" >
							<td align="left" class="listtabletr2" nowrap="nowrap">
							  	<center>
									<s:if test="${status=='1'}">
										已提交
									</s:if>
									<s:if test="${status=='2'}">
										未提交
									</s:if>
								</center>
							</td>						
							<td align="left" class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:300px'>
								${feedback_content}
							</td>
							<td align="left" class="listtabletr2" >
								${feedback_unit_name}
							</td>
							<td align="left" class="listtabletr2" >
								${feedback_user_name}
							</td>

							<td align="left" class="listtabletr2" >
                                ${feedback_file}
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									${feedback_time_page}
								</center>
							</td>
							<td align="left" class="listtabletr2">
								<center>
									<s:if test="${is_paper==null || is_paper=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									<s:if test="${paper_elec_match==null || paper_elec_match=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" >
								<center>
									<s:if test="${paper_seal==null || paper_seal=='false'}">
										否
									</s:if>
									<s:else>
										是
									</s:else>
								</center>
							</td>
							<td align="left" class="listtabletr2" style='word-break:break-all;word-wrap:break-word;width:40px'>
								<center>
									<s:if test="${status=='2' && write=='true'}">
										<a href="javascript:;" onclick="deleteFeedbackIdea('${feedback_id}')" style="cursor: hand"> 删除</a>
										<br>
										
										<a href="javascript:;" onclick="updateFeedbackIdea('${feedback_id}')" style="cursor: hand">修改</a>
				
										
									</s:if>
									
								</center>
							</td>
						</tr>
					</s:iterator>
				</table>
				<s:if test="${write=='true'}">
					<s:button value="填写反馈意见" onclick="return addFeedback();" title="请填写反馈意见" />&nbsp;&nbsp;&nbsp;&nbsp;
				</s:if>
				<s:else>
					<font color="red" style="font-weight: bold;">${write}</font>
				</s:else>


			</s:form>

		</center>
	</body>
</html>
