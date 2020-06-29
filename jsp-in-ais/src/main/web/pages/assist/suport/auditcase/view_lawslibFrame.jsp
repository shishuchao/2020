<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计案例</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script language="javascript">
	$(function(){
		  $('#zcfgTreeSelect').tree({   
			  url:'<%=request.getContextPath()%>/pages/assist/suport/lawsLib/showTreeList.action?querySource=tree&mCodeType=${mCodeType}&m_view=true',
			    checkbox:false,
			    animate:false,
			    lines:true,
			    dnd:false,
			    onClick:function(node){
				    var id=node.id;
				 	var src='<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=view&mCodeType=${mCodeType}&nodeid='+id;
				  	$('#childBasefrm').attr('src',src);
			    }
			});
	});
	</script>
</head>
<body id="container" style="margin: 0;padding: 0;overflow:hidden;" border="0" class="easyui-layout" fit='true' >
	<div id="content" region='west' split='true' title='类别' border="0" style='width:300px;'>
		<br>
		<ul id='zcfgTreeSelect' class='easyui-tree'></ul>
		<br>
	</div>
	<div id="sidebar" region='center' title="详细信息"  border="0" style="overflow:hidden">
		<iframe name="childBasefrm" id="childBasefrm" width="100%" frameborder="0" height="100%" scrolling="no" src="search.action?mCodeType=${mCodeType}&nodeid=${nodeid}&m_view=view" ></iframe>
	</div>
</body>
</html>