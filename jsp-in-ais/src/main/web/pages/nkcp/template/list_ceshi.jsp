<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>内控测试列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	</head>
	<body>
		<center>
			<div id="listDiv" align="center">
				<s:hidden id="categoryId" name="categoryId" />
				<display:table id="row" name="ceshiList" class="its" length="100"
					requestURI="${contextPath}/nkcp/template/listCeShi.action">
					<display:column title="选择" headerClass="center" class="center">
						<input type="checkbox" name="id" value="${row.id}"/>
					</display:column>
					<display:column property="muBiao" title="测试目标" headerClass="center" 
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column title="查看" headerClass="center" class="center"
						media="html" style="WHITE-SPACE: nowrap">
						<a href="${contextPath}/nkcp/template/viewCeShi.action?ceShi.id=${row.id}">详细内容</a>
					</display:column>
				</display:table>
			</div>
		</center>
		<div id="buttonDiv" align="right" style="width: 97%;margin-top: 10px;">
			<input id="addButton" type="button" value="新增测试项"
				onclick="addCeShi()" />
			<input id="deleteButton" type="button" value="删除测试项"
				onclick="deleteCeShi()" />
			<input id="updateButton" type="button" value="修改测试项"
				onclick="updateCeShi()" />
		</div>

		<script type="text/javascript">

			/*
				新增明细计划
			*/
			function addCeShi(){
				var categoryId = document.getElementById('categoryId').value;
				window.location.href="${contextPath}/nkcp/template/editCeShi.action?ceShi.categoryId="+categoryId;
			}
			
			/*
				删除明细计划
			*/
			function deleteCeShi(){
				var categoryId = document.getElementById('categoryId').value;
				var ids = document.getElementsByName("id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						window.location.href="${contextPath}/nkcp/template/deleteCeShi.action?ceShi.categoryId="+categoryId+"&ceShi.id="+ids[i].value;
					}
				}
			}
			
			/*
				修改明细计划
			*/
			function updateCeShi(){
				var categoryId = document.getElementById('categoryId').value;
				var ids = document.getElementsByName("id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						window.location.href="${contextPath}/nkcp/template/editCeShi.action?ceShi.categoryId="+categoryId+"&ceShi.id="+ids[i].value;
					}
				}
			}
		</script>

	</body>
</html>