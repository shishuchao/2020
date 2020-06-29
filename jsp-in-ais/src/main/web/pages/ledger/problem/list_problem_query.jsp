<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>违规记录查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type='text/javascript'
			src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
     <link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
	 <link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
     <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
     <script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<div style="display: inline; width: 80%;">
						<s:property escape="false"
							value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ledger/problemledger/problemQuery!problemQuerList.action')" />
					</div>
					<div style="display: inline; width: 20%; text-align: right;">
						<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
					</div>
				</td>
			</tr>
		</table>
		<s:form action="problemQuery!problemQuery.action" namespace="/ledger/problemledger">
			<table id="planTable" class="ListTable" 
				style="display: none; table-layout: fixed;">
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						违规分类：
					</td>
					<td align="left" class="listtabletr22">
					  <s:buttonText2 id="sort_three_name" hiddenId="sort_three_code"
								name="ledgerProblem.sort_three_name" cssStyle="width:90%"
								hiddenName="ledgerProblem.sort_three_code"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/utilTee/ansyCheckBoxTreeFrame.jsp?urlAction=${pageContext.request.contextPath}/ledger/problemledger/problemQuery!problemQueTree.action&nameid=sort_three_name&codeid=sort_three_code&chkStyle=radio&radioType=all',600,450,'被审单位');"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
					</td>
					<td align="left" class="listtabletr11">
						违规名称：
					</td>
					<td align="left" class="listtabletr22">
						<s:buttonText2 id="problem_name" hiddenId="problem_code"
								name="ledgerProblem.problem_name" cssStyle="width:90%"
								hiddenName="ledgerProblem.problem_code"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/utilTee/ansyCheckBoxTreeFrame.jsp?urlAction=${pageContext.request.contextPath}/ledger/problemledger/problemQuery!problemQuePointTree.action&nameid=problem_name&codeid=problem_code&chkStyle=radio&radioType=all',600,450,'被审单位');"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="left" class="listtabletr11">
						创建人：
					</td>
					<td align="left" class="listtabletr22">
						<s:textfield name="ledgerProblem.problemCreater" maxlength="50" />
					</td>
					<td align="left" class="listtabletr11">
						被审计单位：
					</td>
					<td align="left" class="listtabletr22">
					    <s:buttonText2 id="audit_object_name" hiddenId="audit_object"
								name="ledgerProblem.audit_object_name" cssStyle="width:90%"
								hiddenName="ledgerProblem.audit_object"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/utilTee/ansyCheckBoxTreeFrame.jsp?urlAction=${pageContext.request.contextPath}/proledger/problem/utilTree!ansyMakeAudedUnitZtree.action&nameid=audit_object_name&codeid=audit_object&chkStyle=radio&radioType=all',600,450,'被审单位');"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true" />
					</td>
				</tr>
				<tr class="listtablehead" height="23">
					<td align="right" class="listtabletr1" colspan="4">
						<DIV align="right">
							<s:submit value="查询" />
							&nbsp;
							<input type="button" value="重置"
								onclick="window.location.href='${contextPath}/ledger/problemledger/problemQuery!problemQuerList.action'">
						</DIV>
					</td>
				</tr>
			</table>

			<div align="center">
				<display:table id="row" name="ledgerProblemList"
					pagesize="10" class="its" requestURI="${contextPath}/ledger/problemledger/problemQuery!problemQuery.action">
					<display:column property="sort_big_name" title="一级分类"
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column property="sort_small_name" title="二级分类"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column title="三级分类" property="sort_three_name"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
					</display:column>
					<display:column title="违规问题名称" property="problem_name"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
					</display:column>
					<display:column title="被审计单位" property="audit_object_name"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
					</display:column>
					<display:column title="创建人" property="problemCreater"
						headerClass="center" style="WHITE-SPACE: nowrap" sortable="true">
					</display:column>
				</display:table> 
			</div>
			<br/>
		</s:form>

		<script type="text/javascript">
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}
		</script>
	</body>
</html>