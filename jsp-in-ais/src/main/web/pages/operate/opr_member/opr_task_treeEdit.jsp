<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<%  
		response.setHeader("Pragma", "no-cache");  
		response.setHeader("Cache-Control", "no-cache");  
		response.setDateHeader("Expires", 0);  
		%> 
	<title>修改审计分工</title>
	<SCRIPT type="text/javascript">
 
	</script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/resources/css/ext-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/css/ux-all.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/common.css" />
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/cloud/styles/css/color-blue.css" />
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/jquery.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/adapter/jquery/ext-jquery-adapter.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/ext-all.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/StatusBar.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/ColumnNodeUI.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTabPanel.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/examples/ux/GroupTab.js"> </script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/extjs/locale/ext-lang-zh_CN.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/main.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/cloud/styles/js/ui.js"></script>
 		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<link rel="stylesheet" type="text/css"
			href="/ais/scripts/portal/tree/column-tree.css" />
		<script language="javascript">
		
		
   	//---------------ext----开始----		
   	Ext.onReady(function(){

	    var path = "";
	    var nodeId="";
	    //显示的列字段
	    var viewModel=[{header:'事项名称',dataIndex:'taskName',width:300},
	    			   {header:'事项编码',width:100,dataIndex:'taskCode'}
	    			   ];
	    			   
	    //显示的树			   
	    var tree = new Usp.ColumnTree({
	         		 expanded:true,
		 			 viewModel:viewModel,
		 			 dataUrl:'/ais/pages/operate/task/opr_task_tree.jsp?viewTree=0', //请求数据viewTree=0，不是查看页面，不显示msn而是对钩图标
				     baseParams:{project_id:'<%=request.getParameter("project_id")%>',taskPid:'-1',userCode:'${user.floginname}'}
					 });
	        tree.getTreePanel().on('beforeload',function(node){
	    	tree.getTreePanel().loader.baseParams.taskPid=node.attributes.taskTemplateId;
	     });
	         
	      tree.getTreePanel().on('load',function(node){
	    	// tree.getTreePanel().expandAll();
	    	 if(node.attributes.taskTemplateId=='${node}'){
	    	     tree.getTreePanel().selectPath(node.getPath());
	    	 }
	      });
	     
	     
	     //单击事件，在右侧页面打开
	     tree.getTreePanel().on("click", function(node, e){
	    	var id = node.attributes.taskTemplateId;
	    	var type = node.attributes.type;
	    	var taskPid = node.attributes.taskPid;
	    	project_id = '<%=request.getParameter("project_id")%>';
	    	path=node.getPath();
	    	if(taskPid=='-1'){//父节点taskPid=='-1'，显示一个根节点的页面
	    	   window.parent.frames['childBasefrm'].location.href="/ais/operate/task/project/showContentEdit.action?node="+node.attributes.taskTemplateId+"&path="+path+"&selectedTab=main&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>";
	    	}else{
	    	   window.parent.frames['childBasefrm'].location.href="/ais/operate/task/project/showContentEdit.action?taskTemplateId="+node.attributes.taskTemplateId+"&node="+node.attributes.taskTemplateId+"&path="+path+"&selectedTab=item&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>";
	    	}
	    	
	    });
	          
	               
	  	 //panel
	     //渲染
	     var singlePanel=new Usp.SinglePanel();
	     singlePanel.main.add(tree.getTreePanel());
	     singlePanel.main.render('tree-ct');  
	    
		
	});//-----------------ext-----------结束------
 
    </script>

		 
	</head>
	<body>
		<div id="tree-ct">
	</body>
</html>