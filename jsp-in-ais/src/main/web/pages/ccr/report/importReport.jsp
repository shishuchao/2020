<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>导入报表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		</style>
		<s:head theme="simple" />
		<script type='text/javascript'
			src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript'
			src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
	</head>
	<script type="text/javascript">
		function saveImport(){
			var reportName = document.getElementById('reportName').value;
			var starttime = document.getElementById('starttime').value;
			var endtime = document.getElementById('endtime').value;
			var year = starttime.substring(0,4);
			var cellTemplateId = document.getElementById('templateId').value;
			var impxls = document.getElementById('impxls').value; 
			var deptid = document.getElementById("unitIds").value;
			
			if(reportName == ''){
				alert("请填写报表名称！");
				return false;
			}
			
			if(cellTemplateId == ''){
				alert("请选择模板！");
				return false;
			}
			if(endtime == ''||starttime==''){
				alert("请选择统计期间！");
				return false;
			}
			if(impxls == ''){
				alert("请选择文件！");
				return false;
			}else{
				var indx = impxls.lastIndexOf(".");
				var prefix = impxls.substring(indx+1);
				if(prefix!="xls"){
					alert("导入的格式必须是2003版excel！");
					return false;
				}
			}
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/ccReport', action:'hasReport', executeResult:'false' }, 
			{ 'period':year,'templateId':cellTemplateId,'unitIds':deptid,'starttime':starttime,'endtime':endtime},
			xxx2);
		    function xxx2(data){
		    	if(data['ajaxMsg'] == '1'){
		    			alert("您所在公司已存在统计期间在"+starttime+"到"+endtime+"之间该类型报表");
		    		}
	    		if(data['ajaxMsg'] == '0'){
					myform.submit();
	    		}
		    }
		}
		
	</script>
<body>
		<table id="tableTitle" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
				<tr class="listtablehead">
					<td align="left" class="edithead">
						导入报表
					</td>
				</tr>
			</table>
		<s:form name="myform" action="saveImpReport" namespace="/ccReport"  method="post" enctype="multipart/form-data" >
		<s:hidden name="id" id="reportId"></s:hidden>	
		<TABLE id="tab1" width="100%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable align="center">
			<TR>
					<TD class=ListTableTr1 align="right">
						报表名称
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="75%" align="left" >
							<s:textfield id="reportName" name="reportName" size="20"  title="报表名称" maxlength="50" cssStyle="width:100%"/>
					</TD>
				</TR>
				<TR>
					<TD class=ListTableTr1 align="right">
						模板类型
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="75%" align="left" >
							<s:select name="templateId" id="cellTemplateId" list="templateList" listKey="id"
						listValue="templateName" headerKey="" headerValue=""></s:select>
						</TD>
				</TR>
				
			<TR>
					<TD class=ListTableTr1 align="right">
						报表期间
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="75%" align="left">
						<s:textfield id="starttime" name="starttime"
							readonly="true" cssStyle="width:45%" maxlength="15"
							title="单击选择日期" onclick="calendar()" 
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield>
							至
						<s:textfield id="endtime" name="endtime"
							readonly="true" cssStyle="width:45%" maxlength="15"
							title="单击选择日期" onclick="calendar()"
							theme="ufaud_simple" templateDir="/strutsTemplate"></s:textfield><%--	
					
						<s:select id="period" name="period"  list="#{'2011':'2011','2012':'2012','2013':'2013','2014':'2014','2015':'2015'}" cssStyle="width:20%"></s:select>
							年
									--%></TD>
			</TR>
			<TR>
					<TD class=ListTableTr1 align="right">
						填报单位
						<FONT color=red>*</FONT>
					</TD>
					<TD class=ListTableTr2 width="75%" align="left" >
							<s:buttonText name="unitName" id="company"
							hiddenId="companyCode" hiddenName="unitIds"
							cssStyle="width:80%"
							doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&paraname=unitName&paraid=unitIds&p_item=1&orgtype=0',300,250,'所属单位')"
							doubleSrc="/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							doubleDisabled="false" />
					</TD>
			</TR>
			<tr>
					<td class="ListTableTr1" align="right">
						选择文件
						<FONT color=red>*</FONT>
					</td>
					<td class="listtabletr2" width="75%" align="left">
						<s:file id="impxls" name="impxls" size="50%"/>
					</td>
			</tr>
			
		</TABLE>
		<CENTER><s:button  onclick="saveImport(); " value="导 入"></s:button>&nbsp;<s:button  onclick="history.go(-1); " value="返 回"></s:button></CENTER>
		</s:form>
</body>
</html>