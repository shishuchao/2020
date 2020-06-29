<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML>
<HTML>
<head>  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<TITLE>search</TITLE>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<Script language=Javascript>
$(function(){	
	var wurl = window.location.href;
	var urlArr = wurl.split('&'); // menuView
	var menuView = 'edit';
	var projectid = '${projectid}';
	for(var i=0; i<urlArr.length; i++){
		var p = urlArr[i];
		var arr = p.split('=');
		if(arr[0] == 'menuView'){
			menuView = arr[arr.length-1];
			//alert(menuView+"1");
		}
		if(arr[0] == 'projectid'){
			projectid = arr[arr.length-1];
			//alert(projectid+"2");
		}
	}
	//alert(projectid+"2.1");
    // 加载政策法规树
    $('#tree').tree({   
		url:'<%=request.getContextPath()%>/adl/getZcfgTree.action?menuView='+menuView+'&projectId='+projectid,
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
				var code = node.attributes;
				var name = node.text;
				/*code_value = code;
				name_value = name; 
				var pnode = $("#tree").tree('getParent',node.target);
				if(pnode){
					code_value+=','+pnode.attributes;
					name_value=pnode.text+','+name_value;
				}
 			    ayy.push(code_value);*/
 			    ayy.push(name);
 			    return ayy;						
 			}else{
 				$.messager.alert('系统提示',"请选择一个节点",'warning');
                return;
 			} 
 		 }
</Script>
</head>
<body>
	  <div id="content" style="overflow: auto;">
    	<ul id='tree' class='easyui-tree'></ul>
	</div> 
</BODY>
</HTML>
