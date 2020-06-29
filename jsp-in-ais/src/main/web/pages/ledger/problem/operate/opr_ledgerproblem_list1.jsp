<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>我的任务-审计问题</title>

		<script type="text/javascript">	
		<%String owner="";%>

        //--ext-----开始----

		Ext.onReady(function(){

			Ext.BLANK_IMAGE_URL = '/ais/cloud/styles/extjs/resources/images/default/s.gif'; 
   			var winAuditProblem; //审计问题的查询窗口
			//toolbar
			var toolbarAuditProblem=new Usp.ToolBar();
			toolbarAuditProblem.addBtn({btnType:'-'});
	
			<%String right=request.getParameter("isView");%>
		       
       		<%if("true".equals(right)){%>
       		      toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});//查看
        	<%}else{%>
		          toolbarAuditProblem.addBtn({btnType:'ADD',btnStyle:'visible',handler:addLedgerOwner});//增加
			      toolbarAuditProblem.addSeparator(); 
			      toolbarAuditProblem.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editLedgerOwner});//编辑
			      toolbarAuditProblem.addSeparator(); 
			      toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});//查看
			      toolbarAuditProblem.addSeparator(); 
			      toolbarAuditProblem.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});//删除  
        	<%}%>
			   
		
			 //审计问题grid
	         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListJson.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
	        		 cells:['id','creater_code','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc']
			 };
             //view
       		 var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
   	             {header:'底稿编号',dataIndex:'manuscript_code',sortable:true,width:100,align:'center'},
                 {header:'分组',dataIndex:'taskAssignName',sortable:true,width:70,align:'center'},
                 {header:'问题类别',dataIndex:'sort_big_name',sortable:true,width:100,align:'center'},
                 {header:'问题子类别',dataIndex:'sort_small_name',width:100,sortable:true,align:'center'},
                 {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center'},
                 {header:'发生数',dataIndex:'problem_money',sortable:true,width:50,align:'center'},
                 {header:'统计单位',dataIndex:'p_unit',width:50,sortable:true,align:'center'},
                 {header:'问题定性',dataIndex:'problem_grade_name',width:50,sortable:true,align:'center'},
                 {header:'问题描述',dataIndex:'problem_desc',width:150,sortable:true,align:'center'}
             ];	
         
	        var gridLedger =new Usp.Grid({
	            gridConfig:{title:'审计问题',id:'common-data-datadetaillist-g2<%=owner%>',collapsible:true,autoHeight:false,height:window.screen.availHeight-240,collapsed:
	            false,
	            tbar:toolbarAuditProblem.getToolPanel()},
			    isSelect:'2',
				isRowNo:'1',
				dataModel:dataModelLedger,
				viewModel:viewModelLedger,
				limit:${page.limit20}
			});
      
	        gridLedger.getGridPanel().loadData();
		//panel渲染
	     var singlePanel=new Usp.SinglePanel();
	     singlePanel.main.add(gridLedger.getGridPanel());
	     singlePanel.main.render('operate-opr_ledger_list<%=owner%>');
	  
       //提示信息
	    function formatQtip(data,metadata){ 
	    	var title ="";
	    	var tip =data; 
	    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
	    	return data;  
	   	}

        //增加审计问题
	    function addLedgerOwner(){
	        addLedgerFrameOwner();
	    }	

	    //增加审计问题
		function addLedgerFrameOwner(){
			alert("1111");
			Usp.doTabLoad({url:'/ais/proledger/problem/editOprateLedgerProblem.action?id=0&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
				isFrame:true,
				tabId:'common-data-dataframe-tab<%=owner%>',
			    pid:'common-data-dataframe-tab5<%=owner%>'});              
		}

		  //编辑审计问题
	    function editLedgerOwner(){
	    	if(isSingle(gridLedger.getGridPanel())){
	     		var creater_code=gridLedger.getFieldValue('creater_code');
	       		var id=gridLedger.getFieldValue('id');
	     		if('${user.floginname}'==creater_code){
			    }else{
			    	alert("没有权限修改！");
			    	return false;
			    } 	                  
	         if(isSingle(gridLedger.getGridPanel())){
	        	 editLedgerFrameOwner(id);
	         }
	        }
         }

	       //编辑审计问题
		function editLedgerFrameOwner(id){
			Usp.doTabLoad({url:"/ais/proledger/problem/editDigao.action?owner=true&id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
			isFrame:true,
			tabId:'common-data-dataframe-tab<%=owner%>',
			pid:'common-data-dataframe-tab5<%=owner%>'});
		}

		//查看审计问题
        function viewLedgerOwner(){
      		if(isSingle(gridLedger.getGridPanel())){
       		var id=gridLedger.getFieldValue('id');
       
      		//window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	      }
       }

      //批量删除审计问题
        function piliangDelOwner(){
           var selectedRows = (gridLedger.getGridPanel()).getSelectionModel().getSelections(); 
                              
           var str = "";
           var myLedger=new Array()
   
           if(selectedRows.length==1){//一条数据，走单独删除
              delLedgerOwner();
           }else{
             for(i=0;i <selectedRows.length;i++){
                
            	 var creater_code=gridLedger.getFieldValue('creater_code');
  			  	 var project_id = selectedRows[i].data.project_id;   
  			  	 var id = selectedRows[i].data.id; 
       			if('${user.floginname}'==creater_code){
  		    	}else{
  		    		Ext.Msg.show({
  	                    title: '', 
  	                    msg: '所选取的审计问题 ['+selectedRows[i].data.doubt_name+'] 没有权限删除！',
  	                    icon: Ext.Msg.INFO,
  	                    minWidth: 300,
  	                    buttons: Ext.Msg.OK
                    	});
  		    		return false;
  				} 
             }
              for(i=0;i <selectedRows.length;i++){
                
                   
             }
                                    
       	  }
     
      	}
      	
      	//删除审计问题
      	function delLedgerOwner(){
       		if(isSingle(gridLedger.getGridPanel())){
       			var creater_code=gridLedger.getFieldValue('creater_code');
        	    var id=gridLedger.getFieldValue('id');
       			if('${user.floginname}'==creater_code){
  		          }else{
  		            alert("没有权限删除！");
  		        	return false;
  		        }
  			      
         		 Usp.doGridDel({
         			component:gridLedger,
         			url:'${pageContext.request.contextPath}/proledger/problem/delete.action',
         			params:{'id':id}
         		  });
     
      		}
      	}

 
	    
	 
    	 

	 });//--ext-----结束----
 
	</script>
	</head>
		<body>
			<div id='operate-opr_ledger_list<%=owner%>'></div>
	
			<div id="doubt-hello-win<%=owner%>">
	        
		        <div id="doubt-hello-tabs<%=owner%>">
		
				</div>
			</div>
		</body>
</html>