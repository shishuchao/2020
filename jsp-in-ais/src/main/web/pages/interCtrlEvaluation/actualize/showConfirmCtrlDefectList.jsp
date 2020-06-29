<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">
//认定控制缺陷初始化
var ccdGridTableId = "confirmCtrlDefectTable";
$(function(){
	var curTabId = aud$getActiveTabId();
	var parentTabId = '${parentTabId}';

	var defectParam = "&manuId=${manu.manuId}&projectId=${manu.projectId}&groupId=${groupId}";
	//alert(param)
	var defectEditUrl = "${contextPath}/intctet/evaluationActualize/editConfirmCtrlDefect.action?view=${view}"+defectParam;
	
	var addRowBtn = {   
	         text:'新增',
	         iconCls:'icon-add',
	         handler:function(){
	        	aud$openNewTab('控制缺陷添加', defectEditUrl, true);
	         }
	     };
	
	var cusToolbar = isView ? [] : [addRowBtn,"-"];
	
	var defectGrid = new createQDatagrid({
        // 表格dom对象，必填
        gridObject:$('#'+ccdGridTableId)[0],
        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
        boName:'ConfirmCtrlDefect',
        // 对象主键,删除数据时使用-默认为“id”；必填
        pkName:'cdId',
        order :'asc',
        sort  :'createTime',
		winWidth:500,
	    winHeight:250,
	    //自定义显示哪些按钮：myToolbar:['delete', 'export', 'search', 'reload'],
	    myToolbar:isView ? ['export', 'reload'] : ['delete', 'export', 'reload'],
	    associate:true,
		//定制查询
		whereSql: " manuId='${manu.manuId}' and projectId='${manu.projectId}' ",
        gridJson:{
			title:'认定控制缺陷',
		    pageSize:10,
        	singleSelect:true,
        	checkOnSelect:false,
        	selectOnCheck:false,
    		border:0,
    		fit:true,
    		toolbar:cusToolbar,
            onClickCell:function(rowIndex, field, value){
                if(field == 'defectCode'){		
                    var rows = $(this).datagrid('getRows');
                    var row = rows[rowIndex];
                    $(this).datagrid('unselectRow',rowIndex);
                    $(this).datagrid('uncheckRow',rowIndex);
                    aud$openNewTab("认定控制缺陷" + tabTitle, defectEditUrl+"&cdId="+row['cdId'], true);
                }
            },	
    		columns:[[
				{field:'cdId',       title:"选择",        width:'10px', align:'center',  halign:'center',  checkbox:true, hidden:isView},
    			{field:'defectCode', title:"内控缺陷编号",  width:'200px', align:'center', halign:'center',  sortable:true,formatter:formatterClick},
				{field:'defectName', title:"内控缺陷简述",  width:'60%', align:'left',   halign:'center',  sortable:true}
          ]]
        }
    });
	window.aud$defectGrid = defectGrid;
	
    function formatterClick(value){
    	var t = tabTitle || "查看";
    	return  ["<label title='单击"+t+"' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
    }
	
});
</script>

<div style="height:300px;padding:0px;margin:0px;">
	<table id="confirmCtrlDefectTable"></table>
</div>
