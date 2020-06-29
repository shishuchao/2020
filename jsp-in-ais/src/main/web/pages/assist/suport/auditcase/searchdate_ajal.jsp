<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<HTML>
<HEAD>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
<TITLE>search</TITLE>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript">
$(function(){
	  $('#tree').tree({   
			url:'<%=request.getContextPath()%>/pages/assist/suport/lawsLib/showTreeList.action?querySource=tree&mCodeType=sjal',
	       	animate:true, 
			method:'post',
			lines:true,
			dnd:true,
			checkbox:false,
			cascadeCheck:true,
			onClick:function(node){
				//$(this).tree('toggle', node.target);
			},
			onDblClick:function(node){
				window.parent.saveF();
			}
		});
});
 function saveF(){
	var node = $('#tree').tree('getSelected');			
	var code_value = '';
	var name_value = '';
	var ayy = [];
	if (node) {
		var code = node.id;
		var name = node.text;
		/*
		code_value = code;
		name_value = name; 
		var pnode = $("#tree").tree('getParent',node.target);
		if(pnode){
			code_value+=','+pnode.attributes;
			name_value=pnode.text+','+name_value;
		}
	    ayy.push(code_value);
	    */   
	    ayy.push(name);
	    ayy.push(code);
	    return ayy;
	}else{
		$.messager.alert('系统提示',"请选择一个节点",'warning');
        return;
	} 
 }
</script>
</HEAD>

<body>
	  <div id="content" <%--style="overflow: auto;"--%>>
    	<ul id='tree' class='easyui-tree'></ul>
	</div> 
</BODY>
</HTML>