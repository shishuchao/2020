<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<title>案例维护</title>
<script language="javascript">
$(function(){
	  $('#zcfgTreeSelect').tree({
			url:'<%=request.getContextPath()%>/pages/assist/suport/lawsLib/showTreeList.action?querySource=tree&mCodeType=${mCodeType}',
		    checkbox:false,
		    animate:false,
		    lines:true,
		    dnd:false,
		    onClick:function(node){
			    var id=node.id;
			 	var src="<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?sjdw=${sjdw}&isLeader=${isLeader}&mCodeType=${mCodeType}&nodeid="+id;
			  	childBasefrm.location.href=src;
		    }
	  });
});
</script>
</head>
<body>
<div id="container" class='easyui-layout' fit='true' border="0">
    <div id="content" region='west' border="0" split='true' title='类别' style='width:300px;overflow: auto;'>
	    <br>
    	<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
    	<br>
  </div>
  <div id="sidebar"  region='center' border="0" title="详细信息" style="overflow:hidden;">
		<iframe name="childBasefrm" width="100%" frameborder="0" height="100%" src="listByTypeKey.action?sjdw=${sjdw}&mCodeType=${mCodeType}&nodeid=${nodeid}&isLeader=${isLeader}" ></iframe>
  </div>
</div>
</body>
</html>