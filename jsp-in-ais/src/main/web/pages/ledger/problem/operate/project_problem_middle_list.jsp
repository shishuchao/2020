<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title>审计问题中间表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
        <script type="text/javascript">
		var isLeader = '${isLeader}';
		Ext.onReady(function(){
			Ext.BLANK_IMAGE_URL = '${pageContext.request.contextPath}/cloud/styles/extjs/resources/images/default/s.gif'; 
			//工具栏定义
			var toolbarAuditProblem=new Usp.ToolBar();
			
			/*if(${isView != 'true'}){
				if(isLeader == '1'){
					toolbarAuditProblem.addBtn({btnType:'extractive',btnStyle:'visible',handler:extractiveProblem});
		       		toolbarAuditProblem.addSeparator(); 
		       	}
			}*/
			
       		toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});
       		if(isLeader == '1'){
				/* toolbarAuditProblem.addBtn({btnType:'ADD',btnStyle:'visible',handler:addLedgerOwner});
	       		toolbarAuditProblem.addSeparator(); 
	       		toolbarAuditProblem.addBtn({btnType:'EDIT',btnStyle:'visible',handler:editLedgerOwner});
	       		toolbarAuditProblem.addSeparator(); */ 
	       		if('${view}' != 'view'){
	       			toolbarAuditProblem.addSeparator(); 
	       			toolbarAuditProblem.addBtn({btnType:'DEL',btnStyle:'visible',handler:piliangDelOwner});
	       		}
	       		
	       		toolbarAuditProblem.addSeparator(); 
        		toolbarAuditProblem.addBtn({btnType:'EXPLIST',btnStyle:'visible',handler:daoChuWenTi});
        	}
	         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerMiddleListJson.action?taskId=-1&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
	        		 cells:['id','p_unit','manuscript_id','problem_grade_name','problem_all_name','audit_object_name','manuscript_code','manuscript_name','sort_big_name','sort_small_name','sort_three_name','problem_name','problem_money','problemCount','weigui','audit_law','aud_mend_advice','creater_name','serial_num','remarks']
			 };

       		 var viewModelLedger=[
       		     {header:'id',dataIndex:'id',hidden:true,sortable:true},
       		     {header:'p_unit',dataIndex:'p_unit',hidden:true,sortable:true},
       		     {header:'manuscript_id',dataIndex:'manuscript_id',hidden:true,sortable:true},
       		    //{header:'被审计单位',dataIndex:'audit_object_name',sortable:true,width:150,align:'center',renderer: showTooTip},
   	             {header:"<div style='text-align:center;'>底稿名称</div>",dataIndex:'manuscript_name',sortable:true,width:150,align:'left',renderer: diGaoView},
   	             {header:'问题编号',dataIndex:'serial_num',sortable:true,width:150,align:'center',renderer: showTooTip},
                 {header:'问题类别',dataIndex:'problem_all_name',sortable:true,width:150,align:'center',renderer: showTooTip},
                 /* {header:'问题一级分类',dataIndex:'sort_big_name',sortable:true,width:100,align:'center',renderer: showTooTip},
                 {header:'问题子类别',dataIndex:'sort_small_name',width:100,sortable:true,align:'center',renderer: showTooTip},
                 {header:'问题二级分类',dataIndex:'sort_small_name',width:100,sortable:true,align:'center',renderer: showTooTip},
                 {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center',renderer: showTooTip},
                 {header:'问题三级分类',dataIndex:'sort_three_name',sortable:true,width:100,align:'center',renderer: showTooTip}, */
                 {header:'问题点',dataIndex:'problem_name',sortable:true,width:150,align:'center',renderer: showTooTip},
                 //{header:'发生数',dataIndex:'problem_money',sortable:true,width:50,align:'center',renderer: showTooTip},
                 {header:'发生金额',dataIndex:'problem_money',sortable:true,width:80,align:'center',renderer: showTooTip},
                 {header:'发生数量',dataIndex:'problemCount',sortable:true,width:80,align:'center',renderer: showTooTip},
                 {header:'审计发现类型',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center',renderer: showTooTip},
                 {header:'法规依据',dataIndex:'audit_law',width:150,sortable:true,align:'center',renderer: showTooTip},
                 {header:'处理建议',dataIndex:'aud_mend_advice',width:200,sortable:true,align:'center',renderer: showTooTip},
                 {header:'问题发现人',dataIndex:'creater_name',width:100,sortable:true,align:'center',renderer: showTooTip},
                 {header:'备注说明',dataIndex:'remarks',width:100,sortable:true,align:'center'}
             ];	

	        var gridLedger =new Usp.Grid({
	            gridConfig:{title:'',
	        				collapsible:true,
	        				autoHeight:false,
	        				height:Ext.getBody().getHeight()-panleHeight,
	        				collapsed:false,
	            			tbar:toolbarAuditProblem.getToolPanel()},
			    isSelect:'2',
				isRowNo:'1',
				dataModel:dataModelLedger,
				viewModel:viewModelLedger,
				limit:${page.limit20}
			});
	        
	        gridLedger.getGridPanel().loadData();
			var singlePanel=new Usp.SinglePanel();
			singlePanel.main.add(gridLedger.getGridPanel());
			singlePanel.main.render('operate-opr_ledger_list_mid');

			function showTooTip(data,metadata){
				if(data != null && data != ''){
					var title ="";
			        var tip =data; 
			        metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + tip + '"';  
				}
				return data;  
			}
			
			function showJinETooTip(data,metadata,record){
				if(data != null && data != ''){
					var pUnit = record.get("p_unit");
					if(pUnit=='元' || pUnit=='万元'){
						return data;
					}else{
						return '';
					}
				}
			}
			
			/*
			 *	提取审计问题
			 */
			 function extractiveProblem(){
				 //if(confirm('确认从项目中提取审计问题放入整改问题一览表吗?此操作将会删除整改问题一览表中所有原有数据!')){
				 if(confirm('确认从项目中提取审计问题放入入报告问题吗?此操作将会删除入报告问题中所有原有数据!')){
					 Usp.doGridAction({
					 	url:"${contextPath}/proledger/problem/extractiveProblem.action?project_id=<%=request.getParameter("project_id")%>",
					 	component:gridLedger
			     	 });
				 }
			 }
			
		    /*
	        *	增加审计问题
	        */
		    function addLedgerOwner(){
		    	Usp.doTabLoad({
		    		isFrame:true,
		    		url:'${contextPath}/proledger/problem/editMiddleLedgerProblem.action?project_id=<%=request.getParameter("project_id")%>',
		    		tabId:'common-data-dataframe-tab1',
				    pid:'common-data-dataframe-tab',
				    title:'增加审计问题'
				});
		    }
		    
			/*
			*	查看审计问题
			*/
			function viewLedgerOwner(){
	      		if(isSingle(gridLedger.getGridPanel())){
	       			var id=gridLedger.getFieldValue('id');
	      			window.open("${contextPath}/proledger/problem/view.action?id="+id+"&interaction=${interaction}","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	      			//window.open("${contextPath}/proledger/problem/viewMiddle.action?id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			    }
		     }
			
		    
		    /*
		    *	编辑审计问题
		    */
		    function editLedgerOwner(){
		         if(isSingle(gridLedger.getGridPanel())){
		        	 var id = gridLedger.getGridPanel().getSelectionModel().getSelections()[0].data.id;
		        	 Usp.doTabLoad({
		        		 isFrame:true,
		        		url:"${contextPath}/proledger/problem/editMiddleLedgerProblem.action?project_id=<%=request.getParameter("project_id")%>&id="+id+"",
						tabId:'common-data-dataframe-tab1',
					    pid:'common-data-dataframe-tab',
					    title:'修改审计问题'
		        	 });
		         }
	         }
		    
		    /*
		    *	批量删除审计问题
		    */
		    function piliangDelOwner(){
	           var selectedRows = gridLedger.getGridPanel().getSelectionModel().getSelections(); 
	           var selectIds = '';
        	   for(var i=0;i<selectedRows.length;i++){
	        	   var id=selectedRows[i].data.id;
	        	   selectIds = selectIds + id +',';
	           }
               if(selectIds==''){
                    alert("请选择要删除的数据！");
                    return;
               }
               if(confirm("确认删除吗？")){
              		Usp.doGridDelBatch({
    		       			component:gridLedger,
    		       			url:'${contextPath}/proledger/problem/ledgerMiddleDel.action',
    		       			params:{'id':selectIds}
          	  		 });
               }
		    }
		    
			/*
			*	导出问题
			*/
			function daoChuWenTi(){
				if(gridLedger.getGridPanel().getStore().getTotalCount()>0){
		           var selectedRows = gridLedger.getGridPanel().getSelectionModel().getSelections(); 
		           var selectIds = '';
	        	   for(var i=0;i<selectedRows.length;i++){
		        	   var id=selectedRows[i].data.id;
		        	   selectIds = selectIds + id +',';
		           }
					window.open("${contextPath}/proledger/problem/expMiddleLedgerProblemList.action?project_id=<%=request.getParameter("project_id")%>&id="+selectIds,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
				}else{
					alert("没有整改问题记录，不能进行导出操作");
					return;
				}
			}
			/*
			*	底稿穿透页面
			*/
			function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
	         	 var manuscript_id=record.get("manuscript_id");
	         	 if(manuscript_id=='' || manuscript_id==null){
	         		 return '';
	         	 }
	         	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
                 + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     	     return s;
	         }
			
	 	});
	</script>
	</head>
		<body>
			<div id='operate-opr_ledger_list_mid'></div>
		</body>
</html>