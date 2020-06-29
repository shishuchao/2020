<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	   <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<s:text id="title" name="'整改跟踪列表'"></s:text>
		<title>整改跟踪信息列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
	</head>
	<body>
		<center>
			<table class='ListTable'>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property value="#title" />
					</td>
				</tr>
			</table>
			<div class='easyui-tabs' >
	            <div id='auditWorkProgramRework' title='补充信息登记' style="overflow: hidden;">
	                    <iframe id="reworkWorkProgram"  src="${contextPath}/workprogram/auditDeptTabFile.action?projectid=<s:property value="project_id" />&wpd_stagecode=rework"
	                        frameborder="0" width="100%" height="330px" scrolling="auto"></iframe>
	            </div>
				<div id="dept" title='被审计单位整改反馈' <s:if test="${backFlag == 'Y'}"> data-options="selected:true"</s:if> style="overflow: hidden;">
                   	<display:table name="list" id="row" requestURI="${contextPath}/proledger/problem/auditTrackingListForAuditObject.action"
			           			   class="its" pagesize="15">
			           			   <%-- 
						<display:column title="选择" headerClass="center" class="center">
							<input name="problemCheckBox" type="checkbox" value="${row.id}" onclick="change(this,'${row.is_mend_achieve}')"/>
						</display:column>
			           			    --%>
						<display:column property="manuscript_code" title="底稿编号" sortable="true" class="center" headerClass="center"></display:column>
					    <display:column title="是否关闭" headerClass="center" class="center">
						<s:if test="${row.is_mend_achieve=='1'}">是</s:if><s:else>否</s:else>
					    </display:column>		
		                <display:column property="problem_all_name" title="问题类别" sortable="true" class="center" headerClass="center"></display:column>
		                <%-- <display:column property="sort_small_name" title="问题子类别" sortable="true" class="center" headerClass="center"></display:column> --%>
						<display:column property="problem_name" title="问题点" sortable="true" class="center" headerClass="center"></display:column>
						<display:column property="problem_money" title="问题发生金额（万元）" sortable="true" class="center" headerClass="center"></display:column>
						<display:column property="problemCount" title="发生数量（个）" sortable="true" class="center" headerClass="center"></display:column>
						<display:column property="problem_grade_name" title="审计发现类型" sortable="true" class="center" headerClass="center"></display:column>
						<display:column property="mend_term_between" title="整改期限" sortable="true" class="center" headerClass="center" ></display:column>
						<display:column property="lastFeedbackTime" title="最近反馈时间" sortable="true" class="center" headerClass="center"/>
						<display:column title="反馈次数" sortable="true" class="center" headerClass="center">${row.feedbackNum}</display:column>
						<display:column title="操作" class="center" headerClass="center">
							<a href="javascript:void(0)" onclick="regPlan('${row.id}')">登记行动计划</a>
							<a href="javascript:void(0)" onclick="regResult('${row.id}')">登记整改结果</a>
						</display:column>
					</display:table>
					<s:hidden name="is_mend_achieve"/>
				</div>
            </div>
            <input id="backList" type="button" value="返回" onclick="backList()" />
		</center>
		<script type="text/javascript">
			function closeFun(id,project_id,other){
				var flag =  confirm('关闭后结束此问题整改，是否确认关闭?'); 
				if(flag){
	        			$.ajax({
	        			   type: "POST",
	        			   url: "${contextPath}/proledger/problem/updateMiddleLedgerProblemPara.action",
	        			   data: {"id":id,"project_id":project_id},
		        			   success: function(msg){
		        				   if(msg=='1'){
		        				   		window.location.reload();
		        				   		//window.location.href="/ais/proledger/problem/auditTrackingList.action?"+other;
		        				   }
		        			   }
	        			});
				}			
			}
			
			function change(obj,is_mend_achieve){
				document.getElementById("is_mend_achieve").value=is_mend_achieve;
				var ids = document.getElementsByName("problemCheckBox");
				for(var i=0;i<ids.length;i++){
					if(obj!=ids[i] && ids[i].checked==true)
						ids[i].checked=false;
				}
			}
			
			function backList() {
			    window.location.href = "${contextPath}/project/rework/listAllForAuditObject.action";
			}
			
			function regPlan(id){				
				if(id == ''){
					alert("请选择具体问题!")
					return false;
				}else{
				    window.location.href = "${contextPath}/proledger/problem/editMendLedgerForAuditObject.action?id="+id;
				}
			}
			
			function regResult(id){
				var is_mend_achieve = document.getElementById("is_mend_achieve").value;
				if(id == ''){
					alert("请选择具体问题!")
					return false;
				}else{
					if(is_mend_achieve != '1')
						window.location.href = "${contextPath}/proledger/problem/listProblemFeedback.action?project_id=${project_id}&problem_id="+id;
				    else{
				    	alert("该问题己完成整改，不需要反馈！");
				    	return false;
				    }
				}
			}
		</script>
	</body>
</html>
