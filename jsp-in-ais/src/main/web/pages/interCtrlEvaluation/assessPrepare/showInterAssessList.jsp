<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>创建方案列表</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}";	
	var floginname = "${floginname}";
	var tabTitle = isView ? "查看" : "编辑";
	var projectFormId = "${projectFormId}";
	//var editUrl = '${contextPath}/intctet/prepare/assessScheme/showFrame.action?projectFormId='+projectFormId;
	var editUrl = '${contextPath}/intctet/prepare/assessScheme/edit.action?projectFormId='+projectFormId;
	var editpjfaUrl  = '${contextPath}/intctet/prepare/assessScheme/editFa.action';
 /* 	var addBtn = {   
        text:'创建',
        iconCls:'icon-add',
        id:'dvAdd',
        handler:function(){
        	var flag = iscreate("${projectFormId}");
        	if(flag== "N"){
        		aud$openNewTab('方案创建', editUrl,true);
        	}
        	if(flag== "Y"){
				showMessage1('此项目已经存在方案，不能创建了!');
				return false;
			}
        }
    }  */
/* 	var reloadBtn = {   
	         text:'刷新',
	         iconCls:'icon-reload',
	         handler:function(){
	        	 window.location.href = "${contextPath}/intctet/prepare/assessScheme/initPage.action?view=${view}";
	         }
	 }; */
	var cusToolbar = [];
	/* cusToolbar.push(addBtn);
	cusToolbar.push('-'); */
/* 	cusToolbar.push(reloadBtn);
	cusToolbar.push('-'); */
	if(isView){
		cusToolbar = [];
	}
	var gridTableId = "interAccessList";
    var g1 = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+gridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'AssessPrepare',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'formId',
        order :'desc',
        sort  :'createTime',
		winWidth:800,
	    winHeight:250,
	    myToolbar:['delete', 'export', 'search'],
    	// 删除前的校验，如果返回true可以删除，否则为false
    	beforeRemoveRowsFn:function(rows, datagridObj){
    		/*
    		if(rows){			
    			for(var i=0; i<rows.length; i++){
    				var row = rows[i];
    				alert(row.attachmentId)
    			}
    		}*/
    		return true;
    	},
        // 表格控件dataGrid配置参数; 必填
        gridJson:{	
        	queryParams:{'query_eq_projectFormId':"${projectFormId}"},
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
            toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'asname'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab("评价方案" + tabTitle, editpjfaUrl + "?formId=" + row['formId'] + (isView ? "&view=true" : ""));
                }
            },	
    		columns:[[
                {field:'formId',  title:'', width:'10px', checkbox:!isView,  align:'center', halign:'center', show:'false', hidden:isView},
                {field:'ascode',title:'编码', width:'141px',align:'center',   halign:'center', oper:'like', sortable:true},
                {field:'asname',title:'名称', width:'141px',align:'center',   halign:'center',  sortable:true, 
					oper:'like', formatter:formatterClick},
                {field:'costbudget',title:'费用预算', width:'141px',align:'center', halign:'center',  sortable:true, show:false},
                {field:'creator',   title:'创建人',   width:'141px', align:'center',  sortable:true},
                {field:'createTime',title:'创建日期', width:'141px',align:'center', halign:'center',sortable:true, oper:'like',
					formatter:formatterTime2Date},
                {field:'modifier',  title:'修改人',   width:'141px', align:'center',sortable:true, show:false},
                {field:'modifyTime',title:'修改日期', width:'141px',align:'center', halign:'center',sortable:true, show:false,
					formatter:formatterTime2Date} 
          ]]
        }
    });
    
    window.interAccessList = g1;
    
    // 按钮权限
    isView ? $('.editElement').hide() : $('.viewElement').hide();
  //  isView || apStatusCode > 1 ? g1.batchSetBtn([ {'id':gridTableId+'_remove','remove':true} ]) : null;
    function formatterClick(value){
    	var t = tabTitle || "查看";
     	return ["<label title='单击"+t+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }

    function formatterTime2Date(value){
    	var rt = value;
    	if(value && value.length > 10){
    		rt = value.substr(0,10);
    	}	
    	return rt;
    }
    
});

/* function iscreate(projectFormId){
	var result = "";
	$.ajax({
		url:'${contextPath}/intctet/prepare/assessScheme/iscreateBypId.action?projectFormId='+projectFormId,
		async:false,
		type:'POST',
		success:function(data){
			if(data.result == 0){
				result= "N";
			}else{
				result= "Y";
			}
		}
	});
	return result;
} 
 */
</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' >
	<table id='interAccessList'></table>

   <!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>