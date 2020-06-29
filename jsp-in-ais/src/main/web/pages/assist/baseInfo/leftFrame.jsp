<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>组织机构设置</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript">
			$(function(){
				$('#treeMatter').tree({
	    			 url:'<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!orgDeptList.action',
	    			 checkbox:false,
	    			 animate:false,
	    			 lines:true,
	    			 dnd:false,
	    			 onClick:function(node){
	    				var state = node.state;
	    				var id = node.id;
	    				var name = node.text;
	    				//var src = '<%=request.getContextPath()%>/ledger/problemledger/problemListFrame.action?view=<%=request.getParameter("view")%>&id=' + id;
	                    //$('#childBasefrm').attr('src',src);
	    			}
	    		 });
			});
		</script>
	</head>
	<body class="easyui-layout">
		<div region = "center" style="height: 100%; width: 100%;">
		   <ul id="tree"></ul>
		</div>
	</body>
</html>
