<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/assist/baseInfo/dept.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="ajax" />
<title></title>
<script type="text/javascript">
	function addAssetsFunds(){
		var str="<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!editFunds.action?deptInfo.orgId=${deptInfo.orgId}&funds.fk=${deptInfo.id}";
		window.location.href=str;
	}
	function editDeptInfo(){
		var str="<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!editDept.action?deptInfo.orgId=${deptInfo.orgId}&status=1";
		window.location.href=str;
	}
</script>
</head>
<body>
<s:form action="baseInfoAction!saveDept" namespace="/assist/baseInfo" onsubmit="return chkDeptInfo()">
	<s:hidden name="deptInfo.orgId"></s:hidden>
	<s:hidden name="deptInfo.id"></s:hidden>
	<table id='tab1' cellpadding=0 cellspacing=1 border=0
							bgcolor="#409cce" class="ListTable">
		<tr>
			<td class="ListTableTr11" >单位名称</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.unitName" value="${deptInfo.unitName}"/>
			</s:if>
			<s:else>
				${deptInfo.unitName}
			</s:else>
			</td>
			<td class="ListTableTr11">单位地址</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.unitAdress" value="${deptInfo.unitAdress}"/>
			</s:if>
			<s:else>
				${deptInfo.unitAdress}
			</s:else>
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11">邮寄地址</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.postAdress" value="${deptInfo.postAdress}"/>
			</s:if>
			<s:else>
			${deptInfo.postAdress}
			</s:else>
			</td>
			<td class="ListTableTr11">邮政编码</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.postCode" value="${deptInfo.postCode}"/>
			</s:if>
			<s:else>
				${deptInfo.postCode}
			</s:else>
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11">交换箱号</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.chgCode" value="${deptInfo.chgCode}"/>
			</s:if>
			<s:else>
				${deptInfo.chgCode}
			</s:else>
			</td>
			<td class="ListTableTr11"></td>
			<td class="ListTableTr22"></td>
		</tr>
		<tr>
			<td class="ListTableTr11" colspan="4" style="text-align: center;">法人代表</td>
		</tr>
		<tr>
			<td class="ListTableTr11" >姓名</td>
			<td class="ListTableTr22">
				<s:if test="${status==1}">
			<s:textfield name="deptInfo.name" value="${deptInfo.name}"/>
			</s:if>
			<s:else>
				${deptInfo.name}
			</s:else>
			</td>
			<td class="ListTableTr11" >联系电话</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.contactPhone" value="${deptInfo.contactPhone}"/>
			</s:if>
			<s:else>
				${deptInfo.contactPhone}
			</s:else>
			</td>
		</tr>
		<tr>
			<td class="ListTableTr11" colspan="4" style="text-align: center;">主管审计领导</td>
		</tr>
		<tr>
			<td class="ListTableTr11" >姓名</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.name2" value="${deptInfo.name2}"/>
			</s:if>
			<s:else>
				${deptInfo.name2}
			</s:else>
			</td>
			<td class="ListTableTr11" >联系电话</td>
			<td class="ListTableTr22">
			<s:if test="${status==1}">
			<s:textfield name="deptInfo.contactPhone2" value="${deptInfo.contactPhone2}"/>
			</s:if>
			<s:else>
				${deptInfo.contactPhone2}
			</s:else>
			</td>
		</tr>
	</table>
	<display:table name="list" id="row" requestURI="${contextPath}/assist/baseInfo/baseInfoAction!editDept.action?deptInfo.orgId=${deptInfo.orgId}&status=${status}" class="its"
				pagesize="20" excludedParams="*" style="word-break:break-all; word-wrap: break-word;">
		<display:column property="year" title="年度" sortable="true" headerClass="center" style="width:40px;">
		</display:column>
		<display:column property="assets" title="资产" sortable="true" headerClass="center" style="white-space:nowrap; width:80px;">
		</display:column>
		<display:column property="indebted" title="负债" sortable="true" headerClass="center">
		</display:column>
		<display:column property="equities" title="权益" sortable="true" headerClass="center">
		</display:column>
		<display:column property="pl" title="损益" sortable="true" headerClass="center">
		</display:column>
		<display:column property="comNo" title="分公司数量" sortable="true" headerClass="center">
		</display:column>
		<display:column property="subNo" title="子公司数量" sortable="true" headerClass="center">
		</display:column>
		<display:column property="planFund" title="计划" sortable="true" headerClass="center">
		</display:column>
		<display:column property="pracFund" title="实际" sortable="true" headerClass="center">
		</display:column>
		<s:if test="${status==1}">
		<display:column title="操作"  headerClass="center">
			<a href="<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!delFunds.action?funds.id=${row.id}&deptInfo.orgId=${deptInfo.orgId}&status=1">删除</a>
			<a href="<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!editFunds.action?funds.id=${row.id}&deptInfo.orgId=${deptInfo.orgId}&status=1">修改</a>
		</display:column>
		</s:if>
		<s:else>
		<% /**查看看的可能操作*/ %>
		</s:else>
	</display:table>
	<s:if test="${status==1}">
	<s:submit value="保存"/>
	<s:hidden name="status"/>
	<s:if test="${not empty(deptInfo.id) and deptInfo.id!=0}">
		<s:button value="增加资产和经费" onclick="addAssetsFunds();"/>
	</s:if>
	</s:if>
	<s:elseif test="${status==3}">
		<s:button value="编辑" onclick="editDeptInfo();"/>
	</s:elseif>
</s:form>
</body>
</html>