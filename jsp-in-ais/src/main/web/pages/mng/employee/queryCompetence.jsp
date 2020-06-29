<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'code_name_tree.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
    <script type="text/javascript">
         $(function(){
        	 $('#tree').tree({
         		animate:true, 
 				method:'post',
 				lines:true,
 				dnd:true,
 				checkbox:true,
 				cascadeCheck:true,
 				url: '/ais/mng/employee/queryCompetence.action?query=data&zyzgCode=${param.zyzgCode}',
 				onClick:function(node){
 					//$(this).tree('toggle', node.target);
 				},
 				onDblClick:function(node){
 					window.parent.saveF();
 				}
 			});
         });
         function saveF(){
 			var nodes = $('#tree').tree('getChecked');			
 			var code_value = '';	
 			var name_value = '';	
 			var ayy = [];	
 			if (nodes.length>0) {	
 				for(var i = 0; i < nodes.length; i++) {
					var code = nodes[i].id;
 					var name = nodes[i].text;
 					if(i == 0){
 	 					code_value = code;
 	 					name_value = name; 
 					}else{
 						code_value += ',' + code;
 						name_value += ',' + name; 
 					}			
			    }
 			    ayy.push(code_value);
 			    ayy.push(name_value);
 			    return ayy;						
 			}else{
 				$.messager.alert('系统提示',"请勾选一个节点",'warning');
                return;
 			} 
 		 }
    </script>
  </head>
  
  <body class="easyui-layout">
    <div region="center" style="overflow:auto;">
       <br>
       <div fit="true" border="false">
	      <ul id="tree"></ul>
	  </div>
		<br>
	</div>
  </body>
</html>
