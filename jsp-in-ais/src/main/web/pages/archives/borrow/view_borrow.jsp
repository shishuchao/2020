<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>档案借阅流程-查看</title>
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>

	<body>
		<center>
			归档流程 ---
			<a style="cursor:hand" onclick="javascript:window.print();">打印</a>
			<s:form action="view" namespace="/archives/borrow">
			
				<%@include file="/pages/archives/pigeonhole/view_project_start.jsp"%>
				
	<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">


						<td align="left" class="listtabletr1">
							档案名称
						</td>
						<td class="listtabletr2" align="right" colspan="3">
							<s:property value="crudObject.project_name" />
						</td>
					</tr>



					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							档案类型
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_type_name" />
						</td>

						<td align="left" class="listtabletr1">
							档案状态
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_status_name" />
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							档案年度
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_year" />
						</td>

						<td align="left" class="listtabletr1">
							<!-- 档案保存期限（年） -->
						</td>
						<td class="listtabletr2" align="right">
						<%-- 	<s:property value="pigeonholeObject.archives_save_year" /> --%>
						</td>
					</tr>

					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							秘密等级
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_secrecy_name" />
						</td>



						<td align="left" class="listtabletr1">
							所属部门
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_unit_name" />
						</td>
					</tr>



					<tr class="listtablehead">
						<td align="left" class="listtabletr1">
							归档发起人
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_start_man_name" />
						</td>


						<td align="left" class="listtabletr1">
							归档日期
						</td>
						<td class="listtabletr2" align="right">
							<s:property value="pigeonholeObject.archives_time" />
						</td>
					</tr>
				</table>
				
				
				
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					
					<tr>
						<td class="ListTableTr11">
						内部借阅人
						</td>
						<td class="ListTableTr22">
									<s:property value="crudObject.in_borrow_man_name" />

						</td>
						<td class="ListTableTr11">
							内部借阅人单位
						</td>
						<td class="ListTableTr22">
								<s:property value="crudObject.in_borrow_unit_name" />
								</td>
					</tr>
				
				
					<tr>
						<td class="ListTableTr11">
						借阅发起人
						</td>
						<td class="ListTableTr22">
							<s:property value="crudObject.start_borrow_man_name" />
						</td>
						<td class="ListTableTr11">
							借阅发起人单位
						</td>
						<td class="ListTableTr22">
								<s:property value="crudObject.start_borrow_unit_name" />
								</td>
					</tr>
					
					
									
														<tr>
						<td class="ListTableTr11">
						借阅起始时间
						</td>
						<td class="ListTableTr22">
						<s:property value="crudObject.start_borrow_time" />
						</td>
						<td class="ListTableTr11">
							借阅结束时间
						</td>
						<td class="ListTableTr22">
						<s:property value="crudObject.end_borrow_time" />
								</td>
					</tr>
				
					<tr>
						<td class="ListTableTr11">
							借阅理由
						</td>
						<td class="ListTableTr22" colspan="3">
								<s:property value="crudObject.borrow_reason" />
						</td>
					</tr>
				
				
				
				
			</table>	
				
				
				
				
				
			

<%@include file="/pages/bpm/list_taskinstanceinfo.jsp"%>

				<s:hidden name="crudId" />
				<s:hidden name="taskInstanceId" />






			</s:form>

		</center>
	</body>
</html>
