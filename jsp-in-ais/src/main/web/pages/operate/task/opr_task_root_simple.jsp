<!DOCTYPE HTML>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title></title>
		
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
		<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>
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
		 
<html>
 
 



	<body>
		<center>
        <div style="float: both;width: 100%;border: 1px solid #BABABA;"   id="operate-task-detail-list-4">
             <br>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post" >

				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">








					<tr class="titletable1">
						 
						<td class="edithead" colspan="2" onclick="triggerSearchTable('yiju')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;编制依据:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                           <div style="display: none;"  id="yiju">
							<s:textarea name="audProgramme.proAccord" readonly="true"
								cssStyle="width:100%;height:80;" />
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

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                          <div style="display: none;"  id="qingkuang">
							<s:textarea name="audProgramme.auditDeptInfo" readonly="true"
								cssStyle="width:100%;height:80;" />
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

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                          <div style="display: none;"  id="mubiao">
							<s:textarea name="audProgramme.auditTarget" readonly="true"
							 	cssStyle="width:100%;height:80;" />
                          </div>
						</td>
					</tr>
 
				 </tr>
				 
					<tr>
						<td class="edithead" colspan="2" onclick="triggerSearchTable('zhongdian')" style="cursor:hand" title="点击打开或关闭!">
							&nbsp;&nbsp;&nbsp;审计范围内容重点:
						</td>
						<td class="titletable1" colspan="2">
							 
						</td>

					</tr>
					<tr>

						<td class="ListTableTr22" colspan="4">

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                          <div style="display: none;"  id="zhongdian">
							<s:textarea name="audProgramme.auditFocus" readonly="true"
								cssStyle="width:100%;height:80;" />
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

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                        <div style="display: none;"  id="pinggu">
							<s:textarea name="audProgramme.auditAssessment" readonly="true"
								cssStyle="width:100%;height:80;" />
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

							<!--   <FCK:editor id="doubt.content" basePath="/ais/resources/fckedit/" height="300" toolbarSet="myDefault">
									${doubt.content}
								</FCK:editor> -->
                           <div style="display: none;"  id="shixiang"> 
							<s:textarea name="audProgramme.other" readonly="true"
								cssStyle="width:100%;height:80;" />
                            </div>
						</td>
					</tr>





				</table>

                <s:hidden name="newDoubt_type"/>
				<s:hidden name="audProgramme.doubt_id" />
				<s:hidden name="doubt_id" />
				<s:hidden name="type" />
				<s:hidden name="project_id" />

				 
				 

			</s:form>
			<br>
          
		</center>
  
		 
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


 
    Ext.onReady(function(){
    //toolbar工具栏
    var toolbar=new Usp.ToolBar();
	toolbar.addBtn({btnType:'-'});
	toolbar.addBtn({text: '查看',handler:view});
	toolbar.addSeparator();
	toolbar.addBtn({text: '导出底稿',handler:baogao});
	 if("enabled"=='${digaofankui}'){
	      toolbar.addSeparator(); 
	     toolbar.addBtn({text: '底稿反馈意见',handler:feedback});
	  }
	
    var toolbarItem = new Usp.ToolBar();
	toolbarItem.addBtn({btnType:'-'});
	toolbarItem.addBtn({text: '查看',handler:viewItem});
	var toolbarDoubt=new Usp.ToolBar();
	toolbarDoubt.addBtn({btnType:'-'});
	toolbarDoubt.addBtn({text: '查看',handler:viewDoubt});
	
 
	
 
    
    
    
    
    
     var dataModelDigao={url:'${pageContext.request.contextPath}/operate/manuExt/manuListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
                   cells:['formId','ms_name','ms_author_name','task_code','fileCount','audit_found','ms_author','ms_status','ms_statusName','ms_code','ms_date','project_id']
		};
					
	    if("enabled"=='${taizhang}'){
	      	var viewModelDigao=[{header:'formId',dataIndex:'formId',hidden:true,sortable:true},
		 {header:'<div style="text-align:center">底稿名称2</div>',dataIndex:'ms_name',width:150},
    	 {header:'底稿状态',dataIndex:'ms_statusName',width:70,sortable:true,align:'center'},
         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:150,align:'center'},
         {header:'所属审计事项',dataIndex:'task_code',width:100,align:'center'},
         {header:'提交人',dataIndex:'ms_author_name',sortable:true,width:100,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:80,align:'center'},
         {header:'审计问题数量',dataIndex:'prom',sortable:true,width:80,align:'center'},
         {header:'创建日期',dataIndex:'ms_date',sortable:true,width:100,align:'center',

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
		 {header:'<div style="text-align:center">底稿名称1</div>',dataIndex:'ms_name',width:150},
    	 {header:'底稿状态',dataIndex:'ms_statusName',width:70,sortable:true,align:'center'},
         {header:'底稿编码',dataIndex:'ms_code',sortable:true,width:150,align:'center'},
         {header:'所属审计事项',dataIndex:'task_code',width:100,align:'center'},
         {header:'提交人',dataIndex:'ms_author_name',sortable:true,width:100,align:'center'},
         {header:'附件',dataIndex:'fileCount',sortable:true,width:50,align:'center'},
         {header:'关联疑点',dataIndex:'audit_found',renderer:setYD,width:80,align:'center'},
         {header:'创建日期',dataIndex:'ms_date',sortable:true,width:100,align:'center',

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
			limit:${page.limit100}
		});
		<%String sdigao=request.getParameter("taskPid");%>
        	      
       <% if("-1".equals(sdigao)||sdigao==null){%>
           gridDigao.getGridPanel().loadData({'audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'-1'});
        <%}else{%>
            gridDigao.getGridPanel().loadData({'audManuscript.project_id':'<%=request.getParameter("project_id")%>','audManuscript.task_id':'<%=request.getParameter("taskId")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>'});
        <%}%>
    
     
   
        
         var dataModelDoubt={url:'${pageContext.request.contextPath}/operate/doubtExt/doubtListByPidJson.action?permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>',
             cells:['doubt_id','doubt_status','doubt_statusName','task_code','doubt_code','doubt_name','doubt_author','doubt_author_code','doubt_date']
		};
        
        var viewModelDoubt=[{header:'doubt_id',dataIndex:'doubt_id',hidden:true,sortable:true},
         {header:'<div style="text-align:center">疑点名称</div>',dataIndex:'doubt_name',width:150},
    	 {header:'疑点状态',dataIndex:'doubt_statusName',sortable:true,width:100,align:'center'},
         {header:'疑点编码',dataIndex:'doubt_code',sortable:true,width:150,align:'center'},
          {header:'所属事项',dataIndex:'task_code',sortable:true,width:100,align:'center'},
         {header:'提交人',dataIndex:'doubt_author',sortable:true,width:100,align:'center'},
         {header:'创建日期',dataIndex:'doubt_date',sortable:true,align:'center',width:100,

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
		    isSelect:'1',
			isRowNo:'1',
			dataModel:dataModelDoubt,
			viewModel:viewModelDoubt,

			
			limit:${page.limit100}
		});
       <%String syidian=request.getParameter("taskPid");%>
        	      
       <% if("-1".equals(syidian)||syidian==null){%>
           gridDoubt.getGridPanel().loadData({'audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        <%}else{%>
            gridDoubt.getGridPanel().loadData({'audDoubt.doubt_type':'YD','audDoubt.project_id':'<%=request.getParameter("project_id")%>','taskPid':'<%=request.getParameter("taskPid")%>','taskId':'<%=request.getParameter("taskId")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
 
	
 



	 Ext.QuickTips.init();



 
	 
 
	//panel
     var singlePanel1=new Usp.SinglePanel();
     var singlePanel2=new Usp.SinglePanel();
     singlePanel1.main.add(gridDigao.getGridPanel());
     singlePanel2.main.add(gridDoubt.getGridPanel());
     singlePanel1.main.render('operate-task-detail-list-1');
     singlePanel2.main.render('operate-task-detail-list-2');
  
    //handler
   
   function saveMain(){
    window.frames['task_main'].saveFormType();
   }
   
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
       
       //Usp.doPost({
       //				component:gridDigao,
       //				url:'${pageContext.request.contextPath}/operate/doubt/exportDigao.action',
       //				params:{'manuIds':str,'isArray':false}
       //			});
     myform2.submit();
	}
     
         function setYD(value, cellmeta, record, rowIndex, columnIndex,store) { 
       
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
      } 
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
	  win = window.open("${contextPath}/operate/manu/feedback.action?project_id=<%=request.getParameter("project_id")%>&taskPid=-1","feedback","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");

	  var h = window.screen.height;
  	  var w = window.screen.width; 
		win.moveTo(0,0)   
		win.resizeTo(w,h) 
		if(win && win.open && !win.closed) 
         win.focus();
	}
     
 
   function subExport(){
    location.href='${contextPath}/operate/doubt/exportSubTask.action?project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>';//
   }
   
   function checkMain()
   {
    window.frames['task_main'].checkFormType("1");
   }
      function uncheckMain()
   {
    window.frames['task_main'].checkFormType("0");
   }
    function add(){
      addDigaoFrame();
    }	
   function edit(){
   if(isSingle(gridDigao.getGridPanel())){
   var ms_author=gridDigao.getFieldValue('ms_author');
        var ms_status=gridDigao.getFieldValue('ms_status');
            //删除
          if('${user.floginname}'==ms_author){
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
		                  
      if('010'==ms_status){
		                    //alert("123");
		                  }else{
		                    alert("只有底稿草稿状态可以修改！");
		                    return false;
		                  }
   var ms_id=gridDigao.getFieldValue('formId');
alert(ms_id)
     editDigaoFrame(ms_id);
    }
   } 
   function addDoubt(){
   
      addDoubtFrame();
      
    }	
    function editDoubt(){
    if(isSingle(gridDoubt.getGridPanel())){
     var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      var doubt_status=gridDoubt.getFieldValue('doubt_status');
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
	 if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能修改！");
		                    return false;
		                  }   	                  
    if(isSingle(gridDoubt.getGridPanel())){
     var doubt_id=gridDoubt.getFieldValue('doubt_id');
     editDoubtFrame(doubt_id,'YD');
         }
         }
         }
      function viewDoubt(){
       if(isSingle(gridDoubt.getGridPanel())){
       var doubt_id=gridDoubt.getFieldValue('doubt_id');
      window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
      }else{
          alert("请选择要查看的审计疑点!");
      }
      }
     function view(){
           
    
       if(isSingle(gridDigao.getGridPanel())){
       var formId=gridDigao.getFieldValue('formId');
       var project_id=gridDigao.getFieldValue('project_id'); 
      window.open("${contextPath}/operate/manu/view.action?crudId='+formId+'&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
      }else{
    	  alert("请选择要查看的审计底稿!");
      }
      }
      function viewItem(){
      }
      function editItem(){
      }
     function del(){
             if(isSingle(gridDigao.getGridPanel())){
        var ms_author=gridDigao.getFieldValue('ms_author');
        var ms_status=gridDigao.getFieldValue('ms_status');
            //删除
          if('${user.floginname}'==ms_author){
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
      if('010'==ms_status){
		                    //alert("123");
		                  }else{
		                    alert("只有底稿草稿状态可以删除！");
		                    return false;
		                  }
		  
       var id=gridDigao.getFieldValue('formId');
       Usp.doGridDel({
       				component:gridDigao,
       				url:'${pageContext.request.contextPath}/operate/manuExt/manuDel.action',
       				params:{'audManuscript.formId':id}
       			});
      }
      <%String q=request.getParameter("taskPid");%>
        	      
       <% if("-1".equals(q)||q==null){%>
 
           gridFound.getGridPanel().loadData({'audDoubt.doubt_type':'FX','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'-1'});
        <%}else{%>
            gridFound.getGridPanel().loadData({'audDoubt.doubt_type':'FX','audDoubt.project_id':'<%=request.getParameter("project_id")%>','audDoubt.task_id':'<%=request.getParameter("taskId")%>'});
        <%}%>
        
      }

      function viewItem(){
         if(isSingle(gridItem.getGridPanel())){
          var taskId=gridItem.getFieldValue('taskId'); 
          var taskTemplateId=gridItem.getFieldValue('taskTemplateId'); 
          var taskPid=gridItem.getFieldValue('taskPid'); 
          var project_id=gridItem.getFieldValue('project_id'); 
          //alert("/operate/task/showContentLeafView.action?taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&taskPid="+taskPid+"&project_id="+project_id);
          window.open("${contextPath}/operate/task/showContentLeafView.action?taskId="+taskId+"&taskTemplateId="+taskTemplateId+"&taskPid="+taskPid+"&project_id="+project_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
         }else{
       	  alert("请选择要查看的审计事项!");
         }
         }
    function delDoubt(){
     if(isSingle(gridDoubt.getGridPanel())){
     var doubt_author_code=gridDoubt.getFieldValue('doubt_author_code');
      var doubt_status=gridDoubt.getFieldValue('doubt_status');
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		 if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能删除！");
		                    return false;
		                  }                  
     var id=gridDoubt.getFieldValue('doubt_id');
       Usp.doGridDel({
       				component:gridDoubt,
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
       				params:{'audDoubt.doubt_id':id}
       			});
   
    }
    }
    function addFound(){
       addFoundFrame();
    }	
    function editFound(){
    if(isSingle(gridFound.getGridPanel())){
     var doubt_author_code=gridFound.getFieldValue('doubt_author_code');
     var doubt_status=gridFound.getFieldValue('doubt_status');
     
     if('${user.floginname}'==doubt_author_code){
		                    //alert("123");
		                  }else{
		                    alert("没有权限修改！");
		                    return false;
		                  }
    if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能修改！");
		                    return false;
		                  }
     var doubt_id=gridFound.getFieldValue('doubt_id');
     editFoundFrame(doubt_id);
    
      }
   }
      function viewFound(){
      if(isSingle(gridFound.getGridPanel())){
       var doubt_id=gridFound.getFieldValue('doubt_id');
      window.open("${contextPath}/operate/doubt/view.action?type=FX&doubt_id="+doubt_id,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
      }
      }
      
      function setcz(value, cellmeta, record, rowIndex, columnIndex,store) { 
        var str="<a href='javascript:void(0);' onclick='javascript:digao(\""+value+"\")'>底稿</a>&nbsp;&nbsp;<a href='javascript:void(0);'>发现</a>&nbsp;&nbsp;<a href='#'>疑点</a>";
 
        return str; 
      } 
      
     
      
       function setdo(value) { 
        var str = "<select ><option value='0' selected>未执行</option><option value='0'>未执行</option><option value='1'>已执行</option></select>"; 
        return str; 
      } 
      
      function delFound(){
      if(isSingle(gridFound.getGridPanel())){
        var doubt_author_code=gridFound.getFieldValue('doubt_author_code');
        var doubt_status=gridFound.getFieldValue('doubt_status');
            //删除
          if('${user.floginname}'==doubt_author_code){
		                  }else{
		                    alert("没有权限删除！");
		                    return false;
		                  }
		                  
      if('010'==doubt_status){
		                    //alert("123");
		                  }else{
		                    alert("已处理状态不能删除！");
		                    return false;
		                  }
		  
       var id=gridFound.getFieldValue('doubt_id');
       Usp.doGridDel({
       				component:gridFound,
       				url:'${pageContext.request.contextPath}/operate/doubtExt/doubtDel.action',
       				params:{'audDoubt.doubt_id':id}
       			});
      }
      }
});


function setdo(value, cellmeta, record, rowIndex, columnIndex,store) { 
	//alert(222);
    var tt=record.data["taskTemplateId"];
    if(value==null||value=='null'||value==0||value=='0'){
    var str = "<select id ='"+tt+"'  ><option value='0' selected >未执行</option><option value='2'>已执行，无记录</option><option value='1'>已执行，有记录</option></select>"; 
     return str;
    }else if(value==2||value=='2' ){
     var str = "<select id ='"+tt+"' ><option value='0' >未执行</option><option value='2' selected >已执行，无记录</option><option value='1'>已执行，有记录</option></select>"; 
     return str;
    }else {
     var str = "<select id ='"+tt+"' ><option value='0' >未执行</option><option value='2' >已执行，无记录</option><option value='1' selected>已执行，有记录</option></select>"; 
     return str;
    }
}
  function go2(s){
	  window.open("${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+s,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no");
	}

	</script>
	</head>
	<body>
	<form id="myform2" name="my_form2" "
				action="/ais/operate/doubt/exportDigao.action?isArray=false" method="post"
				style="">
				<s:hidden name="manuIds" />
	<table align="center" class="ListTable2">
   <tr>
    <td>
     <div style="float: both;align:right;width: 100%;border: 1px solid #7CA4E9"   id="operate-task-detail-list-1"> </div><br>
    </td>
   </tr>
   
     <tr>
    <td>
     <div style="float: both;width: 100%;border: 1px solid #7CA4E9;"   id="operate-task-detail-list-2"> </div>
    </td>
    </tr>
   </table> 
   </form>
	</body>
</html>
