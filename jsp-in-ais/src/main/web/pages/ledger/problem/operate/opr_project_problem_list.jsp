<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题</title>
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
		<link
			href="${pageContext.request.contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css" />
		<!-- 引入dwr的js文件 -->
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>

		<style type="text/css">
		textarea { /** auto break line */
			word-wrap: break-word;
			word-break: break-all;
		}
		
		.EditHead {
			background-image: url(../../images/ais/bg1a.jpg);
			background-repeat: repeat;
			height: 26px;
			text-align: left;
			vertical-align: middle;
			font-size: 12px;
			font-family: "simsun";
			font-weight: bold;
			color: #007FFF;
			background-repeat: repeat;
		}
		
		.ListTable {
			background-color: #7CA4E9;
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTable2 {
			font-size: 12px;
			border: 0px;
			width: 97%;
			margin: 0px;
		}
		
		.ListTableTr1 {
			BACKGROUND-COLOR: #F5F5F5;
			height: 22;
			vertical-align: middle;;
		}
		
		.ListTableTr2 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr22 {
			BACKGROUND-COLOR: #ffffff;
			width: 35%;
			height: 20;
			padding-left: 5px;
		}
		
		.ListTableTr3 {
			BACKGROUND-COLOR: #ffffff;
			height: 20;
			padding-left: 5px;
		}
		
		.titletable1 {
			background-color: #EEF7FF;
			height: 21;
		}
		</style>
		<script type="text/javascript">	
		
        //--ext-----开始----

		Ext.onReady(function(){

			Ext.BLANK_IMAGE_URL = '${pageContext.request.contextPath}/cloud/styles/extjs/resources/images/default/s.gif'; 
   			var winAuditProblem; //审计问题的查询窗口
			//toolbar
			var toolbarAuditProblem=new Usp.ToolBar();
			toolbarAuditProblem.addBtn({btnType:'-'});
       		toolbarAuditProblem.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});//查看
       		toolbarAuditProblem.addSeparator(); 
        	toolbarAuditProblem.addBtn({btnType:'EXPLIST',btnStyle:'visible',handler:expLedgerOwner});//导出
			 //审计问题grid
	         var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListJson.action?taskId=-1&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
	        		 cells:['id','manuscript_id','creater_code','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc','creater_name']
			 };

	         //底稿穿透页面   
	         function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
	         	 var manuscript_id=record.get("manuscript_id");
	         	 if(manuscript_id=='')return '';
	         	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open(\'${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id+'\',\''
                 + '\',\'width=800px,height=700px,toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no\');return false">'+value+'</a>';
	     	     return s;
	         }
			
             //view
       		 var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
   	             {header:'底稿编号',dataIndex:'manuscript_code',sortable:true,width:100,align:'center',renderer: diGaoView},
                 {header:'分组',dataIndex:'taskAssignName',sortable:true,width:70,align:'center'},
                 {header:'问题类别',dataIndex:'sort_big_name',sortable:true,width:100,align:'center'},
                 {header:'问题子类别',dataIndex:'sort_small_name',width:100,sortable:true,align:'center'},
                 {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center'},
                 {header:'发生数',dataIndex:'problem_money',sortable:true,width:50,align:'center'},
                 {header:'统计单位',dataIndex:'p_unit',width:50,sortable:true,align:'center'},
                 {header:'问题定性',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center'},
                 {header:'问题描述',dataIndex:'problem_desc',width:150,sortable:true,align:'center'},
                 {header:'问题发现人',dataIndex:'creater_name',width:50,sortable:true,align:'center'}
             ];	
         
	        var gridLedger =new Usp.Grid({
	            gridConfig:{title:'',collapsible:true,autoHeight:false,height:window.screen.availHeight-240,collapsed:
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

		//查看审计问题
        function viewLedgerOwner(){
      		if(isSingle(gridLedger.getGridPanel())){
       		var id=gridLedger.getFieldValue('id');
      		window.open("${contextPath}/proledger/problem/view.action?&id="+id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	      }
       }
       
       //导出审计问题
        function expLedgerOwner(){
    	   var selectedRows = gridLedger.getGridPanel().getSelectionModel().getSelections();
      		var selectIds = '';
      		if(selectedRows.length < 1){
      			alert('请您选择要导出的数据!');
      			return false;
      		}
      		for(var i=0;i<selectedRows.length;i++){
	        	   var id=selectedRows[i].data.id;
	        	   selectIds = selectIds + id +',';
	           }
      		window.open("${contextPath}/proledger/problem/expLedgerProblemListStatistics.action?id="+selectIds,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      		//window.open("${contextPath}/proledger/problem/expLedgerProblemList.action?taskId=-1&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>","","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
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
		</body>
</html>