<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ page import="ais.sysparam.util.SysParamUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>总体方案</title>
		
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
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	    <script type="text/javascript" src="<%=basePath%>scripts/jquery-1.4.3.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>scripts/kindeditor/kindeditor-all.js"></script>
	    <link rel="stylesheet" href="<%=basePath%>scripts/kindeditor/themes/default/default.css" type="text/css"></link>
	    <script type="text/javascript" src="<%=basePath%>scripts/kindeditor/zh_CN.js"></script>
	    <script type="text/javascript" src="<%=basePath%>pages/operate/task/utilJs/auditSchemeEditor.js"></script>
		<style   type="text/css">    
		textarea {
			/** auto break line */
			word-wrap:break-word;word-break:break-all;
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
    	 /*
	      *  打开或关闭
		  */
		function triggerSearchTable(divid){
			var isDisplay1 = document.getElementById(divid).style.display;
			if(isDisplay1==''){
				document.getElementById(divid).style.display='none';
			}else{
				document.getElementById(divid).style.display='';
			}
		}
		//查看疑点	
		function go2(s){
	      window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
	    }

  		<%String right=request.getParameter("isView");%>

 
    	Ext.onReady(function(){
		    var winDigao;//查询窗口
		    var winYidian;//查询窗口
		    //toolbar工具栏
		    var toolbar=new Usp.ToolBar();
			toolbar.addBtn({btnType:'-'});
			toolbar.addBtn({btnType:'VIEW',btnStyle:'visible',handler:view});//查看底稿
			toolbar.addSeparator();
			toolbar.addBtn({btnType:'EXP',btnStyle:'visible',handler:baogao});//导出底稿
			toolbar.addSeparator(); 
			toolbar.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:search});//查询底稿
			var toolbarDoubt=new Usp.ToolBar();
			toolbarDoubt.addBtn({btnType:'-'});
			toolbarDoubt.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewDoubt});//查看疑点
			toolbarDoubt.addSeparator(); 
			toolbarDoubt.addBtn({btnType:'SEARCH',btnStyle:'visible',handler:searchYidian});//查询底稿
 
	
      		var toolMainbar=new Usp.ToolBar();//窗口上方的工具栏，我的底稿，我的疑点，底稿反馈，查看方案
		    toolMainbar.addBtn({btnType:'-'});
		    toolMainbar.addBtn({btnType:'MYDIGAO',btnStyle:'visible',handler:digao11});//我的底稿
		    toolMainbar.addSeparator(); 
		    toolMainbar.addBtn({btnType:'MYYIDIAN',btnStyle:'visible',handler:yidian11});//我的疑点
	  
       		<% if(!"true".equals(right)){%>
		      	if("enabled"=='${digaofankui}'){
		         toolMainbar.addSeparator(); 
		         toolMainbar.addBtn({btnType:'COMMENT',btnStyle:'visible',handler:feedback});//底稿反馈
		      	}
	   		<%}%>
		   toolMainbar.addSeparator(); 
	       toolMainbar.addBtn({btnType:'VIEWFANAN',btnStyle:'visible',handler:closefan});//查看方案
     
	       var toolbarLedger=new Usp.ToolBar();//审计问题grid的工具栏
	       toolbarLedger.addBtn({btnType:'-'});
	       toolbarLedger.addBtn({btnType:'VIEW',btnStyle:'visible',handler:viewLedgerOwner});
	
   
     		var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
                   cells:['formId','ms_name','ms_author_name','audit_dept_name','task_code','task_name','ms_author','fileCount','audit_found','ms_status','ms_statusName','ms_code','ms_date','project_id','prom','groupId']
			};
					
			 if("enabled"=='${taizhang}'){
		      var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
			 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',sortable:true,width:100,renderer: formatQtip},
	    	 {header:'底稿状态',dataIndex:'ms_statusName',sortable:true,width:50,align:'center'},
	         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:100,align:'center'},
	         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:120,align:'center'},
	         {header:'<div style="text-align:center">审计事项</div>',dataIndex:'task_name',width:100},
	         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:50,align:'center'},
	         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
	         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:70,sortable:true,align:'center'},
	         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:50,align:'center'},
	         {header:'提交日期',dataIndex:'ms_date',sortable:true,align:'center',width:70,
	        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
		             if(value!=null){
		             	 return value.substring(0,10);
		             }else{
		                 return null;
		             }
           		  } 
               }
         	 ];	
	      	}else{
	         var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
			 {header:'<div style="text-align:center">底稿名称</div>',dataIndex:'ms_name',sortable:true,width:100,renderer: formatQtip},
	    	 {header:'底稿状态',dataIndex:'ms_statusName',sortable:true,width:50,align:'center'},
	         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:100,align:'center'},
	         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:120,align:'center'},
	         {header:'审计事项',dataIndex:'task_name',width:100,sortable:true,align:'center'},
	         {header:'撰写人',dataIndex:'ms_author_name',sortable:true,width:50,align:'center'},
	         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
	         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:70,sortable:true,align:'center'},
	         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:50,align:'center'},
	         {header:'提交日期',dataIndex:'ms_date',sortable:true,align:'center',width:70,
	
	        	 renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
		             if(value!=null){
		              	return value.substring(0,10);
		             }else{
		                 return null;
		             }
	              
	           	} 
	 		  }
         	];	
	      }	
			
		   var gridDigao =new Usp.Grid({
	           gridConfig:{title:'审计底稿',collapsible:true,autoHeight:true,collapsed:
	           false,titleCollapse:true,animCollapse:false,region:'center' ,
	           tbar:toolbar.getToolPanel()},
			   isSelect:'2',
			   isRowNo:'1',
			   dataModel:dataModelDigao,
			   viewModel:viewModelDigao,
			   limit:100
			});
			
			//底稿加载数据
			<%String sdigao=request.getParameter("taskPid");%>
	        	      
	        <%if("-1".equals(sdigao)||sdigao==null){%>
	           gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'-1'});
	        <%}else{%>
	            gridDigao.getGridPanel().loadData({'audManuscript.flushdata':'1','audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'<%=request.getParameter("taskId")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>'});
	        <%}%>
	    
     
   
        
	         var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
	             cells:['doubt_id','doubt_status','doubt_statusName','audit_dept_name','task_code','task_name','doubt_code','fileCount','doubt_name','doubt_author','doubt_author_code','doubt_date','doubt_manu']
			 };
	        
	         var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
	         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',sortable:true,width:100,renderer: formatQtip},
	    	 {header:'疑点状态',dataIndex:'doubt_statusName',sortable:true,width:50,align:'center'},
	         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:100,align:'center'},
	         {header:'被审计单位',dataIndex:'audit_dept_name',sortable:true,width:150,align:'center'},
	         {header:'审计事项',dataIndex:'task_name',width:100,sortable:true,align:'center'},
	         {header:'撰写人',dataIndex:'doubt_author',sortable:true,width:50,align:'center'},
	         {header:'附件',dataIndex:'fileCount',sortable:true,width:30,align:'center'},
	         {header:'关联底稿',dataIndex:'doubt_manu',renderer:setDG,width:70,sortable:true,align:'center'},
	         {header:'提交日期',dataIndex:'doubt_date',sortable:true,align:'center',width:90,
        	 		renderer:function(value,cellmeta,record,rowIndex,columnIndex,color_store){
			             if(value!=null){
			             
			              return value.substring(0,10);
			             }else{
			                 return null;
			             }
           			} 
             	}
         	];	
         
        	var gridDoubt =new Usp.Grid({
	          	gridConfig:{title:'审计疑点',collapsible:true,autoHeight:true,collapsed:
	            false,titleCollapse:true,animCollapse:false,
	            tbar:toolbarDoubt.getToolPanel()},
			    isSelect:'2',
				isRowNo:'1',
				dataModel:dataModelDoubt,
				viewModel:viewModelDoubt,
				limit:100
		    });
		    
		    
		    //疑点加载数据
       		<%String syidian=request.getParameter("taskPid");%>
        	      
       		<%if("-1".equals(syidian)||syidian==null){%>
           		gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        	<%}else{%>
            	gridDoubt.getGridPanel().loadData({'audDoubt.flushdata':'1','audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
       		 <%}%>

       		 
       	    //-------审计问题的grid定义开始------------
             var dataModelLedger={url:'${pageContext.request.contextPath}/proledger/problem/loadLedgerListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
          		cells:['id','manuscript_code','sort_big_name','sort_small_name','problem_name','problem_money','problem_grade_name','manuscript_id','taskAssignName','p_unit','problem_desc']};
          	
          	//底稿穿透页面   
	         function diGaoView(value, cellmeta, record, rowIndex, columnIndex, store){
	         	 var manuscript_id=record.get("manuscript_id");
	         	 if(manuscript_id==''||manuscript_id==null)return '';
	         	 var url ='${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId='+manuscript_id;
	         	 var s='<a style="cursor:hand" href="javascript:void(0);" onclick="window.open('+url+',"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");return false">'+value+'</a>';
	     	     return s;
	         }		

             var viewModelLedger=[{header:'id',dataIndex:'id',hidden:true,sortable:true},
         	  {header:'底稿编号',dataIndex:'manuscript_code',sortable:true,width:100,align:'center',renderer:diGaoView},
              {header:'分组',dataIndex:'taskAssignName',sortable:true,width:70,align:'center'},
              {header:'问题类别',dataIndex:'sort_big_name',sortable:true,width:100,align:'center'},
              {header:'问题子类别',dataIndex:'sort_small_name',width:100,sortable:true,align:'center'},
              {header:'问题点',dataIndex:'problem_name',sortable:true,width:100,align:'center'},
              {header:'发生数',dataIndex:'problem_money',sortable:true,width:50,align:'center'},
              {header:'统计单位',dataIndex:'p_unit',width:50,sortable:true,align:'center'},
              {header:'问题定性',dataIndex:'problem_grade_name',width:100,sortable:true,align:'center'},
              {header:'问题描述',dataIndex:'problem_desc',width:150,sortable:true,align:'center'}
              ];	
              
             var gridLedger =new Usp.Grid({
               gridConfig:{title:'审计问题',collapsible:true,autoHeight:true,collapsed:
                          false,titleCollapse:true,animCollapse:false,
                tbar:toolbarLedger.getToolPanel()},
      		    isSelect:'2',
      			isRowNo:'1',
      			dataModel:dataModelLedger,
      			viewModel:viewModelLedger,
      			limit:100
      		});
      		//taskPid不同，显示的数据不同，taskPid=-1，显示全部的数据，taskPid为树节点的id 显示的是本级和下级的数据
            <%String ledger=request.getParameter("taskPid");%>
            <% if("-1".equals(ledger)||ledger==null){%>
               gridLedger.getGridPanel().loadData();
            <%}else{%>
            gridLedger.getGridPanel().loadData();
               gridLedger.getGridPanel().loadData({'taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>'});
            <%}%>
            
            //-------审计问题的grid定义结束------------
        



	 		Ext.QuickTips.init();
	 		//窗口的小面板，用来放我的底稿，我的疑点，底稿反馈，总体方案
		    var ct = new Usp.ui.Panel({
				collapsible:true,
				autoHeight:false,
				height:0,
				tbar: toolMainbar.getToolPanel(),
				collapsible:true,
				bodyStyle: {
				background: '#ffffff',
				padding: '7px'
				} 
			 
			}); 
 
	 
 
			//panel 渲染
		     var singlePanel1=new Usp.SinglePanel();
		     var singlePanel2=new Usp.SinglePanel();
		     var singlePanel3=new Usp.SinglePanel();
		     var singlePanel4=new Usp.SinglePanel();
		     
		     singlePanel3.main.add(ct);
		     singlePanel1.main.add(gridDigao.getGridPanel());
		     singlePanel2.main.add(gridDoubt.getGridPanel());
		     singlePanel4.main.add(gridLedger.getGridPanel());//审计问题
		     
		     
		     singlePanel1.main.render('operate-task-detail-list-1');
		     singlePanel2.main.render('operate-task-detail-list-2');
		     singlePanel3.main.render('ttt');
		     singlePanel4.main.render('operate-task-detail-list-3');
  
		      //handler
		    
		      function formatQtip(data,metadata){ 
		    	var title ="";
		    	var tip =data; 
		    	metadata.attr = 'ext:qtitle="' + title + '"' + ' ext:qtip="' + '双击查看' + '"';  
		    	return data;  
		   	 }
			   //双击事件，打开疑点
			   gridDoubt.getGridPanel().addListener('rowdblclick', rowdblclickFnDoubt);  
			   function rowdblclickFnDoubt(grid, rowindex, e){  //双击事件   
			   		grid.getSelectionModel().each(function(rec){    
					//alert(rec.get('doubt_id')); //fieldName，记录中的字段名   
					var doubt_id=rec.get('doubt_id');
			       
			        var checkCode='0';
			            DWREngine.setAsync(false);
				       DWREngine.setAsync(false);DWRActionUtil.execute(
				       { namespace:'/operate/doubt', action:'checkStatus', executeResult:'false' }, 
				       {'checkStatus':'000','doubt_id':doubt_id},xxx);
				       function xxx(data){
					      checkCode =data['checkCode'];
				       } 
				
				       if(checkCode=='1'){
				       
				       }else{
				           //alert("疑点已删除,请刷新数据后重新操作！");
					       return false;
				       }
			       
			        window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no"); 
				});  
			    }
			    
			     //双击事件，打开底稿
			    gridDigao.getGridPanel().addListener('rowdblclick', rowdblclickFnManu);  
			    function rowdblclickFnManu(grid, rowindex, e){  //双击事件   
			   		grid.getSelectionModel().each(function(rec){    
			        var formId=rec.get('formId');
			       var project_id=gridDigao.getFieldValue('project_id'); 
			       <% if(!"true".equals(right)){%>
			         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
				 
			       <%}else{%>
			         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			       <% }%>
				});  
			    }
   
              //渲染关联底稿链接
		      function setDG(value, cellmeta, record, rowIndex, columnIndex,store) { 
		       if (typeof record != 'undefined'&& record != null&& record != 'null'&&record.data["doubt_manu"]!=null){
		      
		        var tt3;
		        
		        var code3=record.data["doubt_manu"];
			    var codeArray3=code3.split(',');
		        var project_id = record.data["project_id"];
		        if(codeArray3[0]!=null&&codeArray3[0]!=''){
		            tt3='<a href=# onclick=goDG(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
		            tt3=tt3+"<br />";
		        }
		        return tt3; 
		         }else{
		          return '';
		         }
		      }
   
               //渲染关联疑点链接
			   function setYD(value, cellmeta, record, rowIndex, columnIndex,store) { 
			       if (typeof record != 'undefined'&& record != null&& record != 'null'&&record.data["audit_found"]!=null){
			      
			        var tt3;
			        var mc=record.data["manu"];
			        var dc=record.data["doubt"];
			        var code3=record.data["audit_found"];
				    var codeArray3=code3.split(',');
			        var project_id = record.data["project_id"];
			        if(codeArray3[0]!=null&&codeArray3[0]!=''){
			            tt3='<a href=# onclick=go2(\"'+codeArray3[0]+'\")>'+codeArray3[1]+'</a>';
			            tt3=tt3+"<br />";
			        }
			        
			        
			  
			        return tt3; 
			         }else{
			          return '';
			         }
			      } 
			     //导出底稿 
			     function baogao(){
			     
			        var selectedRows = (gridDigao.getGridPanel()).getSelectionModel().getSelections(); 
			        if(selectedRows.length==0){
			            alert("请选择要导出的底稿!");
			            return;
			        }                     
			      	var str = "";
			      	for(i=0;i <selectedRows.length;i++){
			               str += selectedRows[i].data.formId + ","; 
			      	}                                     
			      	document.getElementsByName('manuIds')[0].value=str;
			      	myform2.submit();
				}
     
     
                //反馈意见
			    function feedback(){
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
					  alert("只有组长、副组长和主审有权设置底稿反馈！");
					  return false;
				  }
				  //Usp.openTabPanelByFrame('yyyyy','修改方案','${contextPath}/operate/task/mainReadyEdit.action?project_id=${project_id}')
				  win = window.open("${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1","feedback","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			
				  var h = window.screen.availHeight;
			  	  var w = window.screen.width; 
					win.moveTo(0,0)   
					win.resizeTo(w,h) 
					if(win && win.open && !win.closed) 
			         win.focus();
				}
     
 
 	
 
		  	
		      //疑点查看
		      function viewDoubt(){
		       	if(isSingle(gridDoubt.getGridPanel())){
		       		var doubt_id=gridDoubt.getFieldValue('doubt_id');
		      		window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		      	}else{
		          //alert("请选择要查看的审计疑点!");
		      	}
		      }

		      //查看审计问题
		      function viewLedgerOwner(){
		    		if(isSingle(gridLedger.getGridPanel())){
		     		var id=gridLedger.getFieldValue('id');
		    		window.open("${contextPath}/proledger/problem/view.action?&id="+id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			      }
		     }
      
	      //底稿查看
	      function view(){
		       if(isSingle(gridDigao.getGridPanel())){
			       var formId=gridDigao.getFieldValue('formId');
			       var project_id=gridDigao.getFieldValue('project_id'); 
		      
			       <% if(!"true".equals(right)){%>
			         window.open("${contextPath}/operate/manu/view.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
				 
			       <%}else{%>
			         window.open("${contextPath}/operate/manu/viewAll.action?crudId="+formId+"&project_id="+project_id,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			       <% }%>
		      }else{
		    	 // alert("请选择要查看的审计底稿!");
		      }
	      }
	      
	  

       
      
       
      
       	//------------------查询form-------开始-----
 
        //---查询用到的方法
	    //底稿查询
		function query(){
        	gridDigao.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(simpleForm.getForm().getValues()));
        	gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='2';
			gridDigao.getGridPanel().getStore().reload({params:{start:0,limit:100}});

        }
        //疑点查询
        function queryYidian(){
        	gridDoubt.getGridPanel().getStore().baseParams=Ext.decode(Ext.encode(simpleFormYidian.getForm().getValues()));
        	gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='2';
			gridDoubt.getGridPanel().getStore().reload({params:{start:0,limit:100}});

        }
        
        // 打开或者关闭底稿查询窗口
         function search(){
            gridDigao.getGridPanel().getStore().baseParams['audManuscript.flushdata']='1';
            if(!winDigao){
	            if(typeof(winDigao)=='undefined'){
	              	simpleForm.render('manu-hello-tabs-main');
	            }
             	document.getElementById('manu-hello-tabs-main').style.display='';
             	winDigao=true;
           	}else{
             	document.getElementById('manu-hello-tabs-main').style.display='none';
            	winDigao=false;
           }
          }
          // 打开或者关闭疑点查询窗口
          function searchYidian(){
           		gridDoubt.getGridPanel().getStore().baseParams['audDoubt.flushdata']='1';
           		if(!winYidian){
             		if(typeof(winYidian)=='undefined'){
                		simpleFormYidian.render('doubt-hello-tabs-main');
             		}
             
             		document.getElementById('doubt-hello-tabs-main').style.display='';
             		winYidian=true;
              	}else{
              		document.getElementById('doubt-hello-tabs-main').style.display='none';
              		winYidian=false;
           }
          }
      
      //---底稿查询form----
      var simpleForm = new Ext.FormPanel({
        layout:'column',
        border:false,
        labelSeparator:'：',
        labelAlign: 'right',
        title: '底稿查询',
        buttonAlign:'center',
        bodyStyle:'padding:5px',
        
        frame:true,
        labelWidth:80,
         items:[{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '底稿名称',
                name: 'audManuscript.ms_name',
                anchor:'100%'
            }]

        },{

            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '审计事项',
                name: 'audManuscript.task_name',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '开始日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audManuscript.start_search',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '结束日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audManuscript.end_search',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '撰写人',
                name: 'audManuscript.ms_author_name',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'combo',
                fieldLabel: '被审计单位',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audManuscript.audit_dept_name', 'audit_dept_name'],
                       data : [${deptName}]
                }),
                hiddenName: 'audManuscript.audit_dept_name',
                valueField:'audManuscript.audit_dept_name',
                displayField:'audit_dept_name',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '底稿编码',
                name: 'audManuscript.ms_code',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'combo',
                fieldLabel: '底稿状态',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audManuscript.ms_status', 'ms_statusName'],
                       data : [['010','底稿草稿'],
                       <%
							if (  SysParamUtil.getSysParam("ais.project.dgfk")!=null&&
									 SysParamUtil.getSysParam("ais.project.dgfk")
											.equals("enabled")) {
						%>
                       ['020','正在征求'],
                       <%}%>
                       ['030','等待复核'],['040','正在复核'],['050','复核完毕'],['060','已经注销']]
                }),
                hiddenName: 'audManuscript.ms_status',
                valueField:'audManuscript.ms_status',
                displayField:'ms_statusName',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        }
        , <% if("-1".equals(sdigao)||sdigao==null){%>
           new Ext.form.Hidden({name:'audManuscript.task_id',value:'-1'}),
          <%}else{%>
          new Ext.form.Hidden({name:'audManuscript.task_id',value:'<%=request.getParameter("taskPid")%>'}),
          new Ext.form.Hidden({name:'audManuscript.flushdata',value:'1'}),
          new Ext.form.Hidden({name:'taskId',value:'<%=request.getParameter("taskId")%>'}),
          new Ext.form.Hidden({name:'taskPid',value:'<%=request.getParameter("taskPid")%>'}),
          <%}%>
		   
        
		 new Ext.form.Hidden({name:'audManuscript.project_id',value:'<%=request.getParameter("project_id")%>'}) 
		 ],

        buttons: [
				{text:'查询',handler:query},
				{text:'重置',
				handler:function(){
				formReset(simpleForm.getForm()); 
				}},{text:'关闭',handler:search}]
         });
         
         
         
       	//疑点查询form 
       	var simpleFormYidian = new Ext.FormPanel({
        layout:'column',
        border:false,
        labelSeparator:'：',
        labelAlign: 'right',
        title: '疑点查询',
        buttonAlign:'center',
        bodyStyle:'padding:5px',
        
        frame:true,
        labelWidth:80,
         items:[{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '疑点名称',
                name: 'audDoubt.doubt_name',
                anchor:'100%'
            }]

        },{

            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'textfield',
                fieldLabel: '审计事项',
                name: 'audDoubt.task_name',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '开始日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audDoubt.start_search',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                xtype:'datefield',
                fieldLabel: '结束日期',
                format: 'Y-m-d',
                editable:false,
                name: 'audDoubt.end_search',
                anchor:'100%'

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '撰写人',
                name: 'audDoubt.doubt_author',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'combo',
                fieldLabel: '被审计单位',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audDoubt.audit_dept_name', 'audit_dept_name'],
                       data : [${deptName}]
                }),
                hiddenName: 'audDoubt.audit_dept_name',
                valueField:'audDoubt.audit_dept_name',
                displayField:'audit_dept_name',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'textfield',
                fieldLabel: '疑点编码',
                name: 'audDoubt.doubt_code',
                anchor:'100%'
            }]

        },{
            columnWidth:.5,
            layout: 'form',
            border:false,
            items: [{
                 xtype:'combo',
                fieldLabel: '疑点状态',
                columnWidth:'.5',layout:'column',
                store :new Ext.data.SimpleStore({
                       fields: ['audDoubt.doubt_status', 'doubt_statusName'],
                       data : [['010','未处理'],['050','已处理无问题'],['055','已处理有问题']]
                }),
                hiddenName: 'audDoubt.doubt_status',
                valueField:'audDoubt.doubt_status',
                displayField:'doubt_statusName',
                typeAhead: true,
                editable:false,
                mode: 'local',
                triggerAction: 'all',
                emptyText:'请选择 ...',
                selectOnFocus:true,
                anchor:'100%',
                value:''

            }]

        }
        , <% if("-1".equals(sdigao)||sdigao==null){%>
           new Ext.form.Hidden({name:'audDoubt.task_id',value:'-1'}),
          <%}else{%>
          new Ext.form.Hidden({name:'audDoubt.task_id',value:'<%=request.getParameter("taskPid")%>'}),
          new Ext.form.Hidden({name:'audDoubt.flushdata',value:'1'}),
          new Ext.form.Hidden({name:'taskId',value:'<%=request.getParameter("taskId")%>'}),
          new Ext.form.Hidden({name:'taskPid',value:'<%=request.getParameter("taskPid")%>'}),
          <%}%>
		   
        
		 new Ext.form.Hidden({name:'audDoubt.project_id',value:'<%=request.getParameter("project_id")%>'}) 
		 ],

         buttons: [
				{text:'查询',handler:queryYidian},
				{text:'重置',
				handler:function(){
				formReset(simpleFormYidian.getForm()); 
				}},{text:'关闭',handler:searchYidian}]
         });
      
         
          
          //---------------查询form----结束----
          
		});//-----------------ext---结束-------------
	


       //查看底稿
	   function goDG(s){
		      window.open("/ais/operate/manu/viewAll.action?crudId="+s,"","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
		 }
		 
	   // 打开或者关闭div
	   function  closefan(){
	      triggerSearchTable('operate-task-detail-list-table')
	   }
	   
	   //打开底稿，调用父窗口的方法
	   function digao11(taskId,taskPid){
		   var project_id='${audProgramme.project_id}';
		   var sq='sq';
		  
		   var isView='<%=request.getParameter("isView")%>';
		   var isPem='<%=request.getParameter("permission")%>';
	       parent.digao(project_id,"-1",taskPid,sq,isView,isPem);
	    }
     
       //打开疑点，调用父窗口的方法
       function yidian11(taskId,taskPid){
          var project_id='${audProgramme.project_id}';
		  
		  var sq='sq';
		  var isView='<%=request.getParameter("isView")%>';
		  var isPem='<%=request.getParameter("permission")%>';
          parent.yidian(project_id,"-1",taskPid,sq,isView,isPem);
       }  

	</script>
	</head>
	<body>
		<center>
		 
        <div style="float: both;width: 100%;border: 1px solid #BABABA;"    id="operate-task-detail-list-4">
        <div id="ttt"></div>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post" >
             <div  style="display:none;"  id="operate-task-detail-list-table">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
               
					<tr class="titletable1">
						 
						<td class="edithead" colspan="2" onclick="triggerSearchTable('yiju')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;审计依据:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                           <div style="display: ;"  id="yiju">
							<s:textarea name="audProgramme.proAccord" readonly="true"
								cssStyle="width:100%;height:50;" />
                           </div>
						</td>
					</tr>
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('qingkuang')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;被审计单位基本情况:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                          <div style="display: ;"  id="qingkuang">
							<s:textarea name="audProgramme.auditDeptInfo" readonly="true"
								cssStyle="width:100%;height:50;" />
                           </div>
						</td>
					</tr>
			 
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('mubiao')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;审计目标:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                          <div style="display: ;"  id="mubiao">
							<s:textarea name="audProgramme.auditTarget" readonly="true"
							 	cssStyle="width:100%;height:50;" />
                          </div>
						</td>
					</tr>
 
				 </tr>
				 
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('zhongdian')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;审计内容的风险评估程序:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                          <div style="display:  ;"  id="zhongdian">
                          <script type="text/javascript">
                               auditFocus.readonly(true);
                           </script>
                          <textarea name="auditFocus" style="width:800px;height:400px;visibility:hidden;"><s:property value="audProgramme.auditFocus"/></textarea>
                          </div>
						</td>
					</tr>
					
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('pinggu')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;重要性水平和风险评估:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                        <div style="display:  ;"  id="pinggu">
                           <script type="text/javascript">
                               auditAssessment.readonly(true);
                           </script>
                           <textarea name="auditAssessment" style="width:800px;height:400px;visibility:hidden;"><s:property value="audProgramme.auditAssessment"/></textarea>
                       </div>
						</td>
					</tr>
					
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('shixiang')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;其他事项: 
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">
                           <div style="display: ;"  id="shixiang"> 
							<s:textarea name="audProgramme.other" readonly="true"
								cssStyle="width:100%;height:50;" />
                            </div>
						</td>
					</tr>
				</table>
				<br>
                </div>
                <s:hidden name="newDoubt_type"/>
				<s:hidden name="audProgramme.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />

			</s:form>
          
		</center>
  
		<form id="myform2" name="my_form2" action="/ais/operate/doubt/exportDigao.action?isArray=false" method="post" style="">
			<s:hidden name="manuIds" />
		</form>
		<table align="center" class="ListTable2">
	   		<tr>
	    		<td>
	     			<div id="manu-hello-win">
	       			</div> 
	        		<div id="manu-hello-tabs-main"  ></div>
	     			<div style="float: both;align:right;width: 100%;border: 1px solid #7CA4E9"   id="operate-task-detail-list-1"> </div><br>
	    		</td>
	   		</tr>
	     	<tr>
	    		<td>
	    			<div  id="doubt-hello-tabs-main"  ></div>
	     			<div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-2"></div>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    		    <br>
	     			<div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-3"> </div>
	    		</td>
	    	</tr>
	    </table> 
	</body>
</html>
