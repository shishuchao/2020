<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划：预选项目：N年未审计单位查询</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/boot.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/contextmenu.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$('#unauditedDepartmentSearch').tabs({
					onSelect:function(title,index){
						if(title == '未审计单位检索') {
							var url = $('#DepSearchListFrame').attr('src');
							if(url == null || url == '') {
								url = "${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearchList.action?fromAdjust=${fromAdjust}&crudId=<s:property value="crudId"/>&planStatus=<s:property value="planStatus"/>&yearFormId=<s:property value="yearFormId"/>";
								$('#DepSearchListFrame').attr('src',url);
							}
						}
					}
				});
			});

		</script>
	</head>
	<body class="easyui-layout">
		<div region="center" fit="true">
			<div id="unauditedDepartmentSearch" class="easyui-tabs" fit="true">
				<div id='DepSearchCondition' title='曾使用过检索条件' style="overflow: hidden;">
						<iframe id="depSerchConditionFrame"
							src="${contextPath}/plan/detail/unauditedDepSearch!unaudDepSearchConditionList.action?fromAdjust=${fromAdjust}&crudId=<s:property value="crudId"/>&yearFormId=<s:property value="yearFormId"/>"
							frameborder="0" width="100%" height="100%"></iframe>
				</div>
				<div id='DepSearchList' title='未审计单位检索' style="overflow: hidden;">
						<iframe id="DepSearchListFrame"
							src=""
							frameborder="0" width="100%" height="100%"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>
