<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/styles/report/htmlReport.css" rel="stylesheet" type="text/css">

		<script type="text/javascript" src="${contextPath}/scripts/html2excel.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/compare.js"></script>
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		
		<title>审计人才信息统计报表</title>
		
		<script language="javascript">
		
		var num=Math.random();
	    var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
	    /*
	    $(document).ready(function(){
	    	showResult(document.getElementsByName('tjdwCode')[0].value);
	    });
	    */
		$(function(){
			$("#searchBtn").click(function(){
				if(document.getElementsByName('tjdwCode')[0].value==""){
					showMessage1("请选择统计单位!");
					return false;
				}
<%--				if(document.all.ismax.checked){--%>
<%--					var tjdwCode = document.getElementsByName('tjdwCode')[0].value;--%>
<%--					window.open('${contextPath}/pages/report/employee_html_new.jsp?tjdwCode1='+tjdwCode,"_blank",'height=700px, width=1600px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');--%>
<%--	       		}else{--%>
	       			showResult(document.getElementsByName('tjdwCode')[0].value);
<%--				}--%>
				var reportType = document.getElementsByName('reportType')[0].value
				if(reportType == 'xls'){
					showResult(document.getElementsByName('tjdwCode')[0].value);
					document.getElementById("resDiv").style.display="none";
					setTimeout("html2excel('empTab','repTab','repCreateInfo',0,'审计人才信息统计报表.xlsx')",1000);
				}else{
					document.getElementById("resDiv").style.display="";
				}
				
			});
		});
		
		function showResult(tjdwCode1){
			var d = new Date();
			var year = d.getFullYear();
			var month = d.getMonth() + 1; 
			var dt = d.getDate();
			var today = year + "-" + month + "-" + dt;
			$.post("${contextPath}/report/employee_html.action",
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
<body style="overflow:hidden;" border="0px" class="easyui-layout">
	<div region="north" border="0px" title="查询条件" data-options="split:false" style="height:30%;overflow:hidden;">
		<s:form name="form">
		<table id="tab1" class="ListTable">
				<tr >
		            <td align="left" class="EditHead">
		            	<font color=red>*</font>&nbsp;统计单位
		            </td>
					<td align="left" class="editTd">
						 <s:buttonText2 cssClass="noborder"
								name="tjdw" cssStyle="width:80%;"
								hiddenName="tjdwCode" 
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'统计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  },
	                                  checkbox:true,
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
					</td>
					<td align="left" class="EditHead">
						输出格式
					</td>
					<td align="left" class="editTd">
						<s:select cssClass="easyui-combobox" cssStyle="width:160px;" name="reportType" list="#@java.util.LinkedHashMap@{'htm':'HTML','xls':'EXCEL'}" required="true"></s:select>
					</td>
				</tr>
				<tr  align="right">
					<td colspan="6" align="right" class="editTd">
						<div align="right">
							<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="searchBtn">明细查询</a>
						</div>
					</td>
				</tr>
		</table>
		</s:form>
	</div>
	<div region="center" border="0px" style="height:70%;">
		<div id="resDiv" name="showreport" style="width：100%;margin:10px;"></div>
	</div>
</body>
</html>