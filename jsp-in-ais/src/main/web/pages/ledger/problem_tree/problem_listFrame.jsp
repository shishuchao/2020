<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题维护</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript">
			$(function(){
		    	$('#test').tabs({ 
			        border:false, 
			        onSelect:function(title,index){ 
						if(index == 1){
							var src = $('#afterArchivesInfoFrame').attr('src');
							if(src == ''){
								$('#afterArchivesInfoFrame').attr('src','<%=request.getContextPath()%>/ledger/problemledger/initProblemCase.action?view=${view}&problemCase.problemId=${id}');
							}
						}
			        } 
			    });
		    });
		</script>
		</head>
		<body  style="overflow:hidden;">
			<div class='easyui-tabs' fit='true' id='test' >
				<div id='preArchivesInfo' title='基本信息' style="overflow:hidden;">
					<iframe id="preArchivesInfoFrame" src="${contextPath}/ledger/problemledger/edit.action?view=${view}&id=${id}" frameborder="0" width="100%" height="100%"  style="overflow:hidden;" scrolling="no"></iframe>
				</div>
				<s:if test="${isSort == 'N'}">
					<div id='afterArchivesInfo' title='审计问题案例' style="overflow:hidden;">
						<iframe id="afterArchivesInfoFrame" src="" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
					</div>
				</s:if>
			</div>
		</body>
</html>
