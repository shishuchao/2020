<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<title>修改实施方案</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script>

$(function(){
	 $('#taskTree').tree({
         url:'demo01.ashx',
         checkbox:true,
         onClick:function(node){
           alert(node.text);
         },
         onContextMenu: function(e, node){  
                       e.preventDefault();  
                       $('#taskTree').tree('select', node.target);  
                       $('#mm').menu('show', {  
                           left: e.pageX,  
                           top: e.pageY  
                       });  
                   }  
       });
	$('#Tree').tree({   
		url:"<%=request.getContextPath()%>/operate/task/getTaskByProId.action?project_id=${project_id}",
		lines:true,
	    onClick:function(node){
	    }
	});
});

</script>
</head>
<s:hidden name="project_id"></s:hidden>
<body  id='sjydBody'>
 	<div id="container" class='easyui-layout' fit='true'>
	     <div region="west" split="true" title="实施方案树" style="overflow:auto;width:250px;">
		      <table class="ListTable">
				 <tr>
					 <button  id='sendId'  class="easyui-linkbutton"  iconCls="icon-save">回传</button>&nbsp;
	        		 <button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>	&nbsp;
	        		 <button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>				
				 </tr>
			  </table>
		 	<br>
		 	<ul id="taskTree" class="easyui-tree"></ul>
		 	<div id="mm" class="easyui-menu" style="width: 120px;">
        		<div onclick="append()" iconcls="icon-add">添加节点</div>
      	 		<div onclick="remove()" iconcls="icon-remove">删除节点</div>
       		 	<div onclick="update()" iconcls="icon-edit">修改节点</div>
    		</div>
	     </div>  
	     <div region="center" style="overflow:hidden;">
		       <table id="sjydQueryDataTab"></table>
	     </div> 
     </div>
</body>
</html>