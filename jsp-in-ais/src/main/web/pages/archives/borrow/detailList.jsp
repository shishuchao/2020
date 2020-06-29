<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title><s:property value="processName" />
		</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<script type="text/javascript">
	
		 	function toDetaile(borrowFormId,operateSystemType){
				var url = '${contextPath}/archives/workprogram/pigeonhole/detail.action?borrowFormId='+borrowFormId+'&&project_id=<s:property value="project_id"/>';
				window.location = url;
			}
				//返回上一页
			function backs(){
				window.history.back();
			}
			
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" class="edithead" style="text-align: left;width: 100%;">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('${contextPath}/archives/borrow/archivesOverList.action')"/>==&gt;
						借阅日志列表
					</td>
				</tr>
			</table>
			
			<display:table name="allArchivesList" id="row" 
				requestURI="/archives/borrow/detailList.action"
				pagesize="15" class="its" cellpadding="1">
				<display:column  title="档案名称" property="archive_name"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="start_borrow_man_name" title="借阅发起人"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="start_borrow_unit_name" title="借阅发起人单位"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="in_borrow_man_name" title="内部借阅人"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="in_borrow_unit_name" title="内部借阅人单位"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="start_borrow_time" title="起始时间"></display:column>
				<display:column style="WHITE-SPACE: nowrap" property="end_borrow_time" title="结束时间"></display:column>
                   <display:column  title="操作"><s:a href="javascript:;"  onclick="toDetaile('${row.formId}','${row.operateSystemType}');">详细</s:a></display:column>
			    <display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>
			<br>
			<div align="right"><s:submit  value="返 回" onclick="backs()"/>&nbsp;&nbsp;&nbsp;</div>
		</center>
	</body>
</html>
