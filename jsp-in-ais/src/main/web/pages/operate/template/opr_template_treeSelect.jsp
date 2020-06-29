<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计实施方案</title>
		<SCRIPT type="text/javascript">
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
        }];
    var tree = new Usp.ColumnTree({
         		 text:'数据字典',
         		 expanded:true,
	 			 viewModel:viewModel,
	 			 dataUrl:'/ais/pages/operate/template/opr_template_tree.jsp', 
			     baseParams:{audTemplateId:'<%=request.getParameter("audTemplateId")%>',taskPid:'-1'}
				 });
        tree.getTreePanel().on('beforeload',function(node){
    	tree.getTreePanel().loader.baseParams.taskPid=node.attributes.taskTemplateId;
     });
     
        
     
        
 
     
    tree.getTreePanel().on('click',function(node,e){
    	//window.open('123','childBasefrm');
    	//window.top.frames['childBasefrm'].hello(node.attributes.type,node.attributes.taskTemplateId);
    	var id = node.attributes.taskTemplateId;
    	
    	var type = node.attributes.type;
    	var taskPid = node.attributes.taskPid;
    	var taskName = node.attributes.taskName;
    	var taskCode = node.attributes.taskCode;
    	var taskCodeCurr = '<%=request.getParameter("code")%>';
    	//alert(taskPid);
    	if(taskPid==-1){
    	alert("不能选择根节点！");
    	return false;
    	}
    	if(taskCode==taskCodeCurr){
    	alert("不能选择当前节点为前置事项！");
    	return false;
    	}
    	//window.top.frames['childBasefrm'].location.href="/ais/operate/template/showContent.action?&type="+type+"&taskPid="+taskPid+"&taskTemplateId="+id+"&audTemplateId=<%=request.getParameter("audTemplateId")%>";
    	document.getElementById('paraidvalue').value=taskCode;
    	document.getElementById('paranamevalue').value=taskName;
    	
    });    
  	//panel
     var singlePanel=new Usp.SinglePanel();
    
    singlePanel.main.add(tree.getTreePanel());
    //singlePanel.main.add(grid.getGridPanel());
    singlePanel.main.render('tree-ct');  
    
	
});
		
function getSelectedValue(){}
function att(obj){obj.style.background="red";}
function me(obj){var ss="";for( var s in obj){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}alert(ss);return ss;}
function me_not_null(obj){var ss="";for( var s in obj){if(obj[s]){ss+=" "+s+"=>"+obj[s];ss+="\r\n";}}alert(ss);}
  </script>

	 
	</head>
	<body>
		 
		<!-- EXAMPLES -->
		<div id="tree-ct">

		</div>

		<br />
		<br />
		<br />
		<br />
		<br />
		<div id="my_div"></div>
		<input type=hidden id="paraidvalue" value=""><input type=hidden id="paranamevalue" value="">
	</body>
</html>