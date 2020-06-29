<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
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

		<script language="javascript">
		
		
		
		Ext.onReady(function(){



    var viewModel=[{header:'事项名称',dataIndex:'taskName',width:200},{header:'事项编码',
            width:100,
            dataIndex:'taskCode'},{
            header:'前置事项',
            width:100,
            dataIndex:'taskBeforeCode'
        }
    			    
    			   ];
    var tree = new Usp.ColumnTree({
         		 text:'数据字典',
         		 expanded:true,
	 			 viewModel:viewModel,
	 			 dataUrl:'/ais/pages/operate/task/opr_task_tree.jsp', 
			     baseParams:{project_id:'<%=request.getParameter("project_id")%>',taskPid:'-1',userCode:'${user.floginname}'}
				 });
        tree.getTreePanel().on('beforeload',function(node){
    	tree.getTreePanel().loader.baseParams.taskPid=node.attributes.taskTemplateId;
     });
     
     
     tree.getTreePanel().on("click", function(node, e){
               
    	 if(node.attributes[this.columns[1].dataIndex]==e.getTarget().innerHTML){
    		//popWin('http://host:port/fap/instanceAction.do?action=enter&templateId=20090505104748609', 
            //      'D20090505104748609', 650, 450)
    		return ;
    	}
    	//window.open('123','childBasefrm');
    	//window.top.frames['childBasefrm'].hello(node.attributes.type,node.attributes.taskTemplateId,node.attributes.taskPid);
    	var id = node.attributes.taskTemplateId;
    	var type = node.attributes.type;
    	var taskPid = node.attributes.taskPid;
    	window.top.frames['childBasefrm'].location.href="/ais/operate/task/showContent.action?&type="+type+"&taskPid="+taskPid+"&taskId="+id+"&project_id=<%=request.getParameter("project_id")%>";
    	
    });
               
  	//panel
     var singlePanel=new Usp.SinglePanel();
    
    singlePanel.main.add(tree.getTreePanel());
    //singlePanel.main.add(grid.getGridPanel());
    singlePanel.main.render('tree-ct');  
    
	
});
		

function att(obj){obj.style.background="red";}
function me(obj){var ss="";for( var s in obj){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}alert(ss);return ss;}
function me_not_null(obj){var ss="";for( var s in obj){if(obj[s]){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}}alert(ss);}
    
    </script>


	</head>
	<body>

		<!-- EXAMPLES -->
		<div id="tree-ct">
	</body>
</html>