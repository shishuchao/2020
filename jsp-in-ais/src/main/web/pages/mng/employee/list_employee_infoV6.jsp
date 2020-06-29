<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<html>
	<head>
		<title>审计人员基本信息列表1</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/employeeValidate/checkboxSelected.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/turnPage.js'></script>
		
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css" type="text/css"></link>
		<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css" type="text/css"></link>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>    
				
		<script language="javascript">			
			$(function(){				
				$.ajax({
					url : "<%=request.getContextPath()%>/adl/getOrgTreeByAuth.action",
					dataType:'json',
					cache:false,
					success:function(data){
						//alert(data.orgTreeJson +' '+data.type)
						if(data.type=='success'){
							var treeData = data.orgTreeJson;
							$('#orgTree').tree({   
								data:treeData,
								onClick:function(node){
									var companyCode = node.id;
									var company = node.text;
									//alert(company+' '+companyCode);									
									$('#employeeFrame').attr("src", "${contextPath}/mng/employee/employeeInfoList.action?listStatus=${listStatus}&employeeInfo.companyCode="+companyCode);
									//alert($('#employeeFrame').attr('src'));
									//$('#companyCode').val(companyCode);
									//$('#export').val('false');
									//$('#searchForm').submit();
								}
							}); 
						}
					}
				})
		    });
		</script>
	</head>
	<body class="easyui-layout">
		<div region='west' split="true" title="&nbsp;&nbsp;&nbsp;请选择所属单位" style="overflow:hidden;width:220px;height:450px;padding1:1px;">	
	 		<div id='orgTree'></div>
     	</div>
     	<div region = 'center'>
     		<iframe id="employeeFrame" src="${contextPath}/mng/employee/employeeInfoList.action?listStatus=${listStatus}" frameborder="0" width="100%" height="600"></iframe>
     	</div>
	</body>
</html>
