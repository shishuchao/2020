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
	</head>
	<body>
		<center>
			<div id="listDiv" align="center">
				<s:hidden id="categoryId" name="categoryId" />
				<display:table id="row" name="ceshiList" class="its" length="100"
					requestURI="${contextPath}/nkcp/listCeShi.action">
					<display:column title="选择" headerClass="center" class="center">
						<input type="checkbox" name="id" value="${row.id}"/>
						<input type="hidden" id="${row.id}_isSuit" value="${row.isSuit}" />
						<input type="hidden" id="${row.id}_result" value="${row.result}" />
					</display:column>
					<display:column property="muBiao" title="测试目标" headerClass="center" 
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column property="ruoDian" title="弱点分析" headerClass="center" 
						style="WHITE-SPACE: nowrap" sortable="true" />
					<display:column title="是否适用" sortable="true" headerClass="center" 
						style="WHITE-SPACE: nowrap" property="isSuit" class="center"  />
					<display:column title="风险评估" sortable="true" headerClass="center" 
						style="WHITE-SPACE: nowrap" property="result" maxWords="100"/>
					<display:column title="查看" headerClass="center" class="center"
						media="html" style="WHITE-SPACE: nowrap">
						<a href="${contextPath}/nkcp/viewCeShi.action?ceShi.id=${row.id}">详细内容</a>
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
			<input id="calcButton" type="button" value="查看测试结论"
				onclick="calcCeShi()" />
		</div>

		<script type="text/javascript">

			/*
			*	查看测试结论
			*/
			function calcCeShi(){
				var ids = document.getElementsByName("id");
				var rdcount = 0; //测试项总个数
				var yescount = 0; //适用测试项总个数
				var sum = 0; //总得分
				for(var i=0;i<ids.length;i++){
					rdcount = rdcount + 1;
					var isSuit = document.getElementById(ids[i].value+"_isSuit").value;
					if(isSuit=='是'){ //适用的测试
						yescount = yescount + 1;
						var result = document.getElementById(ids[i].value+"_result").value;
						if(result=='高'){
							sum = sum + 10;
						}else if(result=='中'){
							sum = sum + 5;
						}
					}
				}
				if(rdcount==0){
					alert("无测试项统计");
				}else if(yescount==0){
					alert("无适用测试内容");
				}else{
					sum = sum / yescount;
					if(sum == 10){
						alert("综合风险高");
					}else if(sum >= 5 && sum < 10){
						alert("综合风险较高");
					}else if(sum < 5){
						alert("综合风险低");
					}
				}
			}
		
			/*
				新增明细计划
			*/
			function addCeShi(){
				var categoryId = document.getElementById('categoryId').value;
				window.location.href="${contextPath}/nkcp/editCeShi.action?ceShi.categoryId="+categoryId;
			}
			
			/*
				删除明细计划
			*/
			function deleteCeShi(){
				var categoryId = document.getElementById('categoryId').value;
				var ids = document.getElementsByName("id");
				for(var i=0;i<ids.length;i++){
					if(ids[i].checked){
						window.location.href="${contextPath}/nkcp/deleteCeShi.action?ceShi.categoryId="+categoryId+"&ceShi.id="+ids[i].value;
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
						window.location.href="${contextPath}/nkcp/editCeShi.action?ceShi.categoryId="+categoryId+"&ceShi.id="+ids[i].value;
					}
				}
			}
		</script>

	</body>
</html>