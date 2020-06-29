<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<HTML>
	<HEAD>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:text id="title" name="'报表汇总'"></s:text>
		<title><s:property value="#title" />列表</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/checkboxsoperation.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>	
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		
		<script language="javascript">
			   
			function getReportList(){
				document.forms[0].submit();
			}
			
			function sumHandler(){
				var ids =document.getElementsByName("ids");
				var num = 0;
				for(var i=0;i<ids.length;i++){
					if(ids(i).checked==true){
						num++;					
					}
				}
				if(num<1){
					alert("请选择需要汇总的记录！");
					return;
				}
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
						if(isEnableSum=="true"){
							myform.action = "${contextPath}/report/cell/sum.action";
							myform.target = "_parent";
							myform.submit();
						}else{
							alert("已经存在当前季度的汇总报表了,不能重复汇总.");
							return;
						}
					}
				}
			}
		</Script>
	</HEAD>

	<BODY topmargin=8 leftmargin=8>
	<s:form id="myform" namespace="/report/cell" action="searchSum4ReportList" method="post">
		<table>
					<tr class="listtablehead">
						<td align="left" class="listtabletr22">
							汇总季度:<s:select list="seasonList" listKey="code" listValue="name" onchange="getReportList()"
								name="season" id="season" cssStyle="WIDTH: 150px; HEIGHT: 23px"></s:select>
						</td>
					</tr>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
		</table>
		
		<display:table requestURI="searchSum4ReportList.action" name="stores" id="row" 
				sort="external" class="its" >
				<display:column title="选择" media="html" headerClass="center"
						style="WHITE-SPACE: nowrap" class="center">
						<input type="checkbox" name="ids" value="${row.id}" />
				</display:column>
				
				<display:column title="报表名称" headerClass="center" sortable="true" sortName="reportCode" style="height:23px;text-align:center">
					${row.reportCode}
				</display:column>
				<display:column title="所属单位" property="generateDeptName" headerClass="center" style="text-align:center" sortName="false">
				</display:column>
				
			</display:table>
			<div align="right">
				<s:button value="汇  总" onclick="sumHandler();" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<s:button  value="关  闭" onclick="refreshParent()" /> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			</s:form>
	</BODY>
	<script type="text/javascript">
		function refreshParent() { 
			//window.parent.document.location = "thisLevelList.action";
			window.parent.hidePopWin(false);
		} 
	</script>
</HTML>
