<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<SCRIPT src="<%=request.getContextPath()%>/resources/js/common.js"></SCRIPT>
	<script type="text/javascript">
		$(function(){
			 $('#sjwtTree').tree({
				url:'<%=request.getContextPath()%>/pages/assist/suport/lawsLib/showTreeList.action?querySource=tree&mCodeType=${mCodeType}',
			    checkbox:false,
			    animate:false,
			    lines:true,
			    dnd:false,
			    onClick:function(node){
				    var id = node.id;
			    },
			    onLoadSuccess:function() {
			    	var node = $('#sjwtTree').tree('getSelected');
				    if (!node) {
				     	var rootNode = $('#sjwtTree').tree('getRoot');
				     	$('#sjwtTree').tree('select',rootNode.target);
				    }
			    }
		     });
		});
		
		function getTreeNode() {
			var node = $('#sjwtTree').tree('getSelected');
			if (node) {
				if ($('#sjwtTree').tree('isLeaf',node.target)) {
					return node;
				} else {
					showMessage1('请选择子节点进行添加!');
				}
			} else {
				showMessage1('请选择要添加的内容!');
			}
			return null;
		}
		
	</script>
</head>
<body class="easyui-layout" border="0" >
	<div id='content' region="center" fit="true">
		<ul id='sjwtTree'></ul>
    </div>
	<input id="treePage" type="hidden" value="1111"/>
</body>
</html>