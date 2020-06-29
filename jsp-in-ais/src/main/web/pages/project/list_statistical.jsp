<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目统计分析表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css" />
<script type="text/javascript">
    
</script>
<style type="text/css">

*{ margin:0px; padding:0px;}
body{font-size:12px; line-height:24px;padding-top:20px; margin:0px; margin-left:auto; margin-right:auto;}
td{ height:25px;}

</style>
	</head>
	<body align="center">
 		<div style="text-align:center;">
 			<div style="margin-top:35px;">
 				<h3>${requestScope.statis.year }年 审计项目统计分析表</h3>
 			</div>
 			
 			<div style="margin-top:10px;">
		 		<table style='font-size:12px;margin-left:50px;margin-top:5px;width:900px;border:1px solid gray;border-collapse:collapse;align:center' id="tab" >
					<tr style='height:10px;background-color:#CCECFF'>
						<td style='border:1px solid #cccccc; text-align:center;'><b>部门</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>计划项目数</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>进行项目数</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>完成项目数</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>项目开展率</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>项目完成率</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>发现问题数</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>整改问题数</b></td>
						<td style='border:1px solid #cccccc; text-align:center;'><b>问题整改率</b></td>
					</tr>
					<c:forEach items="${requestScope.listSta}" var="s" varStatus="status">
						<c:choose>
							<c:when test="${status.index % 2 == 0}">
								<tr bgcolor="#FFFFFF">
							</c:when>
							<c:otherwise>
								<tr bgcolor="#DBE5F1">
							</c:otherwise>
						</c:choose>			
							<td style='border:1px solid #cccccc;'>${s.uorg_name }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.planN }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.processN }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.completeN }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.developS }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.completeS }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.find_problemN }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.rectify_problemN }</td>
							<td style='border:1px solid #cccccc;'>${pageScope.s.problem_rectifyS }</td>
						</tr>
					</c:forEach>
					<tr>
						<td style='border:1px solid #cccccc; text-align:center;'><b>合计：</b></td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.planN }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.processN }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.completeN }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.developS }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.completeS }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.find_problemN }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.rectify_problemN }</td>
						<td style='border:1px solid #cccccc;'>${requestScope.statis.problem_rectifyS }</td>
					</tr>
				</table>
				<br>
			</div>
		</div>
	</body>
</html>
