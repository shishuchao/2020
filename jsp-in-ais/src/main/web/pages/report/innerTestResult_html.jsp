<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>测试结果统计汇总表</title>
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
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script language="javascript">
			$(document).ready(function(){
					$("#loading").show();
					//项目名称
					$("#resDiv").html("<br/><center><strong id=\"repTab\">测试结果统计汇总表</strong></center>"+
						"<table id=\"planTab\">"+
						"<thead id=\"planHead\">"+
						"<tr><td id=\"unitName\" rowspan='2'>公司简称</td>"
							+ "<td  rowspan='2'>被审计单位名称</td>"
							+ "<td rowspan='2'>所处城市</td>"
							+ "<td rowspan='2'>流程</td>"
							+ "<td colspan='3'>未达标分析</td>"
							+ "<td rowspan='2'>测试的控制活动数量</td>"
							+ "<td colspan='5'>达标数</td>"
							+ "<td colspan='8'>未达标数</td>"
							+ "<td colspan='5'>样本量不足数</td>"
							+ "<td colspan='5'>未发生交易数</td>"
							+ "<td colspan='5'>不适用数量</td>"
							+ "</tr>"
							+ "<tr><td >测试有效控制活动数量=达标数+未达标数</td>"
							+ "<td>未达标数量</td>"
							+ "<td>未达标率</td>"
							+ "<td>合计</td>"
							+ "<td>占该流程测试总数的比例（%）</td>"
							+ "<td>重要控制</td>"
							+ "<td>关键控制</td>"
							+ "<td>一般控制</td>"
							+ "<td>合计</td>"
							+ "<td>占该流程测试总数的比例（%）</td>"
							+ "<td>重要控制</td>"
							+ "<td>关键控制</td>"
							+ "<td>一般控制</td>"
							+ "<td>设计缺陷</td>"
							+ "<td>执行缺陷</td>"
							+ "<td>执行和设计缺陷</td>"
							+ "<td>合计</td>"
							+ "<td>占该流程测试总数的比例（%）</td>"
							+ "<td>重要控制</td>"
							+ "<td>关键控制</td>"
							+ "<td>一般控制</td>"
							+ "<td>合计</td>"
							+ "<td>占该流程测试总数的比例（%）</td>"
							+ "<td>重要控制</td>"
							+ "<td>关键控制</td>"
							+ "<td>一般控制</td>"
							+ "<td>合计</td>"
							+ "<td>占该流程测试总数的比例（%）</td>"
							+ "<td>重要控制</td>"
							+ "<td>关键控制</td>"
							+ "<td>一般控制</td>"
							+ "</tr>"
							+ "</thead><tbody id=\"planHappenBody\"></tbody></table>");
					$("#planTab").addClass("repTab");
					$("thead>tr>td").addClass("repTitleTd");
					$("#unitName").css("width","200px");
					$.post("${contextPath}/report/innerTestResultHtml.action",
							{projectId:'${projectId}'},
							function(data,textStatus){
								if(typeof data == 'string'){
									data = eval("(" + data + ")");
								}
								var $l = data.htmlList;
								for(var i=0, len=$l.length; i<len; i++){
									$("#planHappenBody").append($l[i]);
								}
								$("#planTab").before("<br/><span id=\"repCreateInfo\">编制单位："+ data.bzdw  + "     编制人:" + data.bzr + "    编制日期:" + data.bzrq + "</span>");
								$("#planHappenBody>tr>td").addClass("contentTd");
								
							}
						);
						/* $("#searchBtn").click(function(){
							setTimeout("html2excel('planTab','repTab','repCreateInfo',3,'测试结果统计汇总表.xls')",2000);
						}); */
					$("#loading").hide();
				});
			
		</script>
	</head>
	<body>
		<center>
			<div align="right">
				<a class="easyui-linkbutton" href="/ais/introcontrol/check/exportReport.action?projectId=${projectId }&report=analysis">导出分析用表</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
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
