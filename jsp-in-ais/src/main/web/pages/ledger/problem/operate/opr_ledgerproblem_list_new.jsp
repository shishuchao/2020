<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题</title>

		<script type="text/javascript">	
		<%String owner=(String)request.getAttribute("owner");
		String isOwner="";
		if("true".equals(owner)){
			isOwner="-owner";
		}else{
			isOwner="";
		}
		%>
		
		

        //--ext-----开始----

		Ext.onReady(function(){

			Ext.BLANK_IMAGE_URL = '${pageContext.request.contextPath}/cloud/styles/extjs/resources/images/default/s.gif'; 
   			var winAuditProblem; //审计问题的查询窗口
			//toolbar
			var toolbarAuditProblem=new Usp.ToolBar();
			toolbarAuditProblem.addBtn({btnType:'-'});
	
			<%String right=request.getParameter("isView");%>
		       
       		<%if("true".equals(right)){%>
       		      toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});//查看
        	<%}else{%>
		          //toolbarAuditProblem.addBtn({btnType:'ADD',btnStyle:'visible',handler:addLedgerOwner});//增加
			      //toolbarAuditProblem.addSeparator(); 
			      //toolbarAuditProblem.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editLedgerOwner});//编辑
			      //toolbarAuditProblem.addSeparator(); 
			      toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});//查看
			      toolbarAuditProblem.addSeparator(); 
			      //toolbarAuditProblem.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});//删除  
        	<%}%> 
        	      toolbarAuditProblem.addSeparator(); 
			      toolbarAuditProblem.addBtn({btnType:'EXPLIST',btnStyle:'visible',handler:expLedgerOwner});//导出
		
			 //审计问题grid
	         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListJsonNew.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=${owner}&project_id=<%=request.getParameter("project_id")%>',
	        		 cells:['id','creater_code','isInReport','manuscript_code','problem_all_name','sort_big_name','sort_small_name','sort_three_name','problem_name','problemComment','problem_money','problemCount','weigui','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc','aud_mend_advice','creater_name']
			 };
			 
			 //底稿穿透页面   
	         function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
	         	 var manuscript_id=record.get("manuscript_id");
	         	 if(manuscript_id==''||manuscript_id==null)return '';
	         	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
                 + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     	     return s;
	         }
			
             //view
       		 var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
   	             {header:'底稿编号',dataIndex:'manuscript_code',sortable:true,width:100,align:'center',renderer: diGaoView},
   	          {header:'是否入报告',dataIndex:'isInReport',width:100,sortable:true,align:'center'},
   	          	{header:'问题类别',dataIndex:'problem_all_name',sortable:true,width:100,align:'center'},
                 //{header:'分组',dataIndex:'taskAssignName',sortable:true,width:70,align:'center'},
                 /* {header:'问题一级分类',dataIndex:'sort_big_name',sortable:true,width:100,align:'center'},
                 {header:'问题二级分类',dataIndex:'sort_small_name',width:100,sortable:true,align:'center'},
                 {header:'问题三级分类',dataIndex:'sort_three_name',sortable:true,width:100,align:'center'}, */
                 {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center'},
                 /* {header:'备注',dataIndex:'problemComment',sortable:true,width:50,align:'center'}, */
                 {header:'发生金额',dataIndex:'problem_money',sortable:true,width:50,align:'center'},
                 {header:'发生数量',dataIndex:'problemCount',sortable:true,width:50,align:'center'},
                 //{header:'统计单位',dataIndex:'p_unit',width:50,sortable:true,align:'center'},
                 //{header:'问题定性',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center'},
                 {header:'审计发现类型',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center'},
                 {header:'定性依据',dataIndex:'audit_law',width:150,sortable:true,align:'center'},
                 {header:'审计建议',dataIndex:'aud_mend_advice',width:150,sortable:true,align:'center'},
                 {header:'问题发现人',dataIndex:'creater_name',width:100,sortable:true,align:'center'}
             ];	
         
	        var gridLedger =new Usp.Grid({
	            gridConfig:{title:'审计问题',id:'common-data-datadetaillist-g2',collapsible:true,autoHeight:false,height:window.screen.availHeight-260,collapsed:
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
	     singlePanel.main.render('operate-opr_ledger_list');
	  
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
			Usp.doTabLoad({url:'/ais/proledger/problem/editOprateLedgerProblem.action?id=0&owner=<%=owner%>&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>',
				isFrame:true,
				tabId:'common-data-dataframe-tab',
			    pid:'common-data-dataframe-tab5'});              
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
			Usp.doTabLoad({url:"${contextPath}/proledger/problem/editOprateLedgerProblem.action?owner=${owner}&id="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>",
			isFrame:true,
			tabId:'common-data-dataframe-tab',
			pid:'common-data-dataframe-tab5'});
		}

		//查看审计问题
        function viewLedgerOwner(){
      		if(isSingle(gridLedger.getGridPanel())){
       		var id=gridLedger.getFieldValue('id');
       
      		window.open("${contextPath}/proledger/problem/view.action?&id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	      }
       }

      //批量删除审计问题
        function piliangDelOwner(){
           var selectedRows = (gridLedger.getGridPanel()).getSelectionModel().getSelections(); 
         
           if(selectedRows.length==1){//一条数据，走单独删除
              delLedgerOwner();
           }else{
             for(i=0;i <selectedRows.length;i++){
              	var creater_code=gridLedger.getFieldValue('creater_code');
       			if('${user.floginname}'==creater_code){
  		    	}else{
  		    		Ext.Msg.show({
  	                    title: '', 
  	                    msg: '所选取的审计问题 ['+selectedRows[i].data.problem_name+'] 没有权限删除！',
  	                    icon: Ext.Msg.INFO,
  	                    minWidth: 300,
  	                    buttons: Ext.Msg.OK
                    	});
  		    		return false;
  				} 
             }
              for(i=0;i <selectedRows.length;i++){
            	 
            	  var id=selectedRows[i].data.id;
                  var  j=i+1;
                  if(j==selectedRows.length){
                      Usp.doGridDel({
   		       		component:gridLedger,
   		       		url:'${pageContext.request.contextPath}/proledger/problem/ledgerDel.action',
   		       		params:{'id':id}
   		       	  }); 
                  }else{
                      Usp.doGridDelBatch({
   		       		component:gridLedger,
   		       		url:'${pageContext.request.contextPath}/proledger/problem/ledgerDel.action',
   		       		params:{'id':id}
   		       	  });
                  }
                   
             }
                                    
       	  }
      	}
      	
      	//导出审计问题
        function expLedgerOwner(){
      		window.open("${contextPath}/proledger/problem/expLedgerProblemList.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=${owner}&project_id=<%=request.getParameter("project_id")%>","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
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
         			url:'${pageContext.request.contextPath}/proledger/problem/ledgerDel.action',
         			params:{'id':id}
         		  });
     
      		}
      	}

        //grid的双击事件
        //gridLedger.getGridPanel().addListener('rowdblclick', rowdblclickLedger);  
        function rowdblclickLedger(grid, rowindex, e){  //双击事件   
       		grid.getSelectionModel().each(function(rec){    
            var id=rec.get('id');
           window.open("${contextPath}/proledger/problem/view.action?&id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
    	});  
        }
	    
	 
    	 

	 });//--ext-----结束----
 
	</script>
	</head>
		<body>
			<div id='operate-opr_ledger_list'></div>
	
			<div id="doubt-hello-win-owner">
	        
		        <div id="doubt-hello-tabs-owner">
		
				</div>
			</div>
		</body>
</html>