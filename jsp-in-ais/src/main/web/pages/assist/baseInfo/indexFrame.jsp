<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<title></title>
	<script type="text/javascript">
		$(function(){
			var obj = $('#tree')[0];
			var deptId = "${magOrganization.fid}";
			// 自定义 - 组织机构树
			showSysTree(obj,{
				container:obj,
				noMsg:true,
				defaultDeptId:deptId,
				treeTabTitle1:'审计机构树',
				treeTabTitle2:'搜索结果',
				url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
				param:{
					'p_item':3
	            },
				onTreeClick:function(node, treeDom){
					var state = node.state;
					var id = node.id;
					var name = node.text;
					var src = '<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!edit.action?baseInfo.orgId='+id+'&status=${status}';
		            $('#childBasefrm').attr('src',src);
				},
				onTreeLoadSuccess:function(node,data){
					var src = '<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!edit.action?baseInfo.orgId='+deptId+'&status=${status}';
					$('#childBasefrm').attr('src',src);
				}
			}); 
		});
	</script>
</head>
<div id="container" class='easyui-layout' fit='true' border="0">
	<div id="content" region='west' split='true' border="0" >
		<div id="tree"></div>
	</div>
	<div region='center' id="sidebar" border="0" style='overflow: hidden;'>
		<iframe id="childBasefrm" frameborder="0" scrolling="yes" style="width: 100%; height: 100%;" src=""></iframe>
	</div>
</div>
</html>