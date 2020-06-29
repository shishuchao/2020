<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/styles/report/htmlReport.css" rel="stylesheet" type="text/css">
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>

		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/html2excel.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/compare.js"></script>
		<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/scripts/tableSum.js"></SCRIPT>
		
		
     <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>   
     <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		
		<title>审计人才信息统计报表</title>
		
		<script language="javascript">
		
		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	    $(document).ready(function(){
	    	var code = '<%=(String)request.getParameter("tjdwCode1")%>';
	    	showResult(code);
	    });

		function showResult(tjdwCode1){
			var d = new Date();
			var year = d.getFullYear();
			var month = d.getMonth() + 1; 
			var dt = d.getDate();
			var today = year + "-" + month + "-" + dt;
			$.post("<%=request.getContextPath()%>/report/employee_html.action",
					{tjdwCode:tjdwCode1},
					function(data){
						$("#resDiv").html("<br/><center><strong id=\"repTab\">审计人才信息统计报表</strong></center><table id=\"empTab\"><thead id=\"repHead\"></thead><tbody id=\"repBody\"></tbody></table>");
						$("#repHead").append(data.theadHtml);
						$("#empTab").addClass("repTab");
						$("#repHead>tr>td").addClass("repTitleTd");
						var $h = data.htmlList;
						
						for (var i=0; i < $h.length; i++) {
						  $("#repBody").append($h[i]);
						}; 
						$("#repBody>tr>td").addClass("contentTd");
						$("#empTab").before("<br/>&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"float: left;\" id=\"repCreateInfo\">统计单位："+ data.auditUserDeptName
						+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编制人："+data.auditUserName
						+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编制日期："+today
						+"</span>");					
					});
		}
		
		</script>
	</head>
	
	<body>
		<div id="resDiv" name="showreport" style="margin-left: 20px;"></div>
	</body>
</html>