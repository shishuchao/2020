<!DOCTYPE HTML>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	 <%  
	response.setHeader("Pragma", "no-cache");  
	response.setHeader("Cache-Control", "no-cache");  
	response.setDateHeader("Expires", 0);  
	%>

	<title>实施方案</title>
	<script type="text/javascript">
	
	//修改方案
	function edit(){
	    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	  if(result=='1'){
	  }else{
	  alert("只有组长、副组长和主审有权限修改方案！");
	  return false;
	  }
	  win = window.open('${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}','pro','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');

	  var h = window.screen.availHeight;
  	  var w = window.screen.width; 
		win.moveTo(0,0)   
		win.resizeTo(w,h) 
		if(win && win.open && !win.closed) 
         win.focus();
	}
	 //修改审计分工
	 function goedit6(){
	    var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
		} 
	 
	  	if(result=='1'){
	  	}else{
		  	alert("只有组长、副组长和主审有权限修改审计分工！");
		  	return false;
	  	}
		  win = window.open('${contextPath}/operate/task/project/mainTaskMember.action?project_id=${project_id}','promember','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		  var h = window.screen.availHeight;
	  	  var w = window.screen.width; 
			win.moveTo(0,0)   
			win.resizeTo(w,h) 
			if(win && win.open && !win.closed) 
	         win.focus();
	}
	
	
	//回传方案
	function goedit3(){
    	var resullt=''; 
	    var s='${project_id}';
		DWREngine.setAsync(false);
		DWREngine.setAsync(false);DWRActionUtil.execute(
		{ namespace:'/operate/task', action:'select', executeResult:'false' }, 
		{'project_id':s},xxx);
	     function xxx(data){
	     result =data['auth'];
         //alert(data['auth']);
		} 
	 
	  	if(result=='1'){
	 	 }else{
		  	alert("只有组长、副组长和主审有权限回传改方案！");
		  	return false;
	  	}
		var title="回传方案";
	    window.open('${contextPath}/operate/task/generate.action?project_id=${project_id}','ret','height=300px, width=500px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
    
    
	}
    //导出方案
	function goedit4(){
		location.href='${contextPath}/operate/doubt/exportTask.action?project_id=${project_id}';//
	}

    //--------------ext------------开始---
	Ext.onReady(function(){
	    //展开
		function goedit5(){
		  tree.expandAll();
		}
		//ext树上面的按钮，权限是组长、副组长、主审
		var btns=[
          <%String right=request.getParameter("isView");%>
          <% if("true".equals(right)){%>
	
	         {text:'导出',
	      		handler:goedit4,
	      		width:10
	      	 },{text:'展开',
	      		handler:goedit5,
	      		width:10
	      	 }
          <%}else{%>
          	{text:'修改',
        		handler:edit,
        		width:10
           	}, 
        	{text:'回传',
        		handler: goedit3,
        		width:10
        	},
        	{text:'导出',
        		handler:goedit4,
        		width:10
        	},{text:'展开',
        		handler:goedit5,
        		width:10
        	},{text:'分工',
        		handler:goedit6,//修改审计分工
        		width:10
        	}
        	<%}%>
        	];
        var btnBar1=new Usp.BtnBar({btn:btns,btnBarConfig:{width:40}}); 

        var Tree = Ext.tree;
        //ext树
	    var tree = new Tree.TreePanel({
	        useArrows: true,
	        autoScroll: true,
	        animate: true,
	        enableDD: true,
	         rootVisible:true,
	        containerScroll: true,
	        border: false,
	        // auto create TreeLoader
	           loader: new Ext.tree.TreeLoader({
	                        dataUrl:'/ais/pages/operate/task/opr_task_tree_check.jsp?viewTree=1&checkbox=false', //viewTree=1是显示，checkbox=false是不显示checkbox
	                         baseParams:{project_id:'<%=request.getParameter("project_id")%>',taskPid:'-1',userCode:'${user.floginname}'}
	                }),
	 
	        root: new Ext.tree.AsyncTreeNode({
	              text : '总体方案',
	              draggable : false,
	              id : 'root'
	      })
	        
	        
	    });

	      tree.on('beforeload',function(node){
	      if(typeof node.attributes.taskTemplateId  == 'undefined'){
	      		tree.loader.baseParams.taskPid='-1';
	      }else{
	      		tree.loader.baseParams.taskPid=node.attributes.taskTemplateId;
	      }
	    	
	      });
	     tree.on('load',function(node){
	    	 if(node.attributes.taskTemplateId=='${node}'){
	    	  
	    	  tree.selectPath(node.getPath());
	    	 }
	     });
     
           //单击事件
          tree.on("click", function(node, e){
               var taskPid = node.attributes.taskPid;
               var taskId = node.attributes.taskId;
               var taskTemplateId = node.attributes.taskTemplateId;
               var type = node.attributes.type;
               var project_id = node.attributes.project_id;
               if(taskPid=='-1'||typeof taskPid=='undefined'){ 
	                taskPid='-1';
	                project_id = '<%=request.getParameter("project_id")%>';
               }
               var u2 = '${pageContext.request.contextPath}/operate/taskExt/taskDetailListUi.action?coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'
               var u = '${pageContext.request.contextPath}/operate/task/project/showContentTypeView.action?coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>'
              <%-- if(taskPid=='-1'||typeof taskPid=='undefined'){ //打开总体方案，也就是跟节点
	               taskPid='-1';
	               project_id = '<%=request.getParameter("project_id")%>';
	               Usp.doTabLoad({
		                isFrame:true,
		                tabId:'common-data-dataframe-tab',
		                pid:'common-data-dataframe-tab1',
		                params:{taskId:taskId,taskTemplateId:taskTemplateId,taskPid:taskPid,project_id:project_id,permission:'<%=request.getParameter("permission")%>',isView:'<%=request.getParameter("isView")%>',coll:'0'},
		                url:u2
	                });
               }else{ --%>
            	   //打开审计事项，也就是叶子节点
                   Usp.doTabLoad({
	                    isFrame:true,
	                    tabId:'common-data-dataframe-tab',
	                    pid:'common-data-dataframe-tab2',
	                    params:{taskId:taskId,taskPid:taskPid,taskTemplateId:taskTemplateId,project_id:'<%=request.getParameter("project_id")%>',permission:'<%=request.getParameter("permission")%>',isView:'<%=request.getParameter("isView")%>',coll:'0'},
	                    url:u
                  });
                  
              // }
             });
     
 		tree.getRootNode().expand();
               
 
  		//panel 渲染
     	var singlePanel=new Usp.SinglePanel();
     	singlePanel.main.add(btnBar1.getBtnBarPanel());
    	singlePanel.main.add(tree);
	    singlePanel.main.render('tree-ct');  
    
	
	});//------------ext----结束----
   
    </script>

		
	</head>
	<body>
		<div id="tree-ct"></div>
	</body>
</html>