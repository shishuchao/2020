<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>中介机构执业资质列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>	
	</head>
	<body>
		<s:form namespace="/project/integory">
			<table cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead"><s:hidden name="integoryId"/>
					<td align="left" class="listtabletr1">
						颁发单位
					</td>
					<TD class="listtabletr1">
						<s:textfield name="integoryAptitude.promulgateUnit" />
					</TD>
					<TD align="center" class="listtabletr1">
						取得日期
					</TD>
					<TD class="listtabletr1">
						<s:textfield name="promulgateDate1" readonly="true"  title="单击选择日期" size="37" onclick="calendar()" cssClass="width:30px"></s:textfield>
						--<s:textfield name="promulgateDate2" readonly="true"  title="单击选择日期" size="37" onclick="calendar()" cssClass="width:30px"></s:textfield>
					</TD>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="listtabletr1">
						<div align="right">
							<s:submit action="searchAptitude" value="查询"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:reset value="重置" />
						</div>
					</td>
				</tr>
			</TABLE>
			<s:hidden name="listStatus"/>
		</s:form>
		<s:form namespace="/resmngt/integory">
			<display:table requestURI="${contextPath}/resmngt/integory/integoryAptitude_List.action" name="apList" id="row" class="its" pagesize="5">
				<display:column>
						<input type="checkbox" name="integoryAptitude_ids" value="${row.id}">
				</display:column>
				<display:column property="aptitudeName" title="执行资格证类型" sortable="true" headerClass="center" class="center" />
				<display:column title="资格证号" sortable="true" headerClass="center" class="center" >
					<a href="${contextPath}/resmngt/integory/aptitudeInfo.action?aptitudeId=${row.id}">${row.code}</a>
				</display:column>
				<display:column property="promulgateUnit" title="颁发单位" sortable="true" headerClass="center" class="center" />
				<display:column property="promulgateDate" title="取得日期" sortable="true" headerClass="center" class="center" />
				<display:column property="checkDate" title="年检日期" sortable="true" headerClass="center" class="center" />
				<display:column property="checkResult" title="年检结果" sortable="true" headerClass="center" class="center" />
			</display:table>
				<div align="right">
					<input type="button" value="增加" onclick="window.location.href='${contextPath}/resmngt/integory/addAptitude.action?integoryId=${integoryId }'">
					&nbsp;&nbsp;
					<s:submit onclick="return window.confirm('确认删除吗？')" action="delAptitude" value="删除"/>
					&nbsp;&nbsp;
					<s:submit action="midofyAptitude" value="修改" />
					&nbsp;&nbsp;
				
				</div>
			<s:hidden name="integoryId"/>
		</s:form>
	</body>
</html>