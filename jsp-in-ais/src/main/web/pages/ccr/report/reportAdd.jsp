<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>增加报表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css"" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<style type="text/css">
			textarea {
				width: 90%;
				height: 50px;
			}
		</style>
		<s:head theme="simple" />
		<script type="text/javascript">
			function nextNo(){
				var starttime = document.getElementById('starttime').value;
				var _period = starttime.substring(0,4);
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/ccReport', action:'nextNo', executeResult:'false' }, 
					{ 'period':_period},
					xxx4);
				    function xxx4(data){
				    	if(data['ajaxMsg'] != null && data['ajaxMsg'] != ""){
				    		document.getElementById('reportCode').innerHTML = data['ajaxMsg'];
				    	}
				    }
			}
			
			function saveForm(){
				var _reportId = document.getElementById('reportId').value;
				if(_reportId != ''){
					//var _period = document.getElementById('period').value;
					var starttime = document.getElementById('starttime').value;
					var endtime = document.getElementById('endtime').value;
					var _period = starttime.substring(0,4);
					var _templateId = document.getElementById('templateId').value;
					var _reportName = document.getElementById('reportName').value;
					if(_reportName == ''){
						alert("请填写报表名称！");
						document.getElementById('reportName').focus();
						return false;
					}
					if (_templateId == ''){
						alert("请选择报表模板！");
						document.getElementById('templateId').focus();
						return false;
					} 
					if(endtime == ''||starttime==''){
						alert("请选择统计期间！");
						return false;
					}
					DWREngine.setAsync(false);
						DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/ccReport', action:'saveReport', executeResult:'false' }, 
						{'id':_reportId, 'reportName':_reportName, 'templateId':_templateId, 'period':_period, 'starttime':starttime, 'endtime':endtime},
						xxx5);
					    function xxx5(data){
					    	if(data['ajaxMsg'] != null && data['ajaxMsg'] != ""){
					    		if(data['ajaxMsg'] == "1"){
					    			opener.location = '${contextPath}/ccReport/editReport.action?id=' + _reportId;
					    			window.close();
					    		}
					    		if(data['ajaxMsg'] == "0"){
					    			alert('您所在单位已经填写过该期间所选类型的报表，不能重复填写！');
					    			return false;
					    		}
					    	}
					    }
					}
			}
		</script>
	</head>
	<body>
		<s:hidden name="id" id="reportId"></s:hidden>
			<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						报表信息
					</td>
				</tr>
			</table>
			<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<TR>
					<TD class=ListTableTr1 align="right">
							报表名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="35%" align="left" colspan="3">
							<s:textfield id="reportName" name="report.reportName" size="20"  title="名称" maxlength="50" cssStyle="width:100%"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="15%">
						报表模板<FONT color=red>*</FONT>
					</TD>
					<TD class="ListTableTr2" align="left" colspan="3">
						<s:select list="templateList" listKey="id" listValue="templateName" cssStyle="width:100%" headerKey="" headerValue="" id="templateId"></s:select>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 width="15%">
						统计期间<FONT color=red>*</FONT>
					</TD>
					<TD class="ListTableTr2" align="left" colspan="3">
						<s:textfield id="starttime" name="starttime"
							readonly="true" cssStyle="width:45%" maxlength="15"
							title="单击选择日期" onclick="calendar()" 
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
							至
						<s:textfield id="endtime" name="endtime"
							readonly="true" cssStyle="width:45%" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>	
					
						<%--<s:select id="period" list="#@java.util.LinkedHashMap@{'2011':'2011', '2012':'2012', '2013':'2013', '2014':'2014', '2015':'2015', '2016':'2016'}" name="report.period" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
						<s:select id="period" list="#@java.util.LinkedHashMap@{'01':'01', '02':'02', '03':'03', '04':'04', '05':'05', '06':'06', '07':'07', '08':'08', '09':'09', '10':'10', '11':'11', '12':'12'}" name="report.smonth" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
						<s:select id="period" list="#@java.util.LinkedHashMap@{'01':'01', '02':'02', '03':'03', '04':'04', '05':'05', '06':'06', '07':'07', '08':'08', '09':'09', '10':'10', '11':'11', '12':'12','13':'13', '14':'14', '15':'15', '16':'16', '17':'17', '18':'18', '19':'19', '20':'20', '21':'21', '22':'22', '23':'23', '24':'24','25':'25', '26':'26', '27':'27', '28':'28', '29':'29', '30':'30', '31':'31'}" name="report.sday" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
						至
						<s:select id="period" list="#@java.util.LinkedHashMap@{'2011':'2011', '2012':'2012', '2013':'2013', '2014':'2014', '2015':'2015', '2016':'2016'}" name="report.eperiod" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
						<s:select id="period" list="#@java.util.LinkedHashMap@{'01':'01', '02':'02', '03':'03', '04':'04', '05':'05', '06':'06', '07':'07', '08':'08', '09':'09', '10':'10', '11':'11', '12':'12'}" name="report.emonth" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
						<s:select id="period" list="#@java.util.LinkedHashMap@{'01':'01', '02':'02', '03':'03', '04':'04', '05':'05', '06':'06', '07':'07', '08':'08', '09':'09', '10':'10', '11':'11', '12':'12','13':'13', '14':'14', '15':'15', '16':'16', '17':'17', '18':'18', '19':'19', '20':'20', '21':'21', '22':'22', '23':'23', '24':'24','25':'25', '26':'26', '27':'27', '28':'28', '29':'29', '30':'30', '31':'31'}" name="report.eday" headerKey="" headerValue="" required="true" onchange="nextNo(); "/>
					--%></TD>
				</TR>
			</TABLE>
			<br>
			<div align="center">
				<s:button value="保存" onclick="saveForm(); "></s:button>
				<s:button value="取消" onclick="javascript:window.close(); "></s:button>
			</div>
	</body>
</html>
