<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控-准备-评价方案模板选择列表</title>
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
$(function(){
	var busBaseUrl  = "${contextPath}/intctet/prepare/assessScheme/";
	var busBaseUrl2 = "${contextPath}/operate/template/";
	var isView = "${view}" == true || "${view}" == "true" ? true : false;

	// 表格查询参数
	var globalParams = {	
		'projectId':'${projectId}',
		'templateSelect':'1'
    };
	
    var addBtn = {
	    text:'创建方案',
	    iconCls:'icon-add',
	    handler:aud$create
    }
    
    function aud$create() {
        var rows = $('#' + gridTableId).datagrid('getChecked');
        if (rows == null || rows.length == 0) {
            showMessage1("请选择要创建的记录!");
            return false;
        }
        var row = rows[0];
        var audTemplateId = row['audTemplateId'];
        $.ajax({
            url: busBaseUrl + 'genProgramme.action',
            type: 'post',
            data: {
                'projectId': '${projectId}',
                'audTemplateId': audTemplateId
            },
            success: function(data) {
            	data.msg ? showMessage1(data.msg) : null;
                if(data.type == 'info'){   
                	try{
    	               	// 刷新评价方案grid
    	            	aud$TopDialogCallParent(refreshParentGrid, 'fa');
    	              	//启用确定评价范围
    	                aud$enabledFw();
                	}catch(e){}
					window.setTimeout(function(){
						closeWin();
					},0)
                }
            }
        })
    }
    
  	//启用确定评价范围
    function aud$enabledFw(){
  		// 第二参数为null， pWin表示父页面
    	aud$TopDialogCallParent(function(pWin){
			pWin.$('#qtab').tabs('enableTab',1);
			pWin.$('#qtab').tabs('select',1);
    	}, null);
    }
    
    var closeBtn = {
	    text:'关闭',
	    iconCls:'icon-cancel',
	    handler:closeWin
    }
    
    function closeWin(){
    	aud$closeTab();
    }
	
	var cusToolbar = isView ? ['reload','-',closeBtn] : [addBtn,'-','reload','-',closeBtn];
	
	var gridTableId = "busTable";
    var busGrid = new createQDatagrid({
    	serviceInstance:'assessPrepareService',
    	serviceMethod:'queryCustomParam',
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'AudTemplate',
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
    	selectAll:false,
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
 				if(row && field == 'templateName'){
 					var titleSuffix = "查看";
 					var winUrl = busBaseUrl2 + 'mainView.action?interCtrl=true&audTemplateId='+row['audTemplateId'];
 			        new aud$createTopDialog({
 			            title:titleSuffix+'评价方案['+row['templateName']+']',
 			            url  :winUrl
 			     	}).open();
 				}
            },
            onLoadSuccess:function(data){},
            columns:[[
    			{field:'audTemplateId', title:"选择", width:'10px', align:'center', halign:'center', 
    				checkbox:true, show:'false',hidden:isView},
    			{field:'templateName', title:"方案模板名称",width:'25%',align:'left', halign:'center', sortable:true, show:false,
    				formatter:function(value,row,index){
    					return value ? "<label title='查看["+value+"]' style='color:blue;cursor:pointer;'>"+value+"</label>" : "";
    				}
    			},
    			{field:'proVer', title:"方案版本",width:'80px',align:'center', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'typeName', title:"类别名称",width:'150px',align:'center', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'typeName2', title:"子类别名称",width:'150px',align:'left', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'atCompany', title:"所属单位",width:'250px',align:'left', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
    			{field:'proAuthorName', title:"编制人",width:'100px',align:'center', halign:'center', sortable:true, show:false,    				
    				formatter:function(value,row,index){
    					return value ? "<label title='"+value+"' >"+value+"</label>" : "";
    				}
    			},
				{field:'proDate', title:'编制日期', width:'120px', halign:'center', align:'center',  sortable:false, show:false, 
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
   
});

//刷新评价方案列表
function refreshParentGrid(targetWin){
	if(targetWin && targetWin.aud$busGid){
		targetWin.aud$busGid.refresh();
	}
}
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class="easyui-layout" fit="true" border="0">
	<div region="center"  border="0">	
		<table id="busTable"></table>
	</div>
</body>
</html>