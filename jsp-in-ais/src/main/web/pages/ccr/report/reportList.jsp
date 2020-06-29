<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>报表列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
					src="${contextPath}/scripts/checkboxsoperation.js">
		</script>
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

		<script type="text/javascript">
			function addReport(){
				window.open("${contextPath}/ccReport/addReport.action","报表信息","left=200,width=450,height=300,toolbar=no,location=no,menubar=no,scrollbars=no,resizable=yes,status=no");				                                                         
			}
			function delcareReport(){
				document.forms(1).action="delcareReport.action";
				document.forms(1).submit();
			}
			function cancelDelcareReport(){
				document.forms(1).action="cancelDelcareReport.action";
				document.forms(1).submit();
			}
			function checkButton(){//检查取消上报按钮是否可用
				//如果所选单位编号都不与目前单位编号一致，说明是子单位，可以取消上报
				//目前所有显示的都是自己单位与子单位的
				var checkobjs = document.getElementsByName("ids");
				var cancelresult = 0;
				var declareresult = 0;
				var count = 0;
				for(i=0;i<checkobjs.length;i++){
					if(checkobjs[i].checked){
						count++;
						var unitid = document.getElementById(checkobjs[i].value+"_unit").value;
						var flag = document.getElementById(checkobjs[i].value+"_flag").value;
						if(unitid!='${session.user.fdepid}'&&flag==1){
							cancelresult++;
						}
						if(unitid=='${session.user.fdepid}'&&flag==0){
							declareresult++;
						}
					}
				}
				if(cancelresult==count&&count>0){
					document.getElementById("cancelButton").disabled=false;
				}else{
					document.getElementById("cancelButton").disabled=true;
				}
				if(declareresult==count&&count>0){
					document.getElementById("declareButton").disabled=false;
				}else{
					document.getElementById("declareButton").disabled=true;
				}
			}
			function openImport() {
				var url = "${contextPath}/ccReport/importReport.action";
				window.location.href=url;
				/* //window.open(url,"","width=500,height=300,menubar=no,directories=no,status=no,location=no,scrollbars=no,resizable=yes"); */
			}
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}
		</script>
	</head>
	<body>
		<center>
			<table id="tableTitle" width="100%" border=0 cellPadding=0
				cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td colspan="4" class="edithead"
						style="text-align: left; width: 100%;">
						<div style="display: inline; width: 80%;">
							<s:property escape="false"
								value="@ais.framework.util.NavigationUtil@getNavigation('/ais/ccReport/reportList.action')" />
						</div>
						<div style="display: inline; width: 20%; text-align: right;">
							<a href="javascript:void(0);" onclick="triggerSearchTable();">查询条件</a>
						</div>
					</td>
				</tr>
			</table>
			<s:form action="reportList" namespace="/ccReport">
				<table id="planTable" cellpadding=0 cellspacing=1 border=0
					bgcolor="#409cce" class="ListTable" align="center"
					style="display: none; table-layout: fixed;">
					<tr class="listtablehead" height="23">
						<td align="left" class="listtabletr11">
							报表名称：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="report.reportName" cssStyle="width:100%" maxlength="50" />
						</td>
						<td align="left" class="listtabletr11">
							报表编号：
						</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="report.reportCode" cssStyle="width:100%"
								maxlength="50" />
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td align="left" class="listtabletr11">
							填报单位：
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="report.unit"
								name="report.unit" cssStyle="width:90%"
								hiddenName="report.unitId"
								hiddenId="report.unitId"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/searchdata.jsp?url=${pageContext.request.contextPath}/systemnew/orgList.action&p_item=1&orgtype=1&paraname=report.unit&paraid=report.unitId',600,350,'组织机构选择')"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" readonly="true"/>
						</td>
						<td align="left" class="listtabletr11">
							填报人：
						</td>
						<td align="left" class="listtabletr22">
							<s:buttonText2 id="report.creator"
								name="report.creator" cssStyle="width:90%"
								hiddenId="report.creatrorId"
								hiddenName="report.creatrorId"
								doubleOnclick="showPopWin('${pageContext.request.contextPath}/pages/system/search/frameselect4s.jsp?url=${pageContext.request.contextPath}/pages/system/userindex.jsp&paraname=report.creator&paraid=report.creatrorId',600,350)"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" />
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td align="right" class="listtabletr1" colspan="4">
							<DIV align="right">
								<s:submit value="查询" />
								&nbsp;
								<input type="button" value="重置"
									onclick="window.location.href='${pageContext.request.contextPath}/ccReport/reportList.action'">
							</DIV>
						</td>
					</tr>
				</table>
			</s:form>
			<s:form namespace="/ccReport" action="delReport">
				<display:table requestURI="reportList.action" name="reportList"
					id="row" pagesize="${baseHelper.pageSize}" partialList="true"
					size="${baseHelper.totalRows}" class="its">
					<display:column title="选择" style="text-align:center;width:30px"
						headerClass="center">
						<input type="checkbox" name="ids" value="${row.id}"
							onclick="checkButton()">
						<s:hidden id="${row.id}_unit" value="${row.unitId}"></s:hidden>
						<s:hidden id="${row.id}_flag" value="${row.declearFlag}"></s:hidden>
					</display:column>
					<display:column title="报表名称" sortable="true" sortName="false"
						headerClass="center" style="text-align:center">
						<a href="${contextPath}/ccReport/editReport.action?id=${row.id}">${row.reportName}</a>
					</display:column>
					<display:column property="reportCode" title="报表编号" sortable="true"
						sortName="false" headerClass="center" style="text-align:center" />
					<display:column property="unit" title="填报单位" sortable="true"
						sortName="false" headerClass="center" style="text-align:center" />
					<display:column property="creator" title="填报人" sortable="true"
						sortName="false" headerClass="center" style="text-align:center" />
					<display:column title="统计期间" sortable="true" sortName="false"
						headerClass="center" style="text-align:center">
						${row.starttime }~${row.endtime }
					</display:column>
					<display:column title="状态" sortable="false" sortName="false"
						headerClass="center" style="text-align:center">
						<s:if test="${row.declearFlag == 1}">
							<a><font color="red">已上报</font>
							</a>
						</s:if>
						<s:else>
							<a>未上报</a>
						</s:else>
					</display:column>
				</display:table>
				<br>
				<div align="right">
					<s:button value="添加" onclick="addReport(); "></s:button>
					&nbsp;&nbsp;
					<s:submit value="删除"></s:submit>
					&nbsp;&nbsp;
					<s:button onclick="openImport();" value="导入"></s:button>
					&nbsp;&nbsp;
					<s:button value="上报" id="declareButton" onclick="delcareReport();"
						disabled="true"></s:button>
					&nbsp;&nbsp;
					<s:button value="取消下级上报" id="cancelButton"
						onclick="cancelDelcareReport();" disabled="true"></s:button>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</s:form>
		</center>
	</body>
</html>