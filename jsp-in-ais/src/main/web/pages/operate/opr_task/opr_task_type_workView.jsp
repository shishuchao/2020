<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<title>审计分工</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>		
</head>
<body class="easyui-layout" border="0">
	<div region="center" border="0">
		<table id="taskAssignTreeGrid"></table>
	</div>
<script type="text/javascript">
	var isAllExpand = false;
 	$(function() {
        $('#taskAssignTreeGrid').treegrid({
            url : '${contextPath}/operate/task/project/showContentTypeWorkView.action',
            queryParams : {
			'project_id':'${project_id}',
			'querySource':'treeGrid',		            
			'userCode': '${null!=user?user.floginname:user}'
            },
            idField : 'taskId',
            treeField : 'taskName',
            rownumbers : true,
			striped:true,
            fit : true,
            fitColumns : true,
            border : false,
			toolbar:[
				{
					id:'memberBatch',
					text:'组员批量分工',
					iconCls:'icon-client',
					handler:function(){
						goMember();
					}
				},
				/* {
					id:'groupBatch',
					text:'小组批量分工',
					iconCls:'icon-group',
					handler:function(){
						goGroup();
					}
				}, */
				{
					id:'expand',
					text:'展开全部',
					iconCls:'icon-expand',
					handler:function(){
						expandAll();
					}
				},
				{
					id:'export',
					text:'导出分工',
					iconCls:'icon-export',
					handler:function(){
						exportAssign();
					}
				}				
			],	
			columns:[[
		        {field:'taskName',  title:'事项名称', halign:'center', align:'left', width:'65%'},    
		        /* {field:'group',     title:'审计小组', halign:'center', align:'left', width:'100px'}, */    
		        {field:'taskAssign',title:'审计成员', halign:'center', align:'left', width:'250px', formatter:function(value, rowData, index){
		        	value = value ? value : "";
		        	if(value.length > 15){
		        		return "<div style='white-space:normal;word-break:break-all;word-wrap:break-word;border-width:0px;height:40px;width:100%;overflow-x:hidden;'  title='"+value+"'>"+value+"</div>"
		        	}else{
		        		return "<label title='"+value+"'>"+value+"</label>"
		        	}
		        	
		        }}    
			]],
					onExpand:function(row){
						if (!isAllExpand) return;
						var children = $("#taskAssignTreeGrid").treegrid('getChildren',row.taskId);
						if(children.length>0){
							var c;
							for (var i=0;i<children.length;i++) {
								c  = children[i];
								if (c.state=='closed' && c.type=='1')
									$('#taskAssignTreeGrid').treegrid("expand", c.taskId);
							}
						}
					}
  		    });
    });
       //导出分工
 	   function exportAssign(){
			location.href='${contextPath}/operate/doubt/exportTaskWork.action?project_id=${project_id}';//
	
	   }   
	   //小组批量分工
	   function goGroup(){
	        var project_id='${project_id}';
	        DWREngine.setAsync(false);
			DWREngine.setVerb("POST");
			DWREngine.setAsync(false);DWRActionUtil.execute(
			{ namespace:'/operate/task/project', action:'canOperateTaskBatchGroup', httpMethod:'POST',executeResult:'false' }, 
			{'project_id':project_id,'group':'true'},xxx);
		     function xxx(data){
		     	result =data['auth'];
			} 
			
			if(result=='0'){
				 $.messager.alert('提示信息','只有整体组的组长、副组长和主审有权操作!','info');
		         return false;
	        }else if(result=='2'){
	        	 $.messager.alert('提示信息','只有整体组单一小组，无法小组批量!','info');
		         return false;
	        }
	        var myurl = '/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=1';
	        parent.addTab('tabs','小组批量分工','groupAssigin',myurl,true);
	        /*win = window.open('/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=1','promember','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	        var h = window.screen.availHeight;
	  	    var w = window.screen.width; 
			win.moveTo(0,0)   
			win.resizeTo(w,h) 
			if(win && win.open && !win.closed) 
	         	win.focus();*/
	    }
      //组员批量分工
      function goMember(){
      	 var project_id='${project_id}';
         DWREngine.setAsync(false);
		 DWREngine.setVerb("POST");
		 DWREngine.setAsync(false);DWRActionUtil.execute(
		 {namespace:'/operate/task/project', action:'canOperateTaskBatchGroup', httpMethod:'POST',executeResult:'false' }, 
		 {'project_id':project_id,'group':'false'},xxx);
	     function xxx(data){
	     	result =data['auth'];
		} 
		
	     if(result=='0'){
			 $.messager.alert('提示信息','只有组长、副组长和主审有权操作!','info');
	         return false;
        }else if(result=='2'){
	         return false;
        }
        var myurl = '/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=2';
        parent.addTab('tabs','组员批量分工','memeberAssigin',myurl,true);
        /*	     
      	win = window.open('/ais/operate/task/project/mainTaskBatchMember.action?project_id=<%=request.getParameter("project_id")%>&gm=2','promember','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
      	var h = window.screen.availHeight;
  	  	var w = window.screen.width; 
		win.moveTo(0,0)   
		win.resizeTo(w,h) 
		if(win && win.open && !win.closed) 
         	win.focus();*/
   	 }	    	
	function expandAll(){
		isAllExpand = true;
		$('#taskAssignTreeGrid').treegrid("expandAll", null);
		window.setTimeout("isAllExpand = false;", 10000);
	}   	    
	function shrinkAll(){
		$('#taskAssignTreeGrid').treegrid('collapseAll');
	}
	
	//审计事项table上的超链接，审计事项的类型，分为1（事项类别）和2（末级具体事项）
	function task(s,q){
		//审计事项详情表格中显示的事项均为末级具体事项，不会出现（s=='1'）的情形
		if(s=='1'){
			var temp = '${contextPath}/operate/task/showContentTypeView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
			window.parent.addTab('tabs','查看事项','tempframe',temp,true);
		}else{
			var temp = '${contextPath}/operate/task/showContentLeafView.action?node='+q+'&type=1&taskTemplateId='+q+'&project_id=<%=request.getParameter("project_id")%>';
			window.parent.addTab('tabs','查看事项','tempframe',temp,true);
		}
	}
</script>
</body>
</html>

