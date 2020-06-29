<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>选取项目</title>
		<s:head />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<script language="javascript">
function toAddProj(){
	var sData = dialogArguments;
	var selobj = document.getElementsByName("ids");
	if(selobj){
		if(selobj.length>0){
			var flag=true;
			for(var i=0;i<selobj.length;i++){
				if(selobj[i].checked){
					flag=false;
					var str = new Array();
					str=selobj[i].value.split("|");
					var project_code = str[1];
					var project_name = str[0];
					var project_shape_name=str[2];
					var plan_type_name=str[3];
					var project_type_name=str[4];
					var project_starttime=str[5];
					var project_endtime=str[6];
					var project_charge_budget=str[7];
					var project_person_day_budget=str[8];
					var project_audit_dept_name=str[9];
					var project_teamleader_name=str[10];
					var project_auditleader_name=str[11];
					var project_team_members_name=str[12];
					var project_audited_dept_name=str[13];
					var project_audit_scope=str[14];
					var project_remark=str[15];
					var project_cognizance_person_name=str[16];
					var project_duty_person_name=str[17];
					var formId=str[18];
					var plan_id=str[19];
					sData.project_name = project_name ;
					sData.project_code = project_code ;
					sData.project_shape_name = project_shape_name ;
					sData.plan_type_name = plan_type_name ;
					sData.project_type_name = project_type_name ;
					sData.project_starttime = project_starttime ;
					sData.project_endtime = project_endtime ;
					sData.project_charge_budget = project_charge_budget ;
					sData.project_person_day_budget = project_person_day_budget ;
					sData.project_audit_dept_name = project_audit_dept_name ;
					sData.project_teamleader_name = project_teamleader_name ;
					sData.project_auditleader_name= project_auditleader_name ;
					sData.project_team_members_name= project_team_members_name ;
					sData.project_audited_dept_name = project_audited_dept_name ;
					sData.project_audit_scope = project_audit_scope ;
					sData.project_remark = project_remark ;
					sData.project_cognizance_person_name= project_cognizance_person_name ;
					sData.project_duty_person_name = project_duty_person_name ;
					sData.ps_formId = formId ;
					sData.plan_id=plan_id;
				}
			}
			if(flag){
				alert("请选择一个项目！");
				return;
			}
		}else{
			window.alert("没有项目可以选择!");
			self.close();
		}
	}
  	self.close();
}
</script>

	</head>

	<body>
		<table width="100%" border="0" cellspacing="5" cellpadding="0"
			align=center>
			<tr>
				<td>
					<TABLE width="100%" border=0 cellPadding=1 cellSpacing=1
						bgcolor="#409cce" class=ListTable align="center" id="projTable">
						<tr align=center class="titletable1">
							<td class="1_lan" width=8% height="20">
								选项
							</td>
							<td class="1_lan" width=18%>
								计划名称
							</td>
						</tr>
						<s:iterator value="proList">
							<tr>
								<td class="ListTableTr2">
									<input type="radio" name="ids"
										value='<s:property value="project_name" />|<s:property value="project_code" />|
									<s:property value="project_shape_name" />|<s:property value="plan_type_name" />|
									<s:property value="project_type_name" />|<s:property value="project_starttime" />|
									<s:property value="project_endtime" />|<s:property value="project_charge_budget" />|
									<s:property value="project_person_day_budget" />|<s:property value="project_audit_dept_name" />|
									<s:property value="project_teamleader_name" />|<s:property value="project_auditleader_name" />|
									<s:property value="project_team_members_name" />|<s:property value="project_audited_dept_name" />|
									<s:property value="project_audit_scope" />|<s:property value="project_remark" />|
									<s:property value="project_cognizance_person_name" />|<s:property value="project_duty_person_name" />|
									<s:property value="formId" />|<s:property value="plan_form_id"/>' />
								</td>

								<td class="ListTableTr2">
									<s:property value="project_name" />
								</td>
							</tr>
						</s:iterator>
					</TABLE>
			<tr>
				<td align=right>
					<input name="Submit" type="button" class="button23" value="确 定"
						onclick="toAddProj();">
				</td>
			</tr>
		</table>
	</body>
</html>
