<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>排程列表修改</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/gray/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=basePath%>pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<link href="<%=basePath%>styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=basePath%>scripts/calendar.js"></script>
		<script type="text/javascript">
		 $(function(){
		     //设置默认选中参与人员
		     var checked = '<s:property value="#request.proMemberSchedule.auditperson"/>';
             var checkeds = checked.split(",");
             for(var i=0;i<checkeds.length;i++){
                $("[value='"+checkeds[i]+"']:checkbox").attr("checked","checked");
             }
		 })
		 
		 function saveSchedule(){
		    var projectid = '<s:property value="#request.proMemberSchedule.projectid"/>'
		    var scheduleId = '<s:property value="#request.proMemberSchedule.scheduleid"/>';
		    var plantime = $("#plantime").val();
		    var starttime = $("#starttime").val();
		    var endtime = $("#endtime").val();
		    var checks = $("input:checked");
		    var check = "";
		    var checkText = "";
		    
		    var re = "\\d{4}-\\d{2}-\\d{2}";
		    if(!starttime.match(re)){
		        alert("计划起始时间必须填写格式如\"yyyy-MM-dd\"！");
		        return;
		    }
		    if(!endtime.match(re)){
		        alert("计划结束时间必须填写格式如\"yyyy-MM-dd\"！");
		        return;
		    }
		    
		    if(!plantime.match("\\d+")){
		        alert("计划天数应该至少为一个数字！");
		        return;
		    }
		    
		    for(var i=0;i<checks.length;i++){
		       if(i != checks.length-1){
		         check = check+checks[i].value+",";
		         checkText =  checkText+checks[i].id + ",";
		       }else{
		         check = check+checks[i].value;
		         checkText =  checkText+checks[i].id;
		       }
		    }
		    
		    if(check.length == 0){
		        alert("参与人员至少选择一人！");
		        return;
		    }
		    
		   window.location = "<%=basePath%>project/schedule!schduleModify.action?scheduleId="+scheduleId+"&plantime="+plantime+"&starttime="+starttime+"&endtime="+endtime+"&check="+encodeURI(encodeURI(check))+"&crudId="+projectid+"&checkText="+checkText;
		 }
		</script>
	</head>
	<body style="height:100%">
			<table id="projectGroupTable" cellpadding="0" cellspacing="1" border="0" bgcolor="#409cce" class="ListTable" align="center">
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 分组名称：
					</td>
					<td class="ListTableTr22">
					    <s:property value="#request.groupName"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 测试地区：
					</td>
					<td class="ListTableTr22">
					    <s:property value="#request.area"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 被审计单位：
					</td>
					<td class="ListTableTr22">
					   <s:property value="#request.proMemberSchedule.auditobjectname"/>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 参与人员：
					</td>
					<td class="ListTableTr22">
						<s:iterator value="#request.proMemberList" id="member">
						  <input name="memberCheck" type="checkbox" id="<s:property value="#member.userId"/>" value="<s:property value="#member.userName"/>" /><s:property value="#member.userName"/>
						</s:iterator>
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 计划天数：
					</td>
					<td class="ListTableTr22">
					   <input type="text" size="2" id="plantime" value="<s:property value="#request.proMemberSchedule.plantime"/>">&nbsp;（天）
					</td>
				</tr>
				<tr>
					<td class="ListTableTr11" nowrap>
						<font color=red></font> 计划期间：
					</td>
					<td class="ListTableTr22">
					      <s:textfield id="starttime"  name="#request.proMemberSchedule.starttiem"
							readonly="true" cssStyle="width:150px" maxlength="15"
							title="单击选择日期"  onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
							&nbsp;至&nbsp;
							<s:textfield id="endtime" name="#request.proMemberSchedule.endtime"
							readonly="true" cssStyle="width:150px" maxlength="15"
							title="单击选择日期"  onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
					</td>
				</tr>
			</table>

			<div align="right" style="width: 96%;">
		    <a onclick="saveSchedule()" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
			&nbsp;&nbsp;
			<a href="javascript:window.location.href='${contextPath}/project/schedule!scheduleList.action?crudId=${crudId}'" class="easyui-linkbutton" data-options="iconCls:'icon-back'">取消</a>
		    </div>
	</body>
</html>