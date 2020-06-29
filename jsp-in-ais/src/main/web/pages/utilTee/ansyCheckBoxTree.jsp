<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>公共多/单选树(适用subModal.js)</title>
<link rel="stylesheet" href="<%=basePath%>pages/utilTee/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript" src="<%=basePath%>pages/utilTee/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>pages/utilTee/js/jquery.json-2.3.js"></script>
<script type="text/javascript"
	src="<%=basePath%>pages/utilTee/js/jquery.ztree.core-3.4.js"></script>
<script type="text/javascript"
	src="<%=basePath%>pages/utilTee/js/jquery.ztree.excheck-3.4.js"></script>
<style type="text/css">
body{
   background-color: white;
}
</style>
<SCRIPT type="text/javascript">
/**
处理需要的action
**/
var urlAction = "<%=request.getParameter("urlAction")%>";
/**
勾选 checkbox 对于父子节点的关联关系
Y 属性定义 checkbox 被勾选后的情况； 
N 属性定义 checkbox 取消勾选后的情况； 
"p" 表示操作会影响父级节点； 
"s" 表示操作会影响子级节点。
请注意大小写，不要改变
**/
var chkboxTypeY= "<%=request.getParameter("chkboxTypeY")%>";
var chkboxTypeN= "<%=request.getParameter("chkboxTypeN")%>";
/**
勾选框类型(checkbox 或 radio）
默认值："checkbox"
**/
var chkStyle = "<%=request.getParameter("chkStyle")%>";
/**
radio 的分组范围
radioType = "level" 时，在每一级节点范围内当做一个分组。 
radioType = "all" 时，在整棵树范围内当做一个分组
**/
var radioType = "<%=request.getParameter("radioType")%>";

if("null" == chkboxTypeY){
	chkboxTypeY = "";
}
if("null" == chkboxTypeN){
	chkboxTypeN = "";
}
if("null" == chkStyle){
	chkStyle = "";
}
if("null" == radioType){
	radioType = "";
}

    var setting = {
		check: {
			enable: true,
			chkboxType: { "Y": chkboxTypeY, "N": chkboxTypeN },
			chkStyle : chkStyle,
			radioType: radioType
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		async: {
				enable: true,
				url:urlAction,
				autoParam:["id=parentid"]
			},
		callback: {
		        onAsyncSuccess: ""
	        }
	      };

		
		$(document).ready(function(){
			$.fn.zTree.init($("#ztree"), setting);
		});
		
		function CheckedProblemType(){
			var treeObj = $.fn.zTree.getZTreeObj("ztree");
			var nodes = treeObj.getCheckedNodes(true);
			if(nodes.length == 0){
				alert("至少选择一条数据！");
				return;
			}
			var names = new Array();
			var ids = new Array();
			for(var i=0;i<nodes.length;i++){
				names.push(nodes[i].name);
				ids.push(nodes[i].id);
			}
			window.parent.backValue(names,ids);
			
		}
		
</SCRIPT>
</head>
<body>
<div class="zTreeDemoBackground left">
		<ul id="ztree" class="ztree"></ul>
	</div>
</body>
</html>