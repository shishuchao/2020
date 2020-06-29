<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>
			本级报表
		</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<s:head theme="simple" />
		<script type="text/javascript">
			
		</script>
	</head>
	<body>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
					<!--		
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/cell/thisLevelList.action')" />
						  -->
						<s:property value="#title" />
					</td>
				</tr>
			</table>
		<center>
		
		<s:select list="seasonList" listKey="code" listValue="name"
				name="season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
				
		</center>
	</body>
	<script type="text/javascript">
		function getReportList(){
			
		}
	
		function sumTotal(){
			var season = document.getElementById('season').value;
			if(season != ''){
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/report/cell', action:'checkIsEnableSum', executeResult:'false' }, 
					{'season':season},
					xxx
				);
				function xxx(data){
					isEnableSum = data['isEnableSum'];
					alert(isEnableSum);
					if(isEnableSum=="true"){
						document.location="sum.action?season="+season;
					}else{
						alert("已经存在当前季度的汇总报表了,不能重复汇总.");
					}
				}
			}
			
		}
	</script>
</html>
