<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>项目计划</title>
		<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>    --%>
		
	 <%-- 	<script type="text/javascript" src="${contextPath}/pages/introcontrol/util/jquery-1.7.1.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.ztree.all-3.4.min.js"></script> --%>
			<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	</head>

<body style="margin: 0;padding: 0;overflow:auto;" >
			<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td colspan="4"  class="EditHead">
						&nbsp;<span style="float:left">项目信息</span>

					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width: 10%">
						项目年度
					</td>
					<td class="editTd" style="width: 40%">
						<s:property value="workplanDetail.w_plan_year" />
					</td>
					<td class="EditHead" style="width: 10%">
						项目类别
					</td>
					<td class="editTd" style="width: 40%">
						<s:property value="workplanDetail.pro_type_name"/>
							&nbsp;&nbsp;
						<s:property value="workplanDetail.pro_type_child_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						审计单位
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_dept_name"/>
					</td>
					 <td class="EditHead" >
						项目编号
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.w_plan_code" />
					</td>
					
				</tr>
				<tr>
				<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.audit_object_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目名称
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.w_plan_name" />
					</td>
				<%-- 	<td class="EditHead">
						英文项目名称
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.w_plan_en_name" />
					</td> --%>
 
				</tr>
				<!-- 工程项目审计 -->
				<s:if test="workplanDetail.gcxmsj">

				<tr >
					<td class="EditHead" id="gcxmTd1">

				<tr id="gcxmTr1">
					<td class="EditHead" id="gcxmTd1">

						合同金额
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.contractAmount"/>万元
					</td>
					<td class="EditHead" id="gcxmTd2">
						项目管理模式
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.managerType"/>
					</td>
				</tr>

				<tr  >
					<td class="EditHead" id="gcxmTd3">

				<tr id="gcxmTr2" >
					<td class="EditHead" id="gcxmTd3">

						开工日期
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.startProDate"/>
					</td>
					<td class="EditHead" id="gcxmTd4">
						竣工日期
					</td>
					<td class="editTd" >
						<s:property value="workplanDetail.finishProDate"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" id="gcxmTd5">

				<tr id="gcxmTr3" >
					<td class="EditHead" id="gcxmTd5">

						项目状态
					</td>
					<td class="editTd" colspan="3">
						<s:property value="workplanDetail.proStatus"/>
					</td>
				</tr>
				</s:if>
				<s:if test="workplanDetail.jjzrr">
					<tr>
						<td class="EditHead">
							经济责任人
						</td>
						<td class="editTd" colspan="3">
							<s:property value="workplanDetail.jjzrrname"/>
						</td>
					</tr>
				</s:if>
				<s:if test="workplanDetail.rework">
					<tr>
						<td class="EditHead">
							后续审计项目
						</td>
						<td class="editTd" colspan="3">
							<s:property value="workplanDetail.reworkProjectNames"/>
						</td>
					</tr>
				</s:if>
                 <tr>
				<td class="EditHead" id="aditDeptTd">
						项目领导
					</td>
					<td class="editTd" >
					<s:property value="workplanDetail.pro_teamcharge_name"/>
                    </td>
                    <td class="EditHead">
						项目组长
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_teamleader_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目主审
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_auditleader_name"/>
					</td>
					<td class="EditHead">
						项目参审
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_teammember_name"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						项目开始日期
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_starttime"/>
					</td>
					<td class="EditHead">
						项目结束日期
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.pro_endtime"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" nowrap>
						审计期间开始
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_start_time"/>
					</td>
					<td class="EditHead" nowrap>
						审计期间结束
					</td>
					<td class="editTd">
						<s:property value="workplanDetail.audit_end_time"/>
					</td>
				</tr>
				

	<%-- 			<tr>
					<td class="EditHead">
						附件
					</td>
					<td class="editTd" colspan="3">
						<div data-options="fileGuid:'${workplanDetail.formId}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
					</td>
				</tr> --%>

			</table>
			
	</body>
</html>
