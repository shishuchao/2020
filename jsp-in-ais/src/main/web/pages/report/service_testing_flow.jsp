<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>业务测试-按流程</title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/report/htmlReport.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/ccr/fancybox/jquery.min.js"></script>
		<SCRIPT type="text/javascript" src="${contextPath}/scripts/html2excel.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="${contextPath}/project/javascript/tableSum.js"></SCRIPT>
		<SCRIPT type="text/javascript" src="${contextPath}/project/javascript/tableSetZero2Empty.js"></SCRIPT>
		<script language="javascript">
			$(function(){
				$("#searchBtn").click(function(){
					$("#loading").show();
					var year = $("#yearSelect").val()
					if(year == ''){
						alert("请选择统计年度!");
						$("#yearSelect").focus();
						return false;
					}
					$("#resDiv").html("<br/><center><strong id=\"repTab\"><span id=\"repCreateInfo\">"+ year+ "</span>年业务测试-按流程</strong></center>"+
						"<table id=\"planTab\">"+
						"<thead id=\"planHead\">"+
						"<tr><td rowspan=\"2\" >业务流程</td>"
							+"<td colspan=\"2\">达标</td>"
							+"<td colspan=\"2\">未达标</td>"
							+"<td colspan=\"2\">样本量不足</td>"
							+"<td colspan=\"2\">未发生交易</td>"
							+"<td colspan=\"2\">不适用</td>"
							+"<td rowspan=\"2\">合计</td>"
							+"<td rowspan=\"2\">未达标率</td>"
							+"</tr>"
						+"<tr><td >数量</td>"
							+"<td >比例</td>"
							+"<td >数量</td>"
							+"<td >比例</td>"
							+"<td >数量</td>"
							+"<td >比例</td>"
							+"<td >数量</td>"
							+"<td >比例</td>"
							+"<td >数量</td>"
							+"<td >比例</td>"
							+"</tr></thead><tbody id=\"planHappenBody\"></tbody></table>");
					$("#planTab").addClass("repTab");
					$("thead>tr>td").addClass("repTitleTd");
					$("#unitName").css("width","200px");
					/*$.post("${contextPath}/report/planExecuteHtml.action",
							{year:$("#yearSelect").val()},
							function(data,textStatus){
								if(typeof data == 'string'){
									data = eval("(" + data + ")");
									alert(data);
								}
								var $l = data.htmlList;
								for(var i=0, len=$l.length; i<len; i++){
									$("#planHappenBody").append($l[i]);
								}
								$("#planTab").before("<br/><span id=\"repCreateInfo\">编制单位："+ data.bzdw +"     统计期间：" + data.tjqj + "     编制人:" + data.bzr + "    编制日期:" + data.bzrq + "</span>");
								//applyTableSum($("#planTab"),$("#planHappenBody"),[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22],0,"-");
								setAllZero2Empty($("#planTab"))
								$("#planHappenBody>tr>td").addClass("contentTd");
								$("#loading").hide();
							}
						);*/
					if($("#reportType").val() == 'xls')
						setTimeout("html2excel('planTab','repTab','repCreateInfo',3,'save.xls')",2000);
				});
			});
			
		</script>
	</head>
	<body>
		<center>
			<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td  align="left" class="edithead">
						<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/planExecute.action')"/>
					</td>
				</tr>
			</table>
			<s:form name="form">
				<table id="tab1" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr class="listtablehead">
			            <td class="ListTableTr11">
			            	统计年度<font color=red>*</font>
			            </td>
						<td align="left" class="ListTableTr22" style="width: 20%">
							<s:select id="yearSelect" name="year" 
								list="@ais.framework.util.DateUtil@getIncrementYearList(5,5)"
								required="true" />
						</td>
						<td class="ListTableTr11">
							输出格式：
						</td>
						<td class="ListTableTr22">
							<s:select id="reportType" name="reportType" list="#@java.util.LinkedHashMap@{'htm':'HTML','xls':'EXCEL'}" required="true"></s:select>
						</td>
					</tr>
				</table>
			</s:form>
			<div align="right">
				<input type="button" value="明细查询" id="searchBtn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
				<div id="loading" style="display:none;position:absolute;left:50%;top:50%;margin-left:-200px">
								<marquee direction="right" scrollamount="8" scrolldelay="100">
								    <span class="progressBarHandle-0"></span>
								    <span class="progressBarHandle-1"></span>
								    <span class="progressBarHandle-2"></span>
								    <span class="progressBarHandle-3"></span>
								    <span class="progressBarHandle-4"></span>
								    <span class="progressBarHandle-5"></span>
								    <span class="progressBarHandle-6"></span>
								    <span class="progressBarHandle-7"></span>
								    <span class="progressBarHandle-8"></span>
								    <span class="progressBarHandle-9"></span>
								</marquee>
							</div>														
			</div>
			<div id="resDiv" style="margin-left: 20px;"></div>
		</center>
	</body>
</html>
