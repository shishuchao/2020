<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控-准备-评价方案列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script> 
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
var busBaseUrl  = "${contextPath}/intctet/prepare/assessScheme/";
var busBaseUrl2 = "${contextPath}/operate/template/";
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	var titleSuffix = isView ? "查看" : "编辑";
	if("${errorMsg}"){
		isView = true;
		aud$loadClose()
		top.$.messager.alert("提示", "${errorMsg}", "error", function(){			
			aud$closeTab();
		});
		return;
	}
	
	// 表格查询参数
	var globalParams = {	
		'projectId':'${projectId}',
		'query_eq_project_id':'${projectId}'
    };
	
    var selectTempateBtn = {
	    text:'创建方案',
	    iconCls:'icon-add',
	    handler:aud$templateSelect
    }
    
    function aud$templateSelect() {
    	var data = $('#'+gridTableId).datagrid('getData');
    	if(data.rows.length){
    		top.$.messager.confirm("确认", "评价方案已经生成，点击【确定】已有方案删除后，将重新生成评价方案", function(r){
    			r ? showSelectTemplate() : null;	
    		});
    	}else{
    		showSelectTemplate();
    	}
		
    	function showSelectTemplate(){    		
	    	var winUrl = busBaseUrl + "showEvaProgTemplateList.action?projectId=${projectId}";
	        new aud$createTopDialog({
	            title:'评价方案模板选择',
	            url  :winUrl
	     	}).open();
    	}
    }
    var returnBtn = {
   	    text: '回传方案',
   	    iconCls: 'icon-edit',
   	    handler: function(){
   	    	$('#sendBack_div').dialog('open');
   	    }
   	}
        
    
	var cusToolbar = isView ? ['reload'] : [selectTempateBtn,'-',returnBtn,'-','reload'];
	
	var gridTableId = "busTable";
    var busGrid = new createQDatagrid({
    	serviceInstance:'assessPrepareService',
    	serviceMethod:'queryCustomParam',
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'AudProgramme',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'audTemplateId',
        order :'asc',
        sort  :'string(templateName)',
		winWidth:830,
	    winHeight:293,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:[],
    	// 是否关联查询
    	associate:false,
    	// 默认true, 问题表字段众多，只查指定字段可以提高3-5倍的速度
    	//selectAll:false,
    	// 添加不在columns中而又要用到field
    	//selectColum:['source'],
	    // 全局基础查询参数
        gqueryParams:globalParams,
	    // 初始化时只执行一次的参数
	    onceParams:{ },
		// 默认删除按钮单击前执行, return ture:继续； false：停止；可选
		beforeRemoveRowsFn:function(rows, gridObj){
			//return checkRows(rows);
			return true;
		},
		//删除方法removeDatagridRows，删除数据成功后调用 afterRemoveRowsFn(rows, gridObject)
		afterRemoveRowsFn:function(rows, gridObject){},
        gridJson:{
		    pageSize:20,
        	singleSelect :true,
           	checkOnSelect:false,
    		border:0,
    		toolbar:cusToolbar,
    		//idField:'projectId',
            onClickCell:function(rowIndex, field, value){
                var rows = $(this).datagrid('getRows');
                var row = rows[rowIndex];
                $(this).datagrid('unselectRow',rowIndex);
                $(this).datagrid('uncheckRow',rowIndex);
 				if(row && field == 'programmeName'){					
 					var viewUrl = '${contextPath}/operate/task/mainReadyView.action?interCtrl=true&project_id=${projectId}';
 					var editUrl = '${contextPath}/operate/task/mainReadyEdit.action?interCtrl=true&project_id=${projectId}';
 					//var editUrl = busBaseUrl2 + 'mainView.action?interCtrl=true&audTemplateId='+row['audTemplateId'];
 					var winUrl = isView ? viewUrl : editUrl;
 			        new aud$createTopDialog({
 			            title:titleSuffix+'评价方案['+row['templateName']+']',
 			            url  :winUrl
 			     	}).open();
 				}
            },
            onLoadSuccess:function(data){
            	if(data && data.rows && data.rows.length){
        			parent.$('#qtab').tabs('enableTab',1).tabs('enableTab',2).tabs('enableTab',3);
            	}
            },
            columns:[[
    			{field:'audTemplateId', title:"选择", width:'10px', align:'center', halign:'center', checkbox:true, show:'false',hidden:isView},
    			{field:'programmeName', title:"评价方案名称",width:'200px',align:'left', halign:'center', sortable:true, show:false,
    				formatter:function(value,row,index){
    					return value ? "<label title='"+titleSuffix+"["+value+"]' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
    				}
    			},
    			{field:'templateName', title:"方案模板名称",width:'200px',align:'left', halign:'center', sortable:true, show:false,
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"'>"+value+"</label>" : "";
    				}
    			},
    			{field:'proVer', title:"方案版本",width:'80px',align:'center', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'typeName', title:"类别名称",width:'150px',align:'left', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'typeName2', title:"子类别名称",width:'150px',align:'left', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'proAuthorName', title:"编制人",width:'100px',align:'center', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
				{field:'proDate', title:'编制日期', width:'100px', halign:'center', align:'center',  sortable:false, show:false, 
					 formatter:function(value,row,index){ 
						 if(null!=value){
							  var unixTimestamp = value.substring(0,10);
		                         return unixTimestamp ;
						 }else{
							 return '';
						 }
                      } 
				}
            ]]
        }
    });
    window.aud$busGid = busGrid;	
    
    if(!isView){    	
	    $('#sendBack_div').dialog({
			title:'回传评价方案',
	        width:'600px',
	        height:'200px',
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
	    });
	    $('#saveRtProg').bind('click', aud$returnProg$save);
	    function aud$returnProg$save(){
	    	var url = busBaseUrl + "returnProgramme.action";
			aud$saveForm("retrunProgForm", url, function(data){
				if(data){
					data.msg ? showMessage1(data.msg) : null;
					if(data.type && data.type == 'info'){
						$('#sendBack_div').dialog('close');
					}
				}
			});
	    }
    }else{
    	$('#sendBack_div').remove();
    }
});
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="center"  border="0">	
		<table id="busTable"></table>
	</div>
	
	
	 <div id="sendBack_div"  style='overflow:hidden;padding:0px;'>
		<form id="retrunProgForm" name="retrunProgForm" style='margin:0px;padding:0px;'>
			<table class="ListTable" align="center" '>
				<tr class="noTopBorder">
					<td class="EditHead">
						<font color=red>*</font>方案名称
					</td>
					<td class="editTd" colspan='3'>
						<input type="text" id="prog_title" name="prog_title" title="方案名称"
							class="editElement clear required noborder" style="width:90%;"/>
						<input type="hidden" id="prog_projectId" name="prog_projectId" value="${projectId}"
							class="editElement clear required  noborder" style="width: 150px;"/>
					</td>
				</tr>
			</table>
		</form>
		<div style="position:absolute;bottom:10px;right:10px;z-index:999999;">
			<a id='saveRtProg' class="easyui-linkbutton" iconCls="icon-save" onclick="">保存</a>
		</div>
	</div>
	
</body>
<script type="text/javascript">
    //重新设置页面的topDialogTargetId
    resetTopDialogTargetId();
</script>
</html>