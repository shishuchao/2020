<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计实施方案</title>
		<SCRIPT type="text/javascript">
	function myGo(){
	window.location.href="${pageContext.request.contextPath}/test/auditEdit.action";
	}
	function doEdit(fid){
	alert('index.jspdddddd');
	//window.location.href="/cloud/pages/test/auditEdit.action?fid="+fid;
}
	</script>
		<LINK REL="SHORTCUT ICON" HREF="ufaud.ico" />

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
        <link rel="stylesheet" type="text/css"
			href="/ais/scripts/portal/tree/column-tree.css" />
			      <!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
		<script language="javascript">
		
		
		
		Ext.onReady(function(){



    var viewModel=[{header:'事项名称',dataIndex:'taskName',width:300},{header:'事项编码',
            width:100,
            dataIndex:'taskCode'} 
    			    
    			   ];
    var tree = new Usp.ColumnTree({
         		 text:'数据字典',
         		 expanded:true,
	 			 viewModel:viewModel,
	 			 dataUrl:'/ais/pages/operate/task/opr_task_tree.jsp?select=true', 
			     baseParams:{project_id:'<%=request.getParameter("project_id")%>',taskPid:'-1',userCode:'${user.floginname}'}
				 });
        tree.getTreePanel().on('beforeload',function(node){
    	tree.getTreePanel().loader.baseParams.taskPid=node.attributes.taskTemplateId;
    	
     });
     
     
     tree.getTreePanel().on("click", function(node, e){
            
    	  if(node.attributes.type=='2'){
    	  
    	  }else{
    	    alert("请选择末级节点!");
    	    return false;
    	  }
    	   var auth='0';
                 DWREngine.setAsync(false);
				  DWREngine.setAsync(false);DWRActionUtil.execute(
				 { namespace:'/operate/task', action:'checkTaskAssign', executeResult:'false' }, 
				 {'project_id':node.attributes.project_id,'taskTemplateId':node.attributes.taskTemplateId,'taskPid':node.attributes.taskPid},xxx);
			     function xxx(data){
				 auth =data['auth'];
			     
				 } 
				   

         // if(auth=='0'){
         //   alert("没有权限增加！");
         //   return false;  
         //  }
           //alert(node.attributes.taskTemplateId);
    	  getSelectedValue(node.attributes.taskTemplateId,node.attributes.viewName);
    	
    });
    tree.getTreePanel().expandAll();
               
  	//panel
     var singlePanel=new Usp.SinglePanel();
    
    singlePanel.main.add(tree.getTreePanel());
    //singlePanel.main.add(grid.getGridPanel());
    singlePanel.main.render('tree-ct');  
    
	
});
		
function getSelectedValue(id,name){
	 document.all("paranamevalue").value=name;
	  document.all("paraidvalue").value=id;
}
function att(obj){obj.style.background="red";}
function me(obj){var ss="";for( var s in obj){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}alert(ss);return ss;}
function me_not_null(obj){var ss="";for( var s in obj){if(obj[s]){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}}alert(ss);}
    
    </script>


	</head>
	<body>

		<!-- EXAMPLES -->
		<input type=hidden id="paraidvalue" value=""><input type=hidden id="paranamevalue" value="">
		<div id="tree-ct">
		<s:hidden name="treeValue"/>
	</body>
</html>