<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>借阅日志列表 
		</title>
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	<script type="text/javascript">
	/*
	 *借阅查看
	 */
 	function toDetaile(project_id,borrowFormId){
		var url = '${contextPath}/archives/workprogram/pigeonhole/detail.action?borrowFormId='+borrowFormId+'&&project_id='+project_id+"&&borrowTimes=true";
		window.location = url;
	}
	</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
				class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						档案管理==>借阅管理==> 借阅日志列表 
						
					</td>
				</tr>
			</table>	
		
			<display:table name="allArchivesList" id="row" 
				requestURI="/archives/borrow/viewPowerRecord.action"
				pagesize="15" class="its" cellpadding="1">
				<display:column  title="档案名称" property="archive_name"></display:column>
				<display:column property="start_borrow_man_name" title="借阅发起人"></display:column>
				<display:column property="start_borrow_unit_name" title="借阅发起人单位"></display:column>
				<display:column property="in_borrow_man_name" title="内部借阅人"></display:column>
				<display:column property="in_borrow_unit_name" title="内部借阅人单位"></display:column>
				<display:column property="start_borrow_time" title="起始时间"></display:column>
				<display:column property="end_borrow_time" title="结束时间"></display:column>
                <display:column  title="借阅记录"><s:a href="javascript:;"  onclick="toDetaile('${row.project_id}','${row.formId}');">查看</s:a></display:column>
			    <display:setProperty name="paging.banner.placement" value="bottom" />
			</display:table>
			<br>
			<div align="center"><s:submit  value="关 闭" onclick="window.close();"/>&nbsp;&nbsp;&nbsp;</div>

		</center>
	</body>
</html>
