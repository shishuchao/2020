<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
<head>
<title>授权结果查看</title>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<META   HTTP-EQUIV="Pragma"   CONTENT="no-cache">     
<META   HTTP-EQUIV="Cache-Control"   CONTENT="no-cache">     
<META   HTTP-EQUIV="Expires"   CONTENT="0">  
		
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>

<script type="text/javascript">
// 自定义组织机构树, qfucee, 2016.6.17
$(function(){
	var treeTarget = $('#orgTree')[0];
	var dpetId = '${user.fdepid}';
	var childBasefrmSrc = '${contextPath}/system/authRoleAction!showSelfRoles.action?companyId=';
	
	// 自定义 - 组织机构树
	showSysTree(treeTarget,{
		container:treeTarget,
		defaultDeptId:dpetId,
		treeTabTitle1:'组织机构',
		treeTabTitle2:'搜索结果',
		param:{
            'beanName':'UOrganizationTree',
            'treeId'  :'fid',
            'treeText':'fname',
            'treeParentId':'fpid',
            'treeOrder':'fcode'
        },
        onTreeClick:function(node, treeDom){
			$('#childBasefrm').attr('src', childBasefrmSrc + node.id);
        }
	});
	
	dpetId ? $('#childBasefrm').attr('src', childBasefrmSrc + dpetId) : null;
});

</script>
</head>
<body class="easyui-layout" id="codenameLayout" border='0' fit='true'>
	<div region="west" border='0'  style="overflow:hidden;width:300px;" split="true">
   		<ul id="orgTree"></ul>
    </div>
    <div region="center" border='0' style="overflow:hidden">
    	<iframe id="childBasefrm" name="childBasefrm" width="100%" style="oveflow:hidden;" frameborder="0" height="100%" src=""></iframe>	      	
    </div>
</body>
</html>