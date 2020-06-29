<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计底稿列表</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	<%-- 	<script type='text/javascript' src='/ais/dwr/util.js'></script> --%>
	</head>
		<div id="manuList" style="margin-left: 0px"></div>
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<script type="text/javascript">
			$(function(){
				project_id='${project_id}';
				// 初始化生成表格
				$('#manuList').datagrid({
					url : "/ais/proledger/problem/getSureManu.action?querySource=grid&project_id="+project_id,
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit:true,
					idField:'formId',
					fitColumns: false,	
					border:false,
					singleSelect:false,
					remoteSort: false,
					toolbar:[
						{
							id:'exportZH',
							text:'下载',
							iconCls:'icon-export',
							handler:function(){
								exportZH();
							}
						}		
					],
					frozenColumns:[[
					       			{field:'formId',title:"复选框", halign:'center',checkbox:true, align:'center'},
		       						{field:'ms_name',title:'底稿名称',halign:'center',width:250,sortable:true,align:'left',
					       				formatter:function(value,row,rowIndex){
											return "<a href=\"javascript:void(0)\" onclick=\"viewManu('"+row.formId+"')\">"+row.ms_name+"</a>"
										}	
		       						},
		       						{field:'ms_status',title:'底稿状态',halign:'center',width:80,sortable:true,align:'center',
		       							formatter:function(value,row,rowIndex){
		       								if(value == '010'){
		       									return "底稿草稿";
		       								}else if(value == '020'){
		       									return "正在征求";
		       								}else if(value == '030'){
		       									return "等待复核";
		       								}else if(value == '040'){
		       									return "正在复核";
		       								}else if(value == '050'){
		       									return "复核完毕";
		       								}else if(value == '060'){
		       									return "已经注销";
		       								}
										}
		       						}
					    		]],
					columns:[[  
		       		/* 	{field:'manuTypeName',title:'底稿类型',halign:'center',width:70,sortable:true,align:'center'},		 */
		       		
		       			{field:'task_name',title:'审计事项',halign:'center',width:270,sortable:true,align:'left'},	
		       			{field:'ms_author_name',title:'撰写人',halign:'center',width:70,sortable:true,align:'center'},
		       			{field:'prom',title:'问题',halign:'center',width:50,sortable:true,align:'center'},	
		       			{field:'fileCount',title:'附件',halign:'center',width:50,sortable:true,align:'center'},	
		       			{field:'audit_found',title:'关联疑点',halign:'center',width:100,sortable:true,align:'center',
		       				formatter:function(value,row,rowIndex){
		       						var audit_found = row.audit_found;
		       						if(null!=audit_found){
		       						var manuId = audit_found.split(',');
									return "<a href=\"javascript:void(0)\" onclick=\"go2('"+manuId[0]+"')\">"+manuId[1]+"</a>"
		       						}else{
		       							return "";
		       						}
							}},
		       			{field:'ms_date_view',title:'创建日期',halign:'center',width:80,sortable:true,align:'center'},
		       			{field:'subms_date',title:'最后修改日期',halign:'center',width:100,sortable:true,align:'center'},
					]]   
				});
				//单元格tooltip提示
				$('#manuList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});
			 //导出word底稿
			 function exportZH(){
				 var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
			        if(selectedRows.length==0){
			            $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
			            return;
			        } 
			   	   var manuType ="UNITERM";
			        var manuIdArray=new Array();
					   for(i=0;i <selectedRows.length;i++){
			                var tempformId = selectedRows[i].formId;
			                manuIdArray.push(tempformId);
					   }	 
			        var selectedValue = manuIdArray.join(",");
			        //判断模板数量
			        jQuery.ajax({
							url:'${contextPath}/operate/manuExt/pandManuTem.action?type=uniterm&project_id='+selectedRows[0].project_id,
							type:'POST',
							dataType:'text',
							async:false,
							success:function(data){
								if(data == 2) {
									// 初始化生成表格
									$('#templateList').datagrid({
										url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=uniterm&project_id="+selectedRows[0].project_id,
										method:'post',
										showFooter:false,
										rownumbers:true,
										striped:true,
										autoRowHeight:false,
										fit: true,
										fitColumns:true,
										idField:'id',
										border:false,
										singleSelect:true,
										remoteSort: false,
										columns:[[
											{field:'name',
												title:'模板名称',
												width:200,
												halign:'center',
												align:'left',
												sortable:true
											},
											{field:'operate',
												title:'操作',
												width:100,
												align:'center',
												formatter:function(value,row,index){
													var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',\''+selectedValue+'\',\''+selectedRows[0].project_name+'\',\''+selectedRows[0].project_id+'\',\''+selectedRows[0].manuType+'\');\">导出</a>';
													return link;
												}
											}
										]]
									});

									$('#templateWindow').window({
										title:'选择审计底稿模板',
										width:600,
										height:400,
										modal:true,
										collapsible:false,
										maximizable:true,
										minimizable:false
									});
								}else if(data == 0){
									showMessage1('请维护对应的模板！');
								}else{
									expManu(data,selectedValue,selectedRows[0].project_name,selectedRows[0].project_id,selectedRows[0].manuType);
								}
							},
							error:function(){
								showMessage1('出错啦！');
							}
				});
			 }
			function expManu(templateId,crudId,project_name,project_id,type){
				var h = window.screen.availHeight;
				var w = window.screen.width;
				type = "UNITERM";
				window.showModalDialog("/ais/operate/manuExt/expManu.action?templateId="+templateId+"&form_id="+crudId+"&project_name="+encodeURI(project_name)+"&project_id="+project_id+"&type="+type,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
				 $("#templateWindow").window({"onOpen":function(){
					 $("#templateWindow").window('close');
				 }}); 
				 location.reload();
		 	 }
		    //查看疑点  
		    function viewManu(id){
		       	var myurl = "/ais/operate/manu/view.action?view=view&projectview=&pageview=pageview&crudId="+id+"&project_id=<%=request.getParameter("project_id")%>&interaction=";    
		       	aud$openNewTab("底稿查看", myurl, true);
		    }
		</script>
	</body>
</html>