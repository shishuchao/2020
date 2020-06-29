<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>我的任务列表</title>
		
		<script type="text/javascript">	

		 <%  
			response.setHeader("Pragma", "no-cache");  
			response.setHeader("Cache-Control", "no-cache");  
			response.setDateHeader("Expires", 0);  
			String owner = "-owner";
			String ownerStr = "true";
			
		%>
	 
     //-------------ext--------开始-----
     Ext.onReady(function(){

		 Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif'; 
		 
		 //-------------定义一个工具栏----
         var toolbar=new Usp.ToolBar();
         
         //-------------定义一个下拉选项----开始----
         var combo = new Ext.form.ComboBox({
     		store: new Ext.data.JsonStore({
		     	autoLoad:true,
		     	url:'/ais/pages/operate/opr_task/operate_group_data.jsp',
		     	baseParams:{project_id:'<%=request.getParameter("project_id")%>'},
		     	fields: ['catName','catCode']
  				}),
	        displayField: 'catName',
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'选择审计小组',
	        selectOnFocus:true,
	        width:135
    	});
    	//-------------定义一个下拉选项----结束----
    	 //-------------定义一个下拉选项----选择事件----
         combo.on('select', function(combo,record,index){
       		var v = combo.getName();
       		v=record.get('catCode');
        	gridItem.getGridPanel().loadData({'audTask.taskPid':'<%=request.getParameter("taskId")%>','audTask.groupCode':v,'audTask.project_id':'<%=request.getParameter("project_id")%>'}); 
        }
       );//添加事件 addDigaoFrame();
    
    
       //-------------把定义的下拉选项加入到工具栏里--------
       toolbar.getToolPanel().addField(combo);
       
       
       
       //grid
       //-------------审计事项grid--开始------
       
       
       	var dataModelItem={url:'${pageContext.request.contextPath}/operate/taskExt/getOwnerTaskListJson.action',
             cells:['taskTemplateId','taskMethod','taskPid','taskId','groupName','groupCode','taskNameView','taskName','taskCode','taskTarget','taskProgress','taskAssign','taskAssignBak','taskAssignName','project_id','id','cat_name','cat_code','taskMust','taskMustName','manu','doubt','ledgerNum']
		};
		
		var viewModelItem=[{header:'taskTemplateId',dataIndex:'taskTemplateId',hidden:true,sortable:true,dataIndex:'taskNameView',hidden:true,sortable:true},
		  {header:'taskPid',dataIndex:'taskPid',hidden:true,sortable:true},
		  {header:'<div style="text-align:center">审计事项  <p style="color: red;display: inline;">(还有${taskSum}个事项未完成)</p></div>',dataIndex:'taskName',width:300,renderer: formatQtip1},
		  {header:'<div style="text-align:center">底稿</div>',dataIndex:'manu',width:40},
		  {header:'<div style="text-align:center">疑点</div>',   width:40,dataIndex:'doubt'},
  		   {header:'<div style="text-align:center">问题</div>',width:40,dataIndex:'ledgerNum'}
		  
         ];	
         
         var gridItem =new Usp.Grid({
            gridConfig:{title:'',id:'common-data-datadetaillist-g2<%=owner%>',
            	collapsible:true,
            	autoHeight:false,
            	autoWidth:true,
            	collapsed:false,
            	height:Ext.getBody().getHeight(),
            	tbar:toolbar.getToolPanel()},
		    isSelect:'0',
		    isPaging:'0',
			isRowNo:'0',
			dataModel:dataModelItem,
			viewModel:viewModelItem
			 
		 });
		
		
			//单击事件 打开页面
			gridItem.getGridPanel().addListener('cellclick', rowdblclickFn);  
	        function rowdblclickFn(grid, rowindex, e){//单击事件   
   		    	grid.getSelectionModel().each(function(rec){    
            	var groupCode=rec.get('groupCode');
            	if(groupCode=='-1'){
             		return false;
            	}
               var taskPid = rec.get('taskPid');
               var taskId = rec.get('taskTemplateId');
               var taskTemplateId = rec.get('taskTemplateId');
               var type = "2";
               var project_id = rec.get('project_id');
               var taskName=rec.get('taskName');//审计事项名称
               if(taskPid=='-1'||typeof taskPid=='undefined'){ 
	                taskPid='-1';
	                project_id = '<%=request.getParameter("project_id")%>';
               }
               var u2 = '${pageContext.request.contextPath}/operate/taskExt/taskDetailListUi.action?groupCode='+groupCode+'&coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&owner='+<%=ownerStr%>
               var u = '${pageContext.request.contextPath}/operate/task/project/showContentTypeViewNew.action?groupCode='+groupCode+'&coll=0&taskTemplateId='+taskTemplateId+'&taskId='+taskId+'&taskPid='+taskPid+'&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&owner='+<%=ownerStr%>
               if(taskPid=='-1'||typeof taskPid=='undefined'){ 
	               taskPid='-1';
	               project_id = '<%=request.getParameter("project_id")%>';
	               Usp.doTabLoad({
	                isFrame:true,
	                tabId:'common-data-dataframe-tab<%=owner%>',
	                pid:'common-data-dataframe-tab1<%=owner%>',
	                params:{groupCode:groupCode,taskId:taskId,taskTemplateId:taskTemplateId,taskPid:taskPid,project_id:project_id,permission:'<%=request.getParameter("permission")%>',isView:'<%=request.getParameter("isView")%>',coll:'0'},
	                url:u2
	                });
               }else{
	                Usp.doTabLoad({
		            //title:'审计事项: '+taskName,
	                isFrame:true,
	                tabId:'common-data-dataframe-tab<%=owner%>',
	                pid:'common-data-dataframe-tab2<%=owner%>',
	                params:{groupCode:groupCode,taskId:taskId,taskPid:taskPid,taskTemplateId:taskTemplateId,project_id:'<%=request.getParameter("project_id")%>',permission:'<%=request.getParameter("permission")%>',isView:'<%=request.getParameter("isView")%>',coll:'0'},
	                url:u
	                });
               }
		});  
    	}
    	
    	//加载数据
     	<%String s=request.getParameter("taskPid");%>
        	      
        <%if("-1".equals(s)||s==null){%>
           gridItem.getGridPanel().loadData({'audTask.taskPid':'-1','audTask.groupCode':'-1','audTask.project_id':'<%=request.getParameter("project_id")%>'}); 
        <%}else{%>
            gridItem.getGridPanel().loadData({'audTask.taskPid':'<%=request.getParameter("taskId")%>','audTask.groupCode':'-1','audTask.project_id':'<%=request.getParameter("project_id")%>'}); 
        <%}%>
        
       //-------------审计事项grid--结束------
		//panel
	     var singlePanel=new Usp.SinglePanel();
	     singlePanel.main.add(gridItem.getGridPanel());
	     singlePanel.main.render('operate-operate_item_list<%=owner%>');
 
 
      
       //提示信息
       function formatQtip1(data,cellmeta,record,rowIndex,columnIndex,color_store){ 
    	var title ="";
    	var tip =data; 
    	//alert(record.get('taskNameView'));
    	cellmeta.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + record.get('taskNameView') + '"';  
    	return data;  
   	   }
   	   //提示信息
   	   function formatQtip2(data,cellmeta,record,rowIndex,columnIndex,color_store){ 
    	var title ="";
    	var tip =data; 
    	//alert(record.get('taskNameView'));
    	cellmeta.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + record.get('manu') + '"';  
    	return data;  
   	   }
      
 	});
     //-------------ext--------结束----
 
 
	</script>
	</head>
	<body>
		 <div id='operate-operate_item_list<%=owner%>'>
		 </div>
	 
	
	</body>
</html>