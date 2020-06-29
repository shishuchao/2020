<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
		<title>风险管理报告</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/resources/css/site.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css"	href="${contextPath}/resources/csswin/subModal.css" />
		<style type="text/css"> 
			#container{
				width:100%;height: 100%;
			}
			#content2{
				width: 1.5%;text-align: left;float: left;height: 100%;
			}
			#content{
				width: 18%;text-align: left;float: left;height: 100%;
			}
			#sidebar{
				width: 80%;text-align: left;float: right;height: 100%;
			}
		</style>
		<script type="text/javascript"	src="${contextPath}/scripts/treepanel/common.js"></script>
		<script type="text/javascript"	src="${contextPath}/scripts/treepanel/TreePanel.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript"	src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"	src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/validate.js"></script>
		<script type="text/javascript">
			function RightGo(node){
				document.location="${contextPath}/resmngt/risk/index4view.action?helper.risk.riskType="+node.id;
			}
			function mySearchSubmit(){
				if(document.getElementById("helper.risk.year").value!=''){
							if(!isPlusInteger(document.getElementById("helper.risk.year").value)){
							alert("年度 只能输入正整数,请重新输入");
							document.getElementById("helper.risk.year").focus();
							return false;
							}
						}
				riskSearchForm.submit();
			}
			function myReset(){
				document.getElementsByName("helper.risk.title")[0].value = "";
				document.getElementsByName("helper.risk.year")[0].value = "";
				document.getElementsByName("helper.risk.uploaderName")[0].value = "";
				document.getElementsByName("helper.risk.uploadDeptName")[0].value = "";
				document.getElementsByName("helper.risk.uploadDept")[0].value = "";
				window.location ="${pageContext.request.contextPath}/resmngt/risk/index4view.action"
			}
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('searchTable').style.display;
				if(isDisplay==''){
					document.getElementById('searchTable').style.display='none';
				}else{
					document.getElementById('searchTable').style.display='';
				}
			}
			<s:if test="${!empty(riskTypeJson)}">
				TreeNode.prototype.paintChildren=function(){
					if(!this.childrenRendered){
						this['html-element']['child'].innerHTML = '';
						this.childrenRendered = true;
						var childNodes = this.childNodes;
						for(var i=0;i < childNodes.length;i++){
							childNodes[i].render();
							childNodes[i].expand();
						}
					};
				}
				var tree = new TreePanel({
					'root' : ${riskTypeJson}
				});
				function drawTree(){
					tree.container = document.getElementById('content');
					tree.addListener('click',RightGo);
					tree.iconPath='${contextPath}/scripts/treepanel/img/';
					tree.showSelectBox = false;
					tree.checkChild=false;
					tree.isExpand=false;
					tree.render();
					tree.getRootNode()['html-element']['checkbox'].style.display='none';
					tree.getRootNode().expand();
				}
			</s:if>
			<s:else>
				function drawTree(){}
			</s:else>
		</script>
</head>
<body onload="drawTree()">
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
		class="ListTable" width="100%" align="center">
		<tr class="listtablehead">
			<td colspan="4" class="edithead"
				style="text-align: left; width: 100%;">
				<div style="display: inline; width: 80%;">
					<s:property escape="false"
						value="@ais.framework.util.NavigationUtil@getNavigation('/ais/resmngt/risk/index4view.action')" />
				</div>
				<div style="display: inline; width: 20%; text-align: right;">
					<a href="javascript:;" onclick="triggerSearchTable();">查询条件</a>
				</div>
			</td>
		</tr>
	</table>
	<s:hidden name="riskTypeId"></s:hidden>
	<div id="container">
	<div id="content2">
	  </div>
	  <div id="content">
	  </div>
	  <div id="sidebar">
	  	<center>
	  	<s:form action="index4view" namespace="/resmngt/risk" method="post" name="riskSearchForm" id="riskSearchForm"> 
	  	<s:hidden name="helper.risk.riskType"/>
	  		<table id="searchTable" style="display: none;" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						风险报告名称
					</td>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.title" />
					</TD>
					<TD align="center" class="listtabletr1">
						年度
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.year" />
					</TD>
				</tr>
				<tr class="listtablehead">
					<TD class="listtabletr1">
						上传人
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="helper.risk.uploaderName" />
					</TD>
					<TD align="center" class="listtabletr1" id="company1">
						上传单位
					</TD>
					<TD class="listtabletr1" id="company2">
							<s:buttonText name="helper.risk.uploadDeptName" id="uploadDeptName" hiddenId="uploadDept" hiddenName="helper.risk.uploadDept" cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=helper.risk.uploadDeptName&paraid=helper.risk.uploadDept&p_item=0&orgtype=1',600,350,'所属单位')"
							doubleSrc="/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:button value="查询" onclick="mySearchSubmit()"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:button value="重置" onclick="myReset()"></s:button>
							&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</TABLE>
		</s:form>
				<s:hidden name="riskTypeId" value="${riskTypeId}"></s:hidden>
				<display:table name="result" id="rows" class="its"
					requestURI="/resmngt/risk/index4view.action"
					pagesize="${helper.pageSize}" partialList="true" 
					size="${helper.totalRows}">
					<display:column title="风险报告名称" headerClass="center" sortable="true" 
						style="word-break : break-all " sortName="title">
						<a href="${contextPath }/resmngt/risk/view.action?riskId=${rows.riskId}&riskTypeId=${rows.riskType}">${rows.title }</a>
					</display:column>
					<%--<display:column title="风险来源" property="sourceType" headerClass="center" sortable="true" 
						style="width:80;word-break : break-all " sortName="sourceType"/>
					<display:column title="风险因素" property="reason" headerClass="center" sortable="true" 
						style="width:80;word-break : break-all " sortName="reason"/>
					--%><display:column title="年度" property="year" headerClass="center" sortable="true" 
						style="width:80px;word-break : break-all " sortName="year"/>
					<display:column title="上传人" property="uploaderName" headerClass="center" sortable="true" 
						style="width:80px;word-break : break-all " sortName="uploaderName"/>
					<display:column title="上传单位" property="uploadDeptName" headerClass="center" sortable="true" 
						style="width:20%;" sortName="uploadDeptName"/>
					<display:column title="上传时间" property="uploadTime" headerClass="center" sortable="true" 
						style="width:20%;word-break : break-all " sortName="uploadTime"/>
				</display:table>
	  	</center>
	  </div>
	</div>
</body>
</html>