<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-分组小结</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
if("${errMsg}"){
	top.$.messager.alert("提示信息", "${errMsg}", 'error', function(){
		aud$closeTab();
	});
	setTimeout(aud$closeTab,0);
}else{
	$(function(){
		var isView = "${view}" == true || "${view}" == "true" ? true : false;
		var tabTitle = isView ? "查看" : "编辑";
		var curTabId = aud$getActiveTabId();
		var parentTabId = '${parentTabId}';
		
		var groupIds = "${groupIds}", groupNames = "${groupNames}";
		var groupIdArr = groupIds.split(',');
		var groupNameArr = groupNames.split(',');
		var treeData = [{
			'id':'root',
			'text':'当前人员所属分组',
			'children':[]
		}];
		if(groupIdArr != null && groupIdArr.length && groupNameArr != null && groupNameArr.length == groupIdArr.length ){
			$.each(groupIdArr, function(i, groupId){
				treeData[0].children.push({
					'id':groupId,
					'text':groupNameArr[i]
				});
				$('#queryGroupSelect').append("<option value='"+groupId+"'>"+groupNameArr[i]+"</option>");
			});
			$('#queryGroupSelect').combobox({
				editable:false,
				multiple:false,
				panelHeight:'auto',
				panelWidth:250
			});
		}		
		
	    //被评价单位下拉选择
	    var evUnitIds = $.trim('${evaluatedUnitId}'.replace('[','').replace(']','').replace(" ","")).split(',');
	    var evUnitNames = $.trim('${evaluatedUnitName}'.replace('[','').replace(']','').replace(" ","")).split(',');
	    var evUnitIdParam = [];
		if(evUnitIds != null && evUnitIds.length && evUnitNames != null && evUnitIds.length == evUnitNames.length ){
			$.each(evUnitIds, function(i, evUnitId){
				$('#queryUnitSelect').append("<option value='"+$.trim(evUnitId)+"'>"+$.trim(evUnitNames[i])+"</option>");
				evUnitIdParam.push($.trim(evUnitId));
			});
			$('#queryUnitSelect').combobox({
				editable:false,
				multiple:false,
				panelHeight:'auto',
				panelWidth:250
			});
		};
	    
	    
	    $('#teamTree').tree({
	    	data: treeData,
	    	lines:true,
	    	onClick:function(node){
    			var gridQueryParamJson = {};
				if(node.id != 'root'){
					gridQueryParamJson = {'query_eq_groupId':node.id};
				}
				QUtil.loadGrid({
					// 传入的查询参数； 可选
					param:gridQueryParamJson,
					// 请求类型post or get， 默认为post请求; 可选
					type:'post',
					// 表格对象
					gridObject:$('#'+gridTableId)[0],
					// 查询前和加载后执行的function
					beforeSend:function(){},
					afterSuccess:function(){}
				});
	    	}
	    });
	    var gridTableId = "teamSummaryTable";
	    var manuGrid = new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#'+gridTableId)[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'TeamSummary',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'tsId',
	        order :'asc',
	        sort  :'createTime',
			winWidth:550,
		    winHeight:250,
		    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
		    myToolbar:isView ?  ['search', 'reload'] : ['delete', 'search', 'reload'],
		    associate:true,
			//定制查询条件
			whereSql: "projectId='${projectId}' and groupId in ('"+groupIdArr.join("','")+"')",
	        gridJson:{
			    pageSize:20,
	        	singleSelect:true,
	        	checkOnSelect:false,
	        	selectOnCheck:false,
	    		border:0,
	    		//toolbar:cusToolbar,
	    		frozenColumns:[[
	    			{field:'nodeId',   title:'选择', width:'10px', halign:'center', sortable:true, show:'false', checkbox:true, hidden:false},
	    			{field:'groupName',title:'所在分组',width:'90px',align:'center', halign:'center', sortable:true, sortable:true,
	    				type:'custom', target:$('#queryCond1')[0],
	    				formatter:function(value,row,index){
	    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
	    				}		
	    			},
	    			{field:'unitName', title:'被评价单位',width:'220px',align:'left', halign:'center', sortable:true, sortable:true,
	    				type:'custom', target:$('#queryCond2')[0],
	    				formatter:function(value,row,index){
	    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
	    				}		
	    			},   
	                {field:'attachmentId', title:'附件', width:'280px',align:'left', halign:'center',  sortable:true, show:'false',
						formatter:function(value,row,index){
							return "<div id='fileItem"+index+"'></div>";
						}
	                }
	    		]],
	    		columns:[[
	                {field:'creator',   title:'创建人', width:'90px', align:'center', halign:'center', sortable:true,
	                	type:'custom', target:$('#queryCond3')[0]},
	                {field:'createDate',title:'创建时间',width:'100px',align:'center', halign:'center', sortable:true,
	                	type:'custom', target:$('#queryCond4')[0]},
	                {field:'operation', title:'操作',   width:'90px', align:'center',halign:'center',  sortable:true, show:'false',hidden:isView,
						formatter:function(value,row,index){
							window.setTimeout(function(){
								$('#fileTigger'+index).linkbutton({    
								    iconCls: 'icon-upload',
								    text:'上传附件'
								}); 
								initFileUploadPlug(index, row['attachmentId']);
							},0)
							return "<span id='fileTigger"+index+"' style='border-width:0px;'></span>";
						}
	                }
	    		]]
	        }
	    });
	    
	    //初始化上传文件控件
	    function initFileUploadPlug(index, attachmentId){
	        $('#fileItem'+index).fileUpload({
	        	fileGuid:attachmentId,
	            /*
	           	文件上传后，回显方式选择， 默认：1
	            1：在当前容器下生成datagrid表格，提供“添加、修改、删除、查看、下载”等功能，可以通过参数对按钮权限进行配置。
	            2：以文件名列表形式展示，一个文件名称就是一行
	            3：不回显，根据控件提供的方法（getUploadFiles详见使用手册），自己定义回显样式
	            */
	        	echoType:2,
	        	// 上传界面类型， 0：（默认）弹出dialog窗口和表格 1：直接选择上传文件
	        	//uploadFace:1,
	            triggerId:'fileTigger'+index,
	            isDel:!isView,
	            isEdit:!isView
	        })
	    }
	});
}
</script>
<style type="text/css">
input[class~=editElement]{
	width:75% !important;
}
</style>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div title="分组小结" region='west' style='overflow:hidden;width:200px;padding:10px;' split='true' border='0' collapsible='true'>
		<ul id='teamTree'></ul>
	</div>
	<div region="center"  border="0">	
		<table id="teamSummaryTable"></table>
	</div>
	<!-- 自定义查询条件 -->
	<div id="queryCond1">
		<select  id="queryGroupSelect" name='query_eq_groupId' style='width:250px;background: transparent;border: 1px solid #ccc;' >
			<option value="">全部</option>
		</select>
	</div>
	<div id="queryCond2">
		<select  id="queryUnitSelect" name='query_eq_unitId' style='width:250px;background: transparent;border: 1px solid #ccc;' >
			<option value="">全部</option>
		</select>
	</div>
	<div id="queryCond3">
		<input type='text' class="noborder editElement clear " readonly/>
		<input type='hidden'  name='query_eq_creatorId' class="noborder editElement clear" readonly/>
		<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
			onclick="showSysTree(this,{
                  title:'创建人选择',
				  param:{
				  	'rootParentId':'0',
                    'beanName':'UOrganizationTree',
                    'treeId'  :'fid',
                    'treeText':'fname',
                    'treeParentId':'fpid',
                    'treeOrder':'fcode'
                 },
                 type:'treeAndUser',
                 singleSelect:true
		})"></a>
	</div>
	<div id="queryCond4">
 		<input type='text'  name='query_mtq_createDate' class="easyui-datebox noborder clear" editable="false"/> 至 
 		<input type='text'  name='query_ltq_createDate' class="easyui-datebox noborder clear" editable="false"/>
	</div>
</body>
</html>