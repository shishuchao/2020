<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
	</head>
	<body>
		<s:form name="myForm" namespace="/ledger/ledgerAnalyse"
			action="exportExcel">
			<table cellpadding=4 cellspacing=0 border=1>
				<tr>
					<c:forEach items="${head_list}" var="heads">
						<td bgcolor="#F5F5F5">
							<p align="center">
								${heads}
							</p>
						</td>
					</c:forEach>
				</tr>
				<c:forEach items="${list}" varStatus="status" var="statisticInfos">
					<tr>
						<c:forEach items="${statisticInfos}" var="statisticInfo"
							varStatus="status">
							<td>
								<p align="center">
									${statisticInfo}
								</p>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
			<p align="left">
				<c:forEach items="${unitSumMap}" var="map">
				 ${map.key}: ${map.value} &nbsp;&nbsp;
				</c:forEach>
			</p>
			<s:hidden name="headNames"></s:hidden>
			<s:hidden name="hql"></s:hidden>
			<p align="right">
				<s:submit value="导出Excel" />
			</p>
		</s:form>
	</body>
</html>