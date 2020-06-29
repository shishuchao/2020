<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>内控调查列表</title>
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
				<s:hidden id="categoryId" name="categoryId"/>
				<display:table id="row" name="diaoChaList" class="its" 
					requestURI="${contextPath}/nkcp/listDiaoCha.action">
					<display:column title="选择" headerClass="center" class="center">
						<input type="checkbox" name="id" value="${row.id}"/>
						<input type="hidden" id="${row.id}_isSuit" value="${row.isSuit}" />
						<input type="hidden" id="${row.id}_result" value="${row.result}" />
					</display:column>
					<display:column property="content" title="调查内容" headerClass="center" 
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column title="是否适用" sortable="true" headerClass="center" 
						style="WHITE-SPACE: nowrap" property="isSuit" class="center"  />
					<display:column title="调查结果" sortable="true" headerClass="center" 
						style="WHITE-SPACE: nowrap" property="result" maxWords="100"/>
					<display:column title="查看" headerClass="center" class="center"
						media="html" style="WHITE-SPACE: nowrap">
						<a href="${contextPath}/nkcp/viewDiaoCha.action?diaoCha.id=${row.id}">详细内容</a>
					</display:column>
				</display:table>
			</div>
		</center>
		<div id="buttonDiv" align="right" style="width: 97%;margin-top: 10px;">
			<input id="addButton" type="button" value="新增调查项"
				onclick="addDiaoCha()" />
			<input id="deleteButton" type="button" value="删除调查项"
				onclick="deleteDiaoCha()" />
			<input id="updateButton" type="button" value="修改调查项"
				onclick="updateDiaoCha()" />
			<input id="calcButton" type="button" value="查看调查结论"
				onclick="calcDiaoCha()" />
		</div>

		<script type="text/javascript">
		
			/*
			*	查看调查结论
			*/
			function calcDiaoCha(){
				var ids = document.getElementsByName("id");
				var rdcount = 0; //调查项总个数
				var yescount = 0; //适用调查项总个数
				var sum = 0; //总得分
				for(var i=0;i<ids.length;i++){
					rdcount = rdcount + 1;
					var isSuit = document.getElementById(ids[i].value+"_isSuit").value;
					if(isSuit=='是'){ //适用的调查
						yescount = yescount + 1;
						var result = document.getElementById(ids[i].value+"_result").value;
						if(result=='是'){
							sum = sum + 10;
						}else if(result=='弱'){
							sum = sum + 5;
						}
					}
				}
				if(rdcount==0){
					alert("无调查项统计");
				}else if(yescount==0){
					alert("无适用调查内容");
				}else{
					sum = sum / yescount;
					if(sum >= 5 && sum <= 10){
						alert("可进行进一步内控测试");
					}else if(sum < 5){
						alert("不建议进行内控测试，而直接进入实质性测试");
					}
				}
			}

			/*
				新增明细计划
			*/
			function addDiaoCha(){
				var categoryId = document.getElementById('categoryId').value;
				window.location.href="${contextPath}/nkcp/editDiaoCha.action?diaoCha.categoryId="+categoryId;
			}
			
			/*
				删除明细计划
			*/
			function deleteDiaoCha(){
				var categoryId = document.getElementById('categoryId').value;
				var ids = document.getElementsByName("id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						window.location.href="${contextPath}/nkcp/deleteDiaoCha.action?diaoCha.categoryId="+categoryId+"&diaoCha.id="+ids[i].value;
					}
				}
			}
			
			/*
				修改明细计划
			*/
			function updateDiaoCha(){
				var ids = document.getElementsByName("id");
				var categoryId = document.getElementById('categoryId').value;
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						window.location.href="${contextPath}/nkcp/editDiaoCha.action?diaoCha.categoryId="+categoryId+"&diaoCha.id="+ids[i].value;
					}
				}
			}
		</script>

	</body>
</html>